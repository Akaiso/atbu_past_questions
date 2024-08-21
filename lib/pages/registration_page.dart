import 'package:atbu_pq/controllers/auth_controller.dart';
import 'package:atbu_pq/pages/login_page.dart';
import 'package:atbu_pq/pages/otp_page.dart';
import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:atbu_pq/utils/routers.dart';
import 'package:atbu_pq/utils/show_message.dart';
import 'package:atbu_pq/widgets/btn.dart';
import 'package:atbu_pq/widgets/formfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Registration_page extends StatefulWidget {
  const Registration_page({super.key});

  @override
  State<Registration_page> createState() => _Registration_pageState();
}

class _Registration_pageState extends State<Registration_page> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String email;
  late String fullName;
  late String phone;
  late String faculty;
  late String password;
  late String confirmpassword;
  bool _isLoading = false;
  // sign up user
  _signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    if (_formkey.currentState!.validate()) {
      String res = await _authController
          .signUpUSers(
              fullName, email, phone, faculty, password, confirmpassword)
          .whenComplete(() {
        setState(() {
          _formkey.currentState!.reset();
          _isLoading = false;
        });
      });
      suceesMessage(context, 'Success', ' Your account has been created');
      return PageNavigator(context: context).nextPageOnly(page: LoginPage());
    } else {
      setState(() {
        _isLoading = false;
      });
      return errorMessage(context, 'Opps', ' Fields must not be empty');
    }
  }

// Email validation
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Field must not be empty';
    }
    final bool isValid = EmailValidator.validate(email);
    if (!isValid) {
      return 'Invalid email';
    }
    return null;
  }

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
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      Center(
                        child: Text(
                          'Register',
                          style: kbodysmallbold,
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Text(
                        'Get Started',
                        style: kbodysmallbold,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Create an account so that you can get access to '
                        'our past questions, quiz and exam guide',
                        style: kbodysmallgreycolor,
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      customTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field must not be empty';
                          }
                          return null;
                        },
                        onchanged: (value) {
                          fullName = value!;
                        },
                        prefix: Image.asset('images/username.png'),
                        hint: 'Full Name',
                        color: coolGreyColor,
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      customTextField(
                        validator: (value) => validateEmail(value),
                        onchanged: (value) {
                          email = value!;
                        },
                        prefix: Image.asset('images/mail.png'),
                        hint: 'Email',
                        color: coolGreyColor,
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      customTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field must not be empty';
                          }
                          return null;
                        },
                        onchanged: (value) {
                          phone = value!;
                        },
                        prefix: Image.asset('images/phone.png'),
                        hint: 'Phone',
                        color: coolGreyColor,
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      customTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field must not be empty';
                          }
                          return null;
                        },
                        onchanged: (value) {
                          faculty = value!;
                        },
                        prefix: Image.asset('images/library.png'),
                        hint: 'Faculty',
                        color: coolGreyColor,
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      passwordTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field must not be empty';
                          }
                          return null;
                        },
                        onchanged: (value) {
                          password = value!;
                        },
                        prefix: Image.asset('images/password.png'),
                        hint: 'Password',
                        color: coolGreyColor,
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      passwordTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field must not be empty';
                          }
                          return null;
                        },
                        onchanged: (value) {
                          confirmpassword = value!;
                        },
                        prefix: Image.asset('images/password.png'),
                        hint: 'Confirm Password',
                        color: coolGreyColor,
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            )
                          : btn(
                              text: 'Register',
                              onTap: () {
                                _signUpUser();
                              },
                            ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        'By creating an account, you agree to the Terms of Services and Privacy Policy',
                        textAlign: TextAlign.center,
                        style: kbodysmallblackcolor,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            textAlign: TextAlign.center,
                            style: kbodysmallblackcolor,
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              PageNavigator(context: context)
                                  .nextPage(page: LoginPage());
                            },
                            child: Text(
                              'Login',
                              textAlign: TextAlign.center,
                              style: kbodysmallredcolor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 56.h,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
