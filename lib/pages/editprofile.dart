import 'package:atbu_pq/pages/login_page.dart';
import 'package:atbu_pq/pages/otp_page.dart';
import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:atbu_pq/utils/routers.dart';
import 'package:atbu_pq/utils/show_message.dart';
import 'package:atbu_pq/widgets/btn.dart';
import 'package:atbu_pq/widgets/formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfile extends StatefulWidget {
  final dynamic userData;
  const EditProfile({super.key, required this.userData});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _phoneController = TextEditingController();
  final _facultyController = TextEditingController();
  final _nameController = TextEditingController();
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  void initState() {
    setState(() {
      _nameController.text = widget.userData['fullName'];
      _phoneController.text = widget.userData['phone'];
      _facultyController.text = widget.userData['faculty'];
    });
    super.initState();
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
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset('images/backarrow.png')),
                    SizedBox(
                      height: 26.h,
                    ),
                    Text(
                      'Personal Information',
                      style: kbodylargeboldText,
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.h),
                            child: CircleAvatar(
                              radius: 60.r,
                              backgroundImage:
                                  const AssetImage('images/avater.jpg'),
                            ),
                          ),
                          // Positioned(
                          //   bottom: 0,
                          //   top: 15,
                          //   right: 0,
                          //   left: 90,
                          //   child: IconButton(
                          //     onPressed: () {},
                          //     icon: Image.asset('images/camera.png'),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    customTextField(
                      controller: _nameController,
                      prefix: Image.asset('images/username.png'),
                      hint: widget.userData['fullName'],
                      color: coolGreyColor,
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    customTextField(
                      controller: _phoneController,
                      prefix: Image.asset('images/phone.png'),
                      hint: widget.userData['phone'],
                      color: coolGreyColor,
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    customTextField(
                      controller: _facultyController,
                      prefix: Image.asset('images/library.png'),
                      hint: widget.userData['faculty'],
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
                            onTap: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              try {
                                await _fireStore
                                    .collection('users')
                                    .doc(_auth.currentUser!.uid)
                                    .update({
                                  'fullName': _nameController.text,
                                  'phone': _phoneController.text,
                                  'faculty': _facultyController.text
                                }).whenComplete(() {
                                  setState(() {
                                    _isLoading = false;
                                    suceesMessage(context, 'Success',
                                        'Details updated successful');
                                  });
                                });
                              } catch (e) {
                                setState(() {
                                  _isLoading = false;
                                });
                                errorMessage(
                                    context, 'Oops', ' Something went wrong');
                              }
                            },
                            text: 'Update'),
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
