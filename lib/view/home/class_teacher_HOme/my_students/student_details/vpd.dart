import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';

class Vpd extends StatefulWidget {
  const Vpd({super.key, required this.studentID});

 final String studentID;

  @override
  State<Vpd> createState() => _VpdState();
}

class _VpdState extends State<Vpd> {
  DocumentSnapshot? document;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDocument();
  }

  Future<void> fetchDocument() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('Parents')
        .where('studentID', isEqualTo: widget.studentID)
        .get();

    if (snapshot.docs[0].exists) {
      setState(() {
        document = snapshot.docs[0];
        isLoading = false;
      });
    } else {
      setState(() {
        document = null;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Page'),
      ),
      body: Center(
        child: isLoading
            ? const Text(
                'Document not found') // Show a loading indicator while fetching the document
            : document != null
                ? Text(document!['parentName']
                    .toString()) // Display the document data
                : const Text(
                    'Document not found'), // Display a message when the document doesn't exist
      ),
    );
  }
}
