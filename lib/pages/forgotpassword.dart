import 'package:atbu_pq/pages/login_page.dart';

import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:atbu_pq/utils/routers.dart';
import 'package:atbu_pq/utils/show_message.dart';
import 'package:atbu_pq/widgets/btn.dart';
import 'package:atbu_pq/widgets/formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  // forgot password function

  resetPassword() async {
    setState(() {
      _isLoading = true;
    });
    try {
      // Validate email format
      if (!isValidEmail(_emailController.text.trim())) {
        setState(() {
          _isLoading = false;
        });
        errorMessage(context, 'Error', 'Please enter a valid email address');
        return;
      }

      // Get the current user from Firebase Authentication
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        // Compare the entered email with the current user's email
        if (_emailController.text.trim() == currentUser.email) {
          // Email matches, send password reset email
          await _auth.sendPasswordResetEmail(
              email: _emailController.text.trim());
          setState(() {
            _isLoading = false;
            suceesMessage(
                context, 'Success', ' Reset link successfully sent to email');
          });
        } else {
          // Email does not match
          setState(() {
            _isLoading = false;
          });
          errorMessage(context, 'Oops',
              'Entered email does not match the current user\'s email');
        }
      } else {
        // No user logged in
        setState(() {
          _isLoading = false;
        });
        errorMessage(context, 'Error', 'No user logged in');
      }
    } on FirebaseAuthException catch (e) {
      errorMessage(context, 'Oops', e.message.toString());
      setState(() {
        _isLoading = false;
      });
    }
    PageNavigator(context: context).nextPage(page: LoginPage());
  }

// Function to validate email format
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      'Forgot Password',
                      style: kbodylargeboldText,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Don’t worry! it happens. Please enter your '
                      ''
                      'email associated with your account',
                      style: kbodysmallgreycolor,
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    customTextField(
                      controller: _emailController,
                      prefix: Image.asset('images/mail.png'),
                      hint: 'Email',
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
                            text: 'Continue',
                            onTap: () {
                              resetPassword();
                            },
                          ),
                    SizedBox(
                      height: 26.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Remember your details?',
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
                          child: Text('Sign In', style: kbodysmallredcolor),
                        )
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
