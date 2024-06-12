import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:excel_karoor/info/info.dart';
import 'package:excel_karoor/view/pages/splash_screen/splash_screen.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: Container(
                        //height: 100,width: 50,
                        // height: screenSize.width / 10,
                        // width: screenSize.width / 4.5,
                        // color: Colors.amber,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                height: 50,
                                width: 50,
                                color: Colors.transparent,
                                child: Image.asset(
                                  officialLogo,
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //     left: screenSize.width / 70,
                            //   ),
                            //   child: Container(
                            //     height: screenSize.width / 15,
                            //     width: screenSize.width / 15,
                            //     color: Colors.transparent,
                            //     child: Image.asset(
                            //         "assets/images/leptonlogo.png"),
                            //   ),
                            // ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    companyNameSmall,
                                    style: GoogleFonts.dmSerifDisplay(
                                        color: const Color.fromARGB(
                                            255, 38, 93, 15),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  nameInSmall,
                                  style: GoogleFonts.dmSerifDisplay(
                                      color:
                                          const Color.fromARGB(255, 43, 97, 19),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: SizedBox(
                    height: 50,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 80),
                      child: SizedBox(
                        height: 20,

                        width: 90,

                        // child: const HomePageDropDown()),
                        child: DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSelectedItems: true,
                            disabledItemFn: (String s) => s.startsWith('I'),
                          ),
                          items: const [
                            "About",
                            "Tution Center",
                            "Syllabus",
                            "Mock Test",
                            "Previous Qn"
                          ],
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                //labelText: "Menu mode",
                                // hintText: "country in menu mode",
                                ),
                          ),
                          onChanged: print,
                          selectedItem: "About",
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0.1,
                      0.4,
                      0.8,
                      0.9,
                    ],
                    colors: [
                      Color.fromARGB(255, 6, 152, 225),
                      Color.fromARGB(248, 3, 201, 231),
                      Color.fromARGB(255, 124, 196, 232),
                      Colors.white70
                    ]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 300),
                    child: SizedBox(
                      height: 30,
                      width: 100,
                      child: InkWell(
                        onTap: () =>  const SplashScreen(),
                        child: Text(
                          'LOGIN',
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 5,
                      // top: screenSize.width / 15,
                    ),
                    child: Text(
                      nameInCapital,
                      style: GoogleFonts.spectral(
                          fontSize: 35,
                          //fontSize: screenSize.width / 37,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Smart Pathways to the Parallel World",
                      style: GoogleFonts.spectral(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 35),
                          child: Container(
                            height: 200,
                            width: 300,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/book-removebg-preview.png"),
                                    fit: BoxFit.fitWidth)),
                            child: const Align(
                                alignment: Alignment.center,
                                child: Text("വിദ്യാവീചി",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 30),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(196, 150, 221, 215),
                        ),
                        onPressed: () {},
                        child: Text(
                          'What We Provide',
                          style: GoogleFonts.spectral(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      "Tution Center Solutions",
                      style: GoogleFonts.robotoSlab(
                          fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 15),
                    child: Text(
                      "For a demo, please register your school. Our team will contact you to onboard you to the Vidyaveechi app",
                      style: GoogleFonts.spectral(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 20, bottom: 40),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 130,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 75, 131, 252),
                            ),
                            onPressed: () {},
                            child: Text(
                              'REGISTER',
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        SizedBox(
                          height: 40,
                          width: 130,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 75, 131, 252),
                              // backgroundColor: const Color.fromARGB(255, 102, 206, 169),
                            ),
                            onPressed: () {},
                            child: Text(
                              'QUERY',
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
