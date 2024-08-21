import 'package:atbu_pq/pages/forgotpassword.dart';
import 'package:atbu_pq/pages/login_page.dart';
import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:atbu_pq/utils/routers.dart';
import 'package:atbu_pq/utils/show_message.dart';
import 'package:atbu_pq/widgets/btn.dart';
import 'package:atbu_pq/widgets/setthingscard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSetthings extends StatefulWidget {
  const AppSetthings({super.key});

  @override
  State<AppSetthings> createState() => _AppSetthingsState();
}

class _AppSetthingsState extends State<AppSetthings> {
  bool _isLoading = false;

  Future<void> deleteUser(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      // Get the current user ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      if (userId != null) {
        // Delete user from Firebase Authentication
        await FirebaseAuth.instance.currentUser?.delete();

        // Delete user data from Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .delete();

        // If successful, do something (like navigate to a different screen)
        suceesMessage(context, 'Success', 'User deleted successful');
        PageNavigator(context: context).nextPage(page: LoginPage());
      } else {
        // User not found
        errorMessage(context, 'Oops', 'Error: User not found');
      }
    } catch (e) {
      // Handle the error as per your requirement
      errorMessage(context, 'Oops', 'Error deleting user: $e');
    } finally {
      // Set isLoading to false in both success and error cases
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset('images/backarrow.png')),
                    SizedBox(
                      height: 26.h,
                    ),
                    Text(
                      'App Settings',
                      style: kbodysmallbold,
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    settingsCard(
                      textOne: 'Reset Password',
                      textTwo: 'Delete Account',
                      ontapone: () {
                        PageNavigator(context: context)
                            .nextPage(page: const ForgotPassword());
                      },
                      ontaptwo: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: boneWhite,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 319.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    color: boneWhite),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('images/bigDelete.png'),
                                      Text(
                                        'Delete Account',
                                        style: kbodysmallbold,
                                      ),
                                      Text(
                                        'Your data will be deleted completely from '
                                        'our database',
                                        style: kbodysmallblackcolor,
                                      ),
                                      SizedBox(
                                        height: 26.h,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: outlinebtn(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                text: 'Cancel',
                                                status: false),
                                          ),
                                          SizedBox(
                                            width: 16.w,
                                          ),
                                          _isLoading
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                  color: primaryColor,
                                                ))
                                              : Expanded(
                                                  child: _isLoading
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                          color: primaryColor,
                                                        ))
                                                      : btn(
                                                          onTap: () {
                                                            deleteUser(context);
                                                          },
                                                          text: 'Continue',
                                                          status: false),
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
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
