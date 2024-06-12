/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// const {onRequest} = require("firebase-functions/v2/https");
const {onDocumentUpdated} = require("firebase-functions/v2/firestore");

const functions = require("firebase-functions/v1");
// eslint-disable-next-line no-unused-vars
const logger = require("firebase-functions/logger");
const admin = require("firebase-admin");
// eslint-disable-next-line no-unused-vars
const fetch = require("node-fetch");
const {format} = require("date-fns");
const {google} = require("googleapis");
const moment = require("moment-timezone");
const axios = require("axios");

admin.initializeApp();
const db = admin.firestore();

const dateConvert = (dateTime) => format(dateTime, "dd-MM-yyyy");
const timeConvert = (dateTime) => format(dateTime, "hh:mm:a");

let pushNotificationKey = "";

// let attendanceTimer = 1;
let schoolBatchYear = "";
let currentMonth = "";
let currentDate = "";
// let subjectName = "";
let subjectID ="";

const sendPushMessage = async (token, body, title) => {
  const url = "https://fcm.googleapis.com/v1/projects/excel-karoor-48ae3/messages:send";
  const serverKey = pushNotificationKey;
  const message = {
    message: {
      token: token,
      notification: {
        title: title,
        body: body,
      },
      android: {
        notification: {
          title: title,
          body: body,
          click_action: "TOP_STORY_ACTIVITY",
        },
        data: {story_id: "story_12345"},
      },
      apns: {
        payload: {
          aps: {category: "NEW_MESSAGE_CATEGORY"},
        },
      },
      data: {
        click_action: "FLUTTER_NOTIFICATION_CLICK",
        status: "done",
        body: body,
        title: title,
      },
    },
  };

  try {
    const response = await axios.post(url, message, {
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${serverKey}`,
      },
    });
    if (response.status === 200) {
      console.log("Notification sent successfully!");
    } else {
      console.log(`Failed to send notification: ${response.status}`);
      console.log(`Response body: ${response.data}`);
    }
  } catch (error) {
    console.error("Exception caught sending notification:", error);
  }
};

const fetchParents = async (parentID, studentName) => {
  try {
    const parentDoc = await db.collection("SchoolListCollection")
        .doc("OpIIV77nVYgx2PE21wa1n7pWIjw1")
        .collection("AllUsersDeviceID")
        .doc(parentID)
        .get();
    const parentData = parentDoc.data();
    await sendPushMessage(
        parentData["devideID"],
        // eslint-disable-next-line max-len
        `Sir/Madam, your child ${studentName} was present on ${dateConvert(new Date())} at ${timeConvert(new Date())} \nസർ/മാഡം,${dateConvert(new Date())} തീയതി ${timeConvert(new Date())}നിങ്ങളുടെ കുട്ടി ഹാജരായി`,
        "Attendance Notification from Lepton Schools",
    ).then(() => {
      db.collection("Attendance")
          .doc("OpIIV77nVYgx2PE21wa1n7pWIjw1")
          .update({CardID: "", AttendanceTaken: "false"});
    });
  } catch (error) {
    console.error("Error fetching parents data:", error);
  }
};

const fetchCardDataStudents = async (cardID) => {
  try {
    const studentsSnapshot = await db.collection("SchoolListCollection")
        .doc("OpIIV77nVYgx2PE21wa1n7pWIjw1")
        .collection("AllStudents")
        .get();

    for (const studentDoc of studentsSnapshot.docs) {
      const studentData = studentDoc.data();
      if (studentData["cardID"] === cardID) {
        await fetchParents(studentData["parentId"], studentData["studentName"]);
      }
    }
  } catch (error) {
    console.error("Error fetching card data students:", error);
  }
};

const getAccessToken = async () => {
  const credentials = {
    "type": "service_account",
    "project_id": "excel-karoor-48ae3",
    "private_key_id": "39844e0e85d289b312a0b515f35faea08fe082c3",
    // eslint-disable-next-line max-len
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC1ucTpGRsbgwuq\nieiyJGYgaZiHSGRGwRjJdkw7h1ZLgyQaf2JpTUfkRxrMKS0LfcZN6z40XvhWt0hL\n8cpwYL7cDPYrYduMiYHyQg5oJYbBXABwDzr+VD5H9MdzQyJD8SinB5tkcpSz+HPB\n/XwmLVdhVJN252QObzCc0QSOtuEZgCrNdXfKrtpB5RclpuolXf3O3kcm63vGj+xw\npa73Hjt4AoRCDVNZKqdSTIXXv0Fk43jTEIW/+3xAsO42jw0xkPo+qxSnmKLGL04e\n+ISpPDqgNjh89c5EyHhsFGl6rh5Zyj0dyZGtFJEAyQNbMl1Kat8ouDwiwD1qoBdV\nr1LMI6ytAgMBAAECggEACBKf5rhQy0tqV0HCbozOD0k27LuQiNFx0nFI4v7DcfNP\nb/CSD0TO7sXMhklF+6leB9QYHVIit2dzn2a3AYBVZN0b38LRx/p2eqvoi+6EKqQg\nTi9psCakkE8VanoO/vRVmVCYh0EieKQ5hY1HLe2nC2crGIXK8haKaEz4u4ZFlaZY\nEQ471Lfjyo4ceJGuICLFlNwysRh0LkaFNZ3f3mpeQU6iyB9TrrdHlxBd9g8UzMM6\ns0qJGUvlM1MkMy2vcgx78zgGK3G6H1MpsifrKGHkScb0/RTcIFlFAmJb5SmQnrkU\nSZYUx+1rsNyg9wzX11c9Z2Lrs12OG7F2ZET522Uz2QKBgQDiNfGJQWcY6eOLHET6\n7utqROh2SxnfbxmWMT4J5d4zAeV7goWMMkP38ijz/AH88V3uAY1qkUqm46DQTkPo\nx6jgccbGaK/uteKa/cJ9H1yi2dtZ1bqUhjAKAx9IfdH8VAeYaWal+nKo9abE5er+\n4LPZ6bMqTeFTNva38GDoqTsZhwKBgQDNqCMv38WDG3Vo+tTFfYj+nTUbmsP0+MkY\n2+M0mxtk752zVCBUA/7PaUmkZ2a5pjoGwc9lpXzZ4yipkwJlkMdj3YrnLWPnu+OP\nbjcHGgxwHgB3ed8katHgz5nFo5F34K3rdfsR3A9i46dFdlnQl2c61GrbsuCLPhNL\nT+gM5UNFKwKBgQDUEb5e7vG4aYzo3ZfNqC8LcY59V+rpjT5vj7qZjObC6wQ4xiRt\nSrJtwJikI525hI6KkuoA/jT+QGiC4NzJXmT0BbZUS9Cj+eB3bW7n3n76LUN29Of2\nVdazjDnHvC0gYaa9PBL/h8v2mlW+Qc4NJJt3r6BICLs1SFIEH1a6x+ygAQKBgQCJ\ntYi6SfEL9ZsNDMjk5UaSl9oz/dIxe1XNG5BsbWBOmlTS/AYZvAMoB6yUNdkHf1Nj\nquuheMq9a+qSgiocsHGTYYndevtm9N1P8dFPJBYoDS7q0eSlkhGvo9OoD/scdop/\nHKVeNCjpYt9jF/jUQE2TiyFys7jABHUO/Ra5a9s7uQKBgQCcYzauLqIu5xPtq5WH\nW1zkKRTJ1pg2s44tkXnZqyB7sfV95E8hObuoTPjDzPfPHH6ZpyS7RMFbtKCDhoLY\nHQIDFq7qKLcLJwLPIw7wBexR/r1ksnfALYZ2kyg3KJxfIfrBsRIu180MZSAPOvpY\nUgWw/rXgPsce1XvPWIaMbKaxwg==\n-----END PRIVATE KEY-----\n",
    // eslint-disable-next-line max-len
    "client_email": "firebase-adminsdk-kj4cq@excel-karoor-48ae3.iam.gserviceaccount.com",
    "client_id": "103096260570888221439",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-kj4cq%40excel-karoor-48ae3.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com",
  };

  const client = await google.auth.getClient({
    credentials: credentials,
    scopes: ["https://www.googleapis.com/auth/firebase.messaging"],
  });

  const accessTokenResponse = await client.getAccessToken();
  await db.collection("PushNotification")
      .doc("key")
      .update({key: accessTokenResponse.token});
  return accessTokenResponse.token;
};

exports.attendanceListener =
 onDocumentUpdated("Attendance/OpIIV77nVYgx2PE21wa1n7pWIjw1", async (event) => {
   getAccessToken();
   try {
     const pushNotificationCollection = await db.collection("PushNotification")
         .doc("key")
         .get();
     pushNotificationKey = pushNotificationCollection.data()["key"];
     const attendanceDoc = await db.collection("Attendance")
         .doc("OpIIV77nVYgx2PE21wa1n7pWIjw1")
         .get();

     const cardIDvalue = attendanceDoc.data()["CardID"];
     if (cardIDvalue!== "") {
       await db.collection("Attendance")
           .doc("OpIIV77nVYgx2PE21wa1n7pWIjw1")
           .update({CardID: cardIDvalue});
       await fetchCardDataStudents(cardIDvalue);
     }
   } catch (error) {
     console.error("Error fetching attendance document:", error);
   }
 });

exports.yourV1CallableFunction = functions
    .runWith({
      enforceAppCheck: true,
      consumeAppCheckToken: true,
    })
    .https.onCall((data, context) => {
      // Your function implementation here
    });

exports.attendeceTimerFunction = functions.pubsub.schedule("every 1 minutes")
    .onRun(async (context) => {
      const now = moment().tz("Asia/Kolkata")
          .format("YYYY-MM-DD HH:mm:ss.SSSSSS");
      const expiredDocs = await db.collection("ClassAttendenceNotifer")
          .doc("OpIIV77nVYgx2PE21wa1n7pWIjw1")
          .collection("ClassCollections").where("exdateTime", "<", now).get();
      expiredDocs.forEach((doc) => {
        const exTime = doc.data().exTime;
        // Additional if condition to further check or process the document
        if (moment(exTime).isBefore(now)) {
          db.collection("CloundFunction").doc("cloud").set({cloud: now});
          db.collection("ClassAttendenceNotifer")
              .doc("OpIIV77nVYgx2PE21wa1n7pWIjw1")
              .collection("ClassCollections").doc(doc.ref)
              .get().then((getdocDeatils)=>{
                currentDate=getdocDeatils.data()["date"];
                currentMonth=getdocDeatils.data()["month"];
                subjectID=getdocDeatils.data()["subjectID"];
                // subjectName=getdocDeatils.data()["subjectName"];
              });
          db.collection("SchoolListCollection")
              .doc("OpIIV77nVYgx2PE21wa1n7pWIjw1").get().then((doc)=>{
                schoolBatchYear = doc.data()["batchYear"];
              }).then(() => {
                db.collection("SchoolListCollection")
                    .doc("OpIIV77nVYgx2PE21wa1n7pWIjw1")
                    .collection(schoolBatchYear)
                    .doc(schoolBatchYear).collection("classes").doc(doc.ref)
                    .collection("Attendence").doc(currentMonth)
                    .collection(currentMonth)
                    .doc(currentDate).collection("Subjects").doc(subjectID)
                    .collection("AttendenceList")
                    .get().then((attendenceResults)=>{
                    // eslint-disable-next-line max-len
                      for (let index = 0; index < attendenceResults.length; index++) {
                        db.collection("ClassAttendenceNotifer")
                            .doc("OpIIV77nVYgx2PE21wa1n7pWIjw1")
                            .collection("ClassCollections").doc(doc.ref)
                            .collection("AbsentStudents")
                            .doc(attendenceResults.data()["uid"])
                            .set({docid: attendenceResults.data()["docid"]});
                      }
                    });
              });
        }
      });
    },
    );
