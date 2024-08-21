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

class FacultyOfScienceDpt extends StatefulWidget {
  const FacultyOfScienceDpt({Key? key}) : super(key: key);

  @override
  _FacultyOfScienceDptState createState() => _FacultyOfScienceDptState();
}

class _FacultyOfScienceDptState extends State<FacultyOfScienceDpt> {
  final List<String> department = [
    'Department of mathematical science',
    'Department of Physics',
    'Department of Biological Sciences',
    'Department of Chemistry',
    'Department of Geology',
    'Department of Biochemistry',
    'Department of Microbiology',
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
                      'Faculty of Science',
                      style: kbodylargeboldText,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Gabata welcome to faculty of science ',
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
                                      case 'Department of mathematical science':
                                        return MathematicsDepartment();
                                      case 'Department of Physics':
                                        return PhysicsDepartment();
                                      case 'Department of Biological Sciences':
                                        return BiologyDepartment();
                                      case 'Department of Chemistry':
                                        return ChemistryDepartment();
                                      case 'Department of Geology':
                                        return GeologyDepartment();
                                      case 'Department of Biochemistry':
                                        return BiochemistryDepartment();
                                      case 'Department of Microbiology':
                                        return MicrobiologyDepartment();

                                      default:
                                        return MathematicsDepartment();
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
