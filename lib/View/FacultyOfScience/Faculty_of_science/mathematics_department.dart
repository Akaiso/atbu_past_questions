// import 'package:atbu_pq/pages/QuestionTabs/tabs.dart';
// import 'package:atbu_pq/styles/colors.dart';
// import 'package:atbu_pq/styles/fonts.dart';
// import 'package:atbu_pq/utils/routers.dart';
// import 'package:atbu_pq/widgets/card.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class MathematicsDepartment extends StatefulWidget {
//   MathematicsDepartment({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<MathematicsDepartment> createState() => _MathematicsDepartmentState();
// }

// class _MathematicsDepartmentState extends State<MathematicsDepartment> {
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context);

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: whiteColor,
//         body: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: 16.0.w,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 25.h,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Image.asset('images/backarrow.png'),
//               ),
//               SizedBox(
//                 height: 26.h,
//               ),
//               Text(
//                 'Department of Mathematical Science',
//                 style: kbodylargeboldText,
//               ),
//               SizedBox(
//                 height: 8.h,
//               ),
//               Text(
//                 'Welcome to the Department of Mathematical Science past questions and solutions',
//                 style: kbodysmallgreycolor,
//               ),
//               SizedBox(
//                 height: 26.h,
//               ),
//               Text(
//                 'All Courses',
//                 style: kbodylargeboldText,
//               ),
//               SizedBox(
//                 height: 26.h,
//               ),
//               // StreamBuilder for fetching courses
//               StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('Faculties')
//                     .where('FacultyName', isEqualTo: 'Science')
//                     .snapshots(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.hasError) {
//                     return const Text('Something went wrong');
//                   }

//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Text("Loading");
//                   }

//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Text('No data available');
//                   }

//                   String facultyId = snapshot.data!.docs.first.id;

//                   return StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('Faculties')
//                         .doc(facultyId)
//                         .collection('Departments')
//                         .where('DepartmentName',
//                             isEqualTo: 'Mathematical Science')
//                         .snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<QuerySnapshot> departmentSnapshot) {
//                       if (departmentSnapshot.hasError) {
//                         return const Text('Something went wrong');
//                       }

//                       if (departmentSnapshot.connectionState ==
//                           ConnectionState.waiting) {
//                         return const Text("Loading");
//                       }

//                       if (!departmentSnapshot.hasData ||
//                           departmentSnapshot.data!.docs.isEmpty) {
//                         return const Text('No data available');
//                       }

//                       String departmentId =
//                           departmentSnapshot.data!.docs.first.id;

//                       return StreamBuilder<QuerySnapshot>(
//                         stream: FirebaseFirestore.instance
//                             .collection('Faculties')
//                             .doc(facultyId)
//                             .collection('Departments')
//                             .doc(departmentId)
//                             .collection('Courses')
//                             .snapshots(),
//                         builder: (BuildContext context,
//                             AsyncSnapshot<QuerySnapshot> courseSnapshot) {
//                           if (courseSnapshot.hasError) {
//                             return const Text('Something went wrong');
//                           }

//                           if (courseSnapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Text("Loading");
//                           }

//                           if (!courseSnapshot.hasData ||
//                               courseSnapshot.data!.docs.isEmpty) {
//                             return const Text('No courses available');
//                           }

//                           return Expanded(
//                             child: ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: courseSnapshot.data!.docs.length,
//                               itemBuilder: (context, index) {
//                                 DocumentSnapshot document =
//                                     courseSnapshot.data!.docs[index];
//                                 Map<String, dynamic> courseData =
//                                     document.data()! as Map<String, dynamic>;
//                                 return Padding(
//                                   padding: EdgeInsets.only(
//                                     bottom: 16.h,
//                                   ),
//                                   child: CourseCard(
//                                     Onpressed: () {
//                                       // add to library
//                                     },
//                                     OnTap: () {
//                                       PageNavigator(context: context).nextPage(
//                                           page: Tabs(
//                                         coursedata: courseData,
//                                       ));
//                                     },
//                                     text: courseData['CourseName'] ?? '',
//                                   ),
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   );
//                 },
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
import 'package:atbu_pq/pages/editprofile.dart';
import 'package:atbu_pq/pages/login_page.dart';
import 'package:atbu_pq/pages/profile.dart';
import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:atbu_pq/utils/routers.dart';
import 'package:atbu_pq/widgets/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MathematicsDepartment extends StatefulWidget {
  MathematicsDepartment({
    Key? key,
  }) : super(key: key);

  @override
  State<MathematicsDepartment> createState() => _MathematicsDepartmentState();
}

class _MathematicsDepartmentState extends State<MathematicsDepartment> {
  final LibraryController _libraryController = LibraryController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('images/backarrow.png'),
              ),
              SizedBox(
                height: 26.h,
              ),
              Text(
                'Department of Mathematical Science',
                style: kbodylargeboldText,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                'Welcome to the Department of Mathematical Science past questions and solutions',
                style: kbodysmallgreycolor,
              ),
              SizedBox(
                height: 26.h,
              ),
              Text(
                'All Courses',
                style: kbodylargeboldText,
              ),
              SizedBox(
                height: 26.h,
              ),
              // StreamBuilder for fetching courses
              StreamBuilder<QuerySnapshot>(
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
                                    AddToLibrary: () async {
                                      try {
                                        // Get the faculty and department name for the current course

                                        String facultyName =
                                            'Science'; // Replace with actual faculty name

                                        String departmentName =
                                            'Mathematical Science'; // Replace with actual department name

                                        // Retrieve the course name from the course data
                                        String courseName =
                                            courseData['CourseName'];

                                        // Call the addToLibrary function to add the course to the library
                                        await _libraryController.addToLibrary(
                                            context,
                                            facultyName,
                                            departmentName,
                                            courseName);

                                        // Show snackbar message upon successful addition
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Course added to library successfully'),
                                          ),
                                        );
                                      } catch (error) {
                                        print(
                                            'Error adding course to library: $error');
                                        // Handle error here
                                      }
                                    },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
