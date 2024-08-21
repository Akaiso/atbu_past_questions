import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_engineering/agric_engr.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_engineering/automobile_engr.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_engineering/chemical_engr.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_engineering/civil_engr.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_engineering/computer_engr.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_engineering/electrical_eng.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_engineering/mechanical_engr.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_engineering/mechatronice_engr.dart';
import 'package:atbu_pq/View/FacultyOfScience/Faculty_of_engineering/petroleum_engr.dart';
import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:atbu_pq/widgets/card.dart'; // Import your DepartmentCard widget
// Import other department pages

class FacultyOfEngineeringDpt extends StatefulWidget {
  const FacultyOfEngineeringDpt({Key? key}) : super(key: key);

  @override
  _FacultyOfEngineeringDptState createState() =>
      _FacultyOfEngineeringDptState();
}

class _FacultyOfEngineeringDptState extends State<FacultyOfEngineeringDpt> {
  final List<String> department = [
    'Department of Automobile Eng.',
    'Department of Chemical Eng.',
    'Department of Department of Civil Eng.',
    'Department of Computer & Communication',
    'Department of Electrical/Electronics Eng.',
    'Department of Mechanical/Production Eng.',
    'Department of Mechatronics and Systems Eng.',
    'Department of Petroleum Engineering',
    'Department of Agriculture & Bio-Resource Eng.'
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
                      'Faculty of Engineering',
                      style: kbodylargeboldText,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Gabata welcome to faculty of engineering ',
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
                                      case 'Department of Automobile Eng.':
                                        return AutomobileEngineering();
                                      case 'Department of Chemical Eng.':
                                        return ChemicalEngineering();
                                      case 'Department of Department of Civil Eng.':
                                        return CivilEngineering();
                                      case 'Department of Computer & Communication':
                                        return ComputerEngineering();
                                      case 'Department of Electrical/Electronics Eng.':
                                        return ElectricalEngineering();
                                      case 'Department of Mechanical/Production Eng.':
                                        return MechanicalEngineering();
                                      case 'Department of Mechatronics and Systems Eng.':
                                        return MechatronicsEngineering();
                                      case 'Department of Petroleum Engineering':
                                        return PetroleumEngineering();
                                      case 'Department of Agriculture & Bio-Resource Eng.':
                                        return AgricEngineering();

                                      default:
                                        return AutomobileEngineering();
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
