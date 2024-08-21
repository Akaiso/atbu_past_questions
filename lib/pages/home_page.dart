import 'package:atbu_pq/View/FacultyOfScience/College_of_medicine/medicine.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_Agriculture/departments.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_Managemet/departments.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_engineering/department.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_enviromental/departments.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_science/departments.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_technolgyEdu.dart/departments.dart';
import 'package:atbu_pq/pages/user_upload_question.dart';
import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:atbu_pq/utils/routers.dart';
import 'package:atbu_pq/widgets/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true; // Changed initial value to true
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _bannerImage = []; // Define type for _bannerImage

  @override
  void initState() {
    super.initState();
    getBanners();
  }

  void getBanners() {
    _firestore.collection('Banners').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _bannerImage.add(doc['image']);
        });
      });
      // After loading, set isLoading to false
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 34.r,
                      backgroundImage: const AssetImage('images/avater.jpg'),
                    ),
                    Image.asset(
                      'images/notification.png',
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Hello, Adams',
                  style: kbodylargeboldText,
                ),
                Text(
                  'Welcome Back Gabata',
                  style: kbodysmallgreycolor,
                ),
                const SizedBox(height: 20),
                Container(
                  height: 187.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: isLoading
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: whiteColor,
                              highlightColor: Colors.grey[300]!,
                              child: Container(
                                margin: EdgeInsets.all(8),
                                height: 187.h,
                                width: 300.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[300],
                                ),
                              ),
                            );
                          },
                        )
                      : PageView.builder(
                          itemCount: _bannerImage.length,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                _bannerImage[index],
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                ),
                SizedBox(height: 26.h),
                Text(
                  'List of Faculties',
                  style: kbodylargeboldTextbluecolor,
                ),
                SizedBox(height: 26.h),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 26,
                  children: [
                    card(
                      text: 'Agriculture',
                      onTap: () {
                        PageNavigator(context: context).nextPage(
                          page: const FacultyOfAgricultureDpt(),
                        );
                      },
                    ),
                    card(
                      onTap: () {
                        PageNavigator(context: context).nextPage(
                          page: const FacultyOfScienceDpt(),
                        );
                      },
                      text: 'Science',
                    ),
                    card(
                      onTap: () {
                        PageNavigator(context: context).nextPage(
                          page: const FacultyOfTechnoloogyEduDpt(),
                        );
                      },
                      text: 'Technology Edu',
                    ),
                    card(
                      onTap: () {
                        PageNavigator(context: context).nextPage(
                          page: const FacultyOfEngineeringDpt(),
                        );
                      },
                      text: 'Engineering',
                    ),
                    card(
                      onTap: () {
                        PageNavigator(context: context).nextPage(
                          page: const FacultyOfEnviromentalDpt(),
                        );
                      },
                      text: 'Environmental',
                    ),
                    card(
                      onTap: () {
                        PageNavigator(context: context).nextPage(
                          page: const FacultyOfManagementScenceDpt(),
                        );
                      },
                      text: 'Management',
                    ),
                    card(
                      onTap: () {
                        PageNavigator(context: context).nextPage(
                          page: Medicine(),
                        );
                      },
                      text: 'Medicine',
                    ),
                  ],
                ),
                SizedBox(height: 26.h),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 88.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: coolGreyColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contribute by uploading past questions ',
                            style: kbodysmallwhitecolor,
                          ),
                          Text(
                            'and solutions to our team, in image format ',
                            style: kbodysmallwhitecolor,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          PageNavigator(context: context).nextPage(
                            page: const UserUploadQuestion(),
                          );
                        },
                        child: Image.asset(
                          'images/forewardarrow.png',
                          color: whiteColor,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 26.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
