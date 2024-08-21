import 'package:atbu_pq/pages/login_page.dart';
import 'package:atbu_pq/pages/registration_page.dart';
import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:atbu_pq/utils/routers.dart';
import 'package:atbu_pq/widgets/btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
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
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 46.h,
                    ),
                    Container(
                      height: 421.h,
                      // 421 / screenSize.size.height * screenSize.size.height,
                      width: double.infinity,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                          image: const DecorationImage(
                              image: AssetImage(
                                'images/student.jpg',
                              ),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    Text(
                      'GET TEST, EXAM PAST QUESTION, READY  ',
                      style: kbodylargeboldText,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                    ),
                    Text(
                      'FOR ACADEMIC EXCELLENCE!',
                      style: kbodylargeboldTextbluecolor,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'welcome to ATBUPQ, your go-to mobile app for'
                      'past questions, solutions, and quizzes to excel'
                      'in your academic journey.'
                      'Lets get started on this exciting learning adventure '
                      ''
                      'together!'
                      '',
                      style: kbodysmallgreycolor,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: outlinebtn(
                              onTap: () {
                                PageNavigator(context: context)
                                    .nextPageOnly(page: Registration_page());
                              },
                              text: 'Sign Up',
                              status: false),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Expanded(
                          child: btn(
                              onTap: () {
                                PageNavigator(context: context)
                                    .nextPageOnly(page: LoginPage());
                              },
                              text: 'Login',
                              status: false),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
