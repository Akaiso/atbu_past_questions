import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_enviromental/architecture.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_enviromental/building.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_enviromental/enviromental_management.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_enviromental/estate_management.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_enviromental/geoinformatics.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_enviromental/industrial_design.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_enviromental/quantity_survey.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_enviromental/urban_regional.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_science/biochemistry.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_science/biological_science.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_science/chemistry.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_science/geology.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_science/microbiology.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_science/physics_department.dart';
import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:atbu_pq/widgets/card.dart'; // Import your DepartmentCard widget
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_science/mathematics_department.dart'; // Import other department pages

class FacultyOfEnviromentalDpt extends StatefulWidget {
  const FacultyOfEnviromentalDpt({Key? key}) : super(key: key);

  @override
  _FacultyOfEnviromentalDptState createState() =>
      _FacultyOfEnviromentalDptState();
}

class _FacultyOfEnviromentalDptState extends State<FacultyOfEnviromentalDpt> {
  final List<String> department = [
    'Department of Architecture',
    'Department of Building',
    'Department of Environmental Management Tech',
    'Department of Estate Mgt. and Valuation',
    'Department of Industrial Design',
    'Department of Quantity Survey',
    'Department of Survey & Geo-Informatics',
    'Department of Urban & Regional Planning',
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
                      'Faculty of Enviromental',
                      style: kbodylargeboldText,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Gabata welcome to faculty of enviromental ',
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
                                      case 'Department of Architecture':
                                        return Architecture();
                                      case 'Department of Building':
                                        return Building();
                                      case 'Department of Environmental Management Tech':
                                        return EnviromentalManagement();
                                      case 'Department of Estate Mgt. and Valuation':
                                        return EstateManagement();
                                      case 'Department of Industrial Design':
                                        return IndustrialDesign();
                                      case 'Department of Quantity Survey':
                                        return QuantitySurvey();
                                      case 'Department of Survey & Geo-Informatics':
                                        return GeoInformatics();
                                      case 'Department of Urban & Regional Planning':
                                        return UrbanAndRegionalPlaning();

                                      default:
                                        return Architecture();
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
