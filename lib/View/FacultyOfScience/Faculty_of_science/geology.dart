import 'package:atbu_pq/pages/QuestionTabs/tabs.dart';
import 'package:atbu_pq/pages/login_page.dart';
import 'package:atbu_pq/pages/otp_page.dart';
import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:atbu_pq/utils/routers.dart';
import 'package:atbu_pq/widgets/btn.dart';
import 'package:atbu_pq/widgets/card.dart';
import 'package:atbu_pq/widgets/formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeologyDepartment extends StatefulWidget {
  GeologyDepartment({
    super.key,
  });

  @override
  State<GeologyDepartment> createState() => _GeologyDepartmentState();
}

class _GeologyDepartmentState extends State<GeologyDepartment> {
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
                child: Image.asset('images/backarrow.png')),
            SizedBox(
              height: 26.h,
            ),
            Text(
              'Department of Geology',
              style: kbodylargeboldText,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              'Gabata welcome to department of geology '
              'past questions and solutions',
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
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('No data available');
                }

                String facultyId = snapshot.data!.docs.first.id;

                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Faculties')
                      .doc(facultyId)
                      .collection('Departments')
                      .where('DepartmentName', isEqualTo: 'Geology')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> departmentSnapshot) {
                    if (departmentSnapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (departmentSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    if (!departmentSnapshot.hasData ||
                        departmentSnapshot.data!.docs.isEmpty) {
                      return Text('No data available');
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
                          AsyncSnapshot<QuerySnapshot> courseSnapshot) {
                        if (courseSnapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (courseSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }

                        if (!courseSnapshot.hasData ||
                            courseSnapshot.data!.docs.isEmpty) {
                          return Text('No courses available');
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
            ),
          ],
        ),
      ),
    ));
  }
}



// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List _courses = [];
//   // GET COURSES
//   Future<void> _fetchCourses() async {
//     try {
//       // Query to fetch faculty document based on its name
//       QuerySnapshot facultySnapshot = await _firestore
//           .collection('Faculties')
//           .where('FacultyName',
//               isEqualTo: 'Science') // Replace with actual faculty name
//           .get();

//       if (facultySnapshot.docs.isNotEmpty) {
//         String facultyId = facultySnapshot.docs.first.id;

//         // Query to fetch department document based on its name and faculty ID
//         QuerySnapshot departmentSnapshot = await _firestore
//             .collection('Faculties')
//             .doc(facultyId)
//             .collection('Departments')
//             .where('DepartmentName',
//                 isEqualTo:
//                     'Mathematical Science') // Replace with actual department name
//             .get();

//         if (departmentSnapshot.docs.isNotEmpty) {
//           String departmentId = departmentSnapshot.docs.first.id;

//           // Fetch courses under the specified faculty and department
//           QuerySnapshot courseSnapshot = await _firestore
//               .collection('Faculties')
//               .doc(facultyId)
//               .collection('Departments')
//               .doc(departmentId)
//               .collection('Courses')
//               .get();

//           setState(() {
//             _courses =
//                 courseSnapshot.docs.map((doc) => doc['CourseName']).toList();
//           });
//         }
//       }
//     } catch (e) {
//       print('Error fetching courses: $e');
//     }
//   }

//   @override
//   void initState() {
//     _fetchCourses();
//     super.initState();
//   }