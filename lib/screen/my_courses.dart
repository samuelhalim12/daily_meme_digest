import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:daily_meme_digest/screen/course_detail.dart';

class CourseList extends StatelessWidget {
  // List<Widget> courses() {
  //   List<Widget> temp = [];
  //   int i = 0;
  //   while (i < 15) {
  //     Widget w = ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => CourseDetail(2)));
  //                     },
  //                     child: const Text("Course 2")),
  //     temp.add(w);
  //     i++;
  //   }
  //   return temp;
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            margin: EdgeInsets.only(top: 20, bottom: 20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://placekitten.com/420/320?image=12'),
                fit: BoxFit.cover,
              ),
              // border: Border.all(
              //   color: Colors.indigo,
              //   width: 10,
              // ),
              // boxShadow: [BoxShadow(blurRadius: 30, color: Colors.black)],
              shape: BoxShape.circle,
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(50),
              //     topRight: Radius.circular(50))),
            ),
          ),
          // Divider(
          //   height: 200,
          // ),
          const Text("Samuel Halim"),
          const Text("160419077"),
          const Text("Teknik Informatika"),
          const Text("Gasal 2022-2023"),
          // Container(
          //   height: 500,
          //   child: GridView.count(crossAxisCount: 3, children: courses()),
          // ),

          Container(
            height: 300,
            child: GridView.count(
                crossAxisCount: 1,
                // crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                children: [
                  new SizedBox(
                    width: 60,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CourseDetail(1)));
                        },
                        child: const Text("Tugas Akhir (-)")),
                  ),
                  new SizedBox(
                    width: 200.0,
                    height: 60.0,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CourseDetail(2)));
                        },
                        child: const Text("Emerging Technology (B)")),
                  ),
                  new SizedBox(
                    width: 200.0,
                    height: 60.0,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CourseDetail(3)));
                        },
                        child: const Text("Big Data Analytics (A)")),
                  ),
                  new SizedBox(
                    width: 200.0,
                    height: 60.0,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CourseDetail(4)));
                        },
                        child:
                            const Text("Artificial Intelligence for Game (Z)")),
                  ),
                  new SizedBox(
                    width: 200.0,
                    height: 60.0,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CourseDetail(5)));
                        },
                        child: const Text("Internet of Things (A)")),
                  ),
                ]),
          ),
        ],
      )),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: const Text("Course List"),
  //       ),
  //       body: SingleChildScrollView(
  //           child: Column(
  //         children: [
  //           Container(
  //             width: 200,
  //             height: 200,
  //             alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //               image: DecorationImage(
  //                 image:
  //                     NetworkImage('https://placekitten.com/420/320?image=12'),
  //                 fit: BoxFit.cover,
  //               ),
  //               // border: Border.all(
  //               //   color: Colors.indigo,
  //               //   width: 10,
  //               // ),
  //               // boxShadow: [BoxShadow(blurRadius: 30, color: Colors.black)],
  //               shape: BoxShape.circle,
  //               // borderRadius: BorderRadius.only(
  //               //     topLeft: Radius.circular(50),
  //               //     topRight: Radius.circular(50))),
  //             ),
  //           )

  //           // const Text("This is Course List"),
  //           // ElevatedButton(
  //           //   onPressed: () {
  //           //     Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetail(1)));
  //           //   }
  //           // , child: const Text("Course 1")),
  //           // ElevatedButton(
  //           //   onPressed: () {
  //           //     Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetail(2)));
  //           //   }
  //           // , child: const Text("Course 2")),
  //           // ElevatedButton(
  //           //   onPressed: () {
  //           //     Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetail(3)));
  //           //   }
  //           // , child: const Text("Course 3")),
  //         ],
  //       )));
  // }
}
