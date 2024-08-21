import 'package:atbu_pq/pages/login_page.dart';
import 'package:atbu_pq/pages/otp_page.dart';
import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:atbu_pq/utils/routers.dart';
import 'package:atbu_pq/widgets/btn.dart';
import 'package:atbu_pq/widgets/formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
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
                      height: 25.h,
                    ),
                    Text(
                      'Quiz',
                      style: kbodylargeboldText,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'Welcome Gabata, seems you have read and ready '
                      'to take our quiz to prepare you ahead of your '
                      'Exam and test.',
                      style: kbodysmallgreycolor,
                    ),
                    SizedBox(
                      height: 243.h,
                    ),
                    Center(
                        child: Text(
                      'Coming Soon',
                      style: kbodysmallbold,
                    ))
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
