import 'package:atbu_pq/controllers/auth_controller.dart';
import 'package:atbu_pq/pages/btn_nav_screen.dart';
import 'package:atbu_pq/pages/forgotpassword.dart';
import 'package:atbu_pq/pages/home_page.dart';
import 'package:atbu_pq/pages/otp_page.dart';
import 'package:atbu_pq/pages/registration_page.dart';
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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController _authController = AuthController();
  late String email;
  late String password;
  bool _isLoading = false;

  _loginUser() async {
    setState(() {
      _isLoading = true;
    });
    if (_formkey.currentState!.validate()) {
      String res = await _authController.loginUser(email, password);
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });

        suceesMessage(context, 'Success', ' Login succesfull');
        return PageNavigator(context: context).nextPageOnly(page: NavScreen());
      } else {
        setState(() {
          _isLoading = false;
        });
        return LoginError(context, 'Oops', res);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      return errorMessage(context, 'Opps', 'Please field must not be empty');
    }
  }
  // _loginUsers() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   if (_formKey.currentState!.validate()) {
  //     String res = await _authController.loginUsers(email, password);

  //     if (res == 'success') {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       return Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (BuildContext context) {
  //         return MainScreen();
  //       }));
  //     } else {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       return showSnack(context, res);
  //     }
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     return showSnack(context, 'Please feidls most not be empty');
  //   }
  // }

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

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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
                      Text(
                        'Welcome Back!',
                        style: kbodylargeboldText,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Log In to your  account to explore Our past questions and various exam and text'
                        'solutions!',
                        style: kbodysmallgreycolor,
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
                        height: 16.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '',
                          ),
                          GestureDetector(
                            onTap: () {
                              PageNavigator(context: context)
                                  .nextPage(page: ForgotPassword());
                            },
                            child: Text(
                              'Forgot password?',
                              style: kbodysmallgreycolor,
                            ),
                          )
                        ],
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
                              text: 'Login',
                              onTap: () {
                                _loginUser();
                              },
                            ),
                      SizedBox(
                        height: 26.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Divider(
                              height: 2,
                              color: primaryColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Continue With',
                              style: kbodysmallblackcolor,
                            ),
                          ),
                          Flexible(
                            child: Divider(
                              height: 2,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 60.h,
                          margin: EdgeInsets.symmetric(vertical: 15.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(8.r)),
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16.w,
                              ),
                              Image.asset('images/Google.png'),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                'Sign in with email',
                                style: kbodysmallgreycolor,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account?',
                            style: kbodysmallblackcolor,
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              PageNavigator(context: context)
                                  .nextPage(page: Registration_page());
                            },
                            child: Text('Sign Up', style: kbodysmallredcolor),
                          )
                        ],
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
