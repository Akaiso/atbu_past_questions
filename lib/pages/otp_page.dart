import 'package:atbu_pq/pages/login_page.dart';
import 'package:atbu_pq/pages/registration_page.dart';
import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:atbu_pq/utils/routers.dart';
import 'package:atbu_pq/widgets/btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
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
                    Center(
                      child: Text(
                        'Register Verification',
                        textAlign: TextAlign.center,
                        style: kbodysmallbold,
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Text(
                      '5-digit code has been sent to your email address Adams20@gmail.com',
                      style: kbodysmallgreycolor,
                    ),
                    SizedBox(
                      height: 120.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 69.w),
                      child: Row(
                        children: [
                          OtpForm(),
                          SizedBox(
                            width: 5.w,
                          ),
                          OtpForm(),
                          SizedBox(
                            width: 5.w,
                          ),
                          OtpForm(),
                          SizedBox(
                            width: 5.w,
                          ),
                          OtpForm(),
                          SizedBox(
                            width: 5.w,
                          ),
                          OtpForm(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    Center(
                      child: Text(
                        'Didn’t recieve the code? ',
                        style: kbodysmallbold,
                      ),
                    ),
                    Center(
                      child: Text(
                        'Resend ',
                        style: kbodylargeboldTextbluecolor,
                      ),
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    btn(
                        text: 'Contnue',
                        onTap: () {
                          PageNavigator(context: context)
                              .nextPage(page: LoginPage());
                        })
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

class OtpForm extends StatelessWidget {
  const OtpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: otpText,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          fillColor: primaryColor,
          focusColor: primaryColor,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 5),
          ),
        ),
      ),
    );
  }
}
