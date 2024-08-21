import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_Agriculture/animal_production.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_Agriculture/crop_production.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_Agriculture/ecology.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_Agriculture/soil_science.dart';
import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:atbu_pq/widgets/card.dart'; // Import your DepartmentCard widget
// Import other department pages

class FacultyOfAgricultureDpt extends StatefulWidget {
  const FacultyOfAgricultureDpt({Key? key}) : super(key: key);

  @override
  _FacultyOfAgricultureDptState createState() =>
      _FacultyOfAgricultureDptState();
}

class _FacultyOfAgricultureDptState extends State<FacultyOfAgricultureDpt> {
  final List<String> department = [
    'Department of Animal Production.',
    'Department of Crop Production',
    'Department of Ecology',
    'Department of Soil Science',
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset('images/backarrow.png'),
                    ),
                    SizedBox(height: 26.h),
                    Text(
                      'Faculty of Agriculture',
                      style: kbodylargeboldText,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Gabata welcome to faculty of agriculture ',
                      style: kbodysmallgreycolor,
                    ),
                    Text(
                      'past questions and solutions',
                      style: kbodysmallgreycolor,
                    ),
                    SizedBox(height: 26.h),
                    Text(
                      'Departments',
                      style: kbodylargeboldText,
                    ),
                    SizedBox(height: 26.h),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: department.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: DepartmentCard(
                            OnTap: () {
                              String departmentName = department[index];
                              // Navigate to the corresponding department page
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) {
                                    switch (departmentName) {
                                      case 'Department of Animal Production.':
                                        return AnimalProduction();

                                      case 'Department of Crop Production':
                                        return CropProduction();
                                      case 'Department of Ecology':
                                        return Ecology();
                                      case 'Department of Soil Science':
                                        return SoilScience();

                                      default:
                                        return AnimalProduction();
                                    }
                                  },
                                ),
                              );
                            },
                            text: department[index],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
