import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/home/parent_home/graph_std/attendance_std_g.dart';
import 'package:excel_karoor/view/home/parent_home/graph_std/exm_std.dart';
import 'package:excel_karoor/view/home/parent_home/graph_std/homework_std_g.dart';
import 'package:excel_karoor/view/home/parent_home/graph_std/pie%20chart/pie_chart.dart';
import 'package:excel_karoor/view/home/parent_home/graph_std/project_assignmnt_chart.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';

class ParentCaroselWidget extends StatelessWidget {
  const ParentCaroselWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, right: 10, left: 10),
      child: Container(
        height: 248,
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: cblack,
          ),
        ], color: cWhite, borderRadius: BorderRadius.all(Radius.circular(20))),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 12, left: 8, right: 8, bottom: 10),
                    child: CarouselSliderWidget(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> quicktext = ['Attendence', 'Home work', 'Exam', 'Chat'];
List<String> image = [
  'assets/flaticons/icons8-attendance-100.png',
  'assets/flaticons/icons8-homework-100.png',
  'assets/flaticons/icons8-books-48.png',
  'assets/flaticons/icons8-chat-100.png'
];

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return CarouselSlider(
      items: [
        CaroselmageWidget(
          sliderWidget: graphList[0],
          slidertext: 'Homework', slidersecondtext: 'Average', count: '100/200',clicktext: '',
        ),
        CaroselmageWidget(
          sliderWidget: graphList[1],
          slidertext: 'Exam Result',
           slidersecondtext: 'Average', count: '100/200',clicktext: '',
        ),
        GestureDetector(
          onTap: (){
           _settingModalBottomSheet(context);
        
        },
          child: CaroselmageWidget(
            sliderWidget: graphList[2],
            slidertext: 'Attendance',
             slidersecondtext: 'Average', count: '100/200',
             clicktext: 'Click here',
          ),
        ),
        // CaroselmageWidget(
        //   sliderWidget: graphList[3],
        //   slidertext: 'Assignment & Project',
        // ),
      ],
      options: CarouselOptions(
        height: 220,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
    );
  }
}

class CaroselmageWidget extends StatelessWidget {
 final Widget sliderWidget;
 final String slidertext;
 final String slidersecondtext;
 final String count;
 final String? clicktext;
  const CaroselmageWidget({
    required this.sliderWidget,
    required this.slidertext,
    required this.slidersecondtext,
    required this.count,
    this.clicktext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       
        Expanded(
                        // GooglePoppinsWidgets(text: slidersecondtext, fontsize: 18,color: ),
                        //     GooglePoppinsWidgets(text: count, fontsize: 18,color: Colors.black,fontWeight:FontWeight.bold ,)
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GooglePoppinsWidgets(
                  text: slidertext,
                  fontsize: 15,
                  color: cblack,
                  fontWeight: FontWeight.w600,
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GooglePoppinsWidgets(
                  text: slidersecondtext,
                  fontsize: 24,
                  color: Colors.amber,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GooglePoppinsWidgets(
                  text: count,
                  fontsize: 22,
                  color: cblack,
                  fontWeight: FontWeight.bold,
                ),
              ),
               Padding(
                 padding: const EdgeInsets.only(top: 10),
                 child: GooglePoppinsWidgets(
                    text: clicktext!,
                    fontsize: 12,
                    color: cblack,
                    fontWeight: FontWeight.bold,
                  ),
               ),
            ],
          ),
        ),
         Expanded(
          child: sliderWidget,
        ),
      ],
    );
  }
}

final List<Widget> graphList = [
  const HomeWorkGraph(),
  const ExamResultGraph(),
const AttendanceGraphOfStudent() , const StdProjectAndAssignmnetGraph()
];
void _settingModalBottomSheet(context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
          return SingleChildScrollView(
            child: SizedBox(height: 430,
              child:  Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    child: GooglePoppinsWidgets(text: 'Attendance', fontsize: 20,fontWeight: FontWeight.bold,),
                  ),
                   const Padding(
                     padding: EdgeInsets.only(top: 10,),
                     child: ATP(presentPercentage: 21.2,),
                   ),
                  Wrap(
                  children: <Widget>[
                   Card(
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(color: Colors.green[50],
                         child: ListTile(shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                         leading:   const Icon(Icons.check),
                                         title:  const Text('Present'),
                                         trailing: GooglePoppinsWidgets(text: '21%', fontsize: 18),
                                         onTap: () => {}          
                                  ),
                       ),
                     ),
                   ),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Card(
                                 child: Container(color:Colors.red[50],
                                   child: ListTile(
                                                   leading:  const Icon(Icons.close),
                                                   title:  const Text('Absent'),
                                                    trailing: GooglePoppinsWidgets(text: '79%', fontsize: 18),
                                                   onTap: () => {},          
                                                             ),
                                 ),
                               ),
                             ),
                  ],
                            ),
                ],
              ),
            ),
          );
      }
    );
}
