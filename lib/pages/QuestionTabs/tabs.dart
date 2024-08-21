import 'package:atbu_pq/pages/QuestionTabs/exam_questions.dart';
import 'package:atbu_pq/pages/QuestionTabs/solution.dart';
import 'package:atbu_pq/pages/QuestionTabs/test_questions.dart';
import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tabs extends StatelessWidget {
  final dynamic coursedata;
  const Tabs({
    Key? key,
    required this.coursedata,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 3, // Number of tabs
          child: NestedScrollView(
            headerSliverBuilder: (context, _) => [
              SliverAppBar(
                toolbarHeight: 80.h,
                automaticallyImplyLeading: false,
                flexibleSpace: LayoutBuilder(builder: ((context, constraints) {
                  return FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25.h,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset('images/backarrow.png')),
                              SizedBox(
                                width: 160.h,
                              ),
                              Center(
                                child: Text(
                                  coursedata['CourseName'],
                                  style: kbodylargeboldText,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Center(
                            child: Text(
                              'All Time Past Question',
                              style: kbodysmallgreycolor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    enableFeedback: false,
                    indicatorColor: primaryColor,
                    labelColor: blackColor,
                    unselectedLabelColor: coolGreyColor,
                    tabs: const [
                      Tab(text: "Exam "),
                      Tab(text: "Test"),
                      Tab(text: "Solutions"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ],
            body: TabBarView(
              children: [
                ExamQuestions(
                  questionData: coursedata,
                ),
                TestQuestions(
                  questionData: coursedata,
                ),
                Solutions(
                  questionData: coursedata,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: whiteColor, // Change the color according to your design
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
