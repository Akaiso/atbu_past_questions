// import 'package:atbu_pq/controllers/library_controller.dart';
// import 'package:atbu_pq/pages/QuestionTabs/tabs.dart';
// import 'package:atbu_pq/styles/colors.dart';
// import 'package:atbu_pq/styles/fonts.dart';
// import 'package:atbu_pq/utils/routers.dart';
// import 'package:atbu_pq/widgets/card.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class MyLibrary extends StatefulWidget {
//   const MyLibrary({Key? key}) : super(key: key);

//   @override
//   State<MyLibrary> createState() => _MyLibraryState();
// }

// class _MyLibraryState extends State<MyLibrary> {
//   final LibraryController _libraryController = LibraryController();
//   List<String> _libraryCourses = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchLibraryCourses();
//   }

//   Future<void> fetchLibraryCourses() async {
//     try {
//       List<String> courses = await _libraryController.getUserLibrary();
//       setState(() {
//         _libraryCourses = courses;
//       });
//     } catch (error) {
//       print('Error fetching library courses: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: whiteColor,
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 25.h,
//               ),
//               Text(
//                 'My Library',
//                 style: kbodylargeboldText,
//               ),
//               SizedBox(
//                 height: 8.h,
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _libraryCourses.length,
//                   itemBuilder: (context, index) {
//                     final courseName = _libraryCourses[index];
//                     return Padding(
//                       padding: EdgeInsets.only(bottom: 16.h),
//                       child: LibraryCard(
//                         text: courseName,
//                         OnTap: () {
//                           PageNavigator(context: context).nextPage(
//                               page: Tabs(
//                             coursedata: _libraryCourses,
//                           ));
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:atbu_pq/controllers/library_controller.dart';
import 'package:atbu_pq/pages/QuestionTabs/tabs.dart';
import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:atbu_pq/utils/routers.dart';
import 'package:atbu_pq/widgets/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyLibrary extends StatefulWidget {
  const MyLibrary({Key? key}) : super(key: key);

  @override
  State<MyLibrary> createState() => _MyLibraryState();
}




class _MyLibraryState extends State<MyLibrary> {
  final LibraryController _libraryController = LibraryController();
  List<String>? _libraryCourses;

  @override
  void initState() {
    super.initState();
    fetchLibraryCourses();
  }

  Future<void> fetchLibraryCourses() async {
    try {
      List<String> courses = await _libraryController.getUserLibrary();
      setState(() {
        _libraryCourses = courses;
      });
    } catch (error) {
      print('Error fetching library courses: $error');
    }
  }

  List<int> coursedataList = [50, 20];

  @override
  Widget build(BuildContext context) {

    StreamBuilder<QuerySnapshot> courseList = StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Faculties')
          .where('FacultyName', isEqualTo: 'Science')
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No data available');
        }

        String facultyId = snapshot.data!.docs.first.id;

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Faculties')
              .doc(facultyId)
              .collection('Departments')
              .where('DepartmentName',
              isEqualTo: 'Mathematical Science')
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> departmentSnapshot) {
            if (departmentSnapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (departmentSnapshot.connectionState ==
                ConnectionState.waiting) {
              return const Text("Loading");
            }

            if (!departmentSnapshot.hasData ||
                departmentSnapshot.data!.docs.isEmpty) {
              return const Text('No data available');
            }

            String departmentId =
                departmentSnapshot.data!.docs.first.id;

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Faculties')
                  .doc(facultyId)
                  .collection('Departments')
                  .doc(departmentId)
                  .collection('Courses')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot>  courseSnapshot) {
                if (courseSnapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (courseSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Text("Loading");
                }

                if (!courseSnapshot.hasData ||
                    courseSnapshot.data!.docs.isEmpty) {
                  return const Text('No courses available');
                }


                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: courseSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document =
                      courseSnapshot.data!.docs[index];
                      Map<String, dynamic> courseData =
                      document.data()! as Map<String, dynamic>;
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: 16.h,
                        ),
                        child: CourseCard(

                          OnTap: () {
                            PageNavigator(context: context).nextPage(
                                page: Tabs(
                                  coursedata: courseData,
                                ));
                          },
                          text: courseData['CourseName'] ?? '',
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.h,
              ),
              Text(
                'My Library',
                style: kbodylargeboldText,
              ),
              SizedBox(
                height: 8.h,
              ),
              Expanded(
                child: _libraryCourses == null
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _libraryCourses!.length,
                        itemBuilder: (context, index) {
                          final courseName = _libraryCourses![index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: LibraryCard(
                              text: courseName,
                              OnTap: () async{
                                // PageNavigator(context: context).nextPage(
                                //   page: Tabs(
                                //     coursedata: {'CourseName': courseName},
                                //   ),
                                // );
                                PageNavigator(context: context).nextPage(
                                    page:  Tabs(
                                      coursedata:
                                      await FirebaseFirestore.instance.collection("Faculties").doc().get(),
                                    ));
                              },

                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
