import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class settingsCard extends StatelessWidget {
  String textOne;
  String textTwo;
  void Function()? ontapone;
  void Function()? ontaptwo;

  settingsCard({
    required this.ontapone,
    required this.ontaptwo,
    required this.textOne,
    required this.textTwo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 129.h,
      width: double.infinity,
      child: Card(
        color: boneWhite,
        elevation: 3,
        shadowColor: blackColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textOne,
                    style: kbodysmallblackcolor,
                  ),
                  GestureDetector(
                      onTap: ontapone,
                      child: Image.asset('images/forewardarrow.png'))
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Divider(
              height: 0,
              color: Colors.grey.shade300,
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textTwo,
                    style: kbodysmallblackcolor,
                  ),
                  GestureDetector(
                      onTap: ontaptwo,
                      child: Image.asset('images/forewardarrow.png'))
                ],
              ),
            ),
            SizedBox(
              height: 26.h,
            ),
          ],
        ),
      ),
    );
  }
}
