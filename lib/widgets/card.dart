import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class card extends StatelessWidget {
  String text;
  void Function()? onTap;
  card({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 82.h,
        width: 112.w,
        child: Card(
          color: boneWhite,
          elevation: 3,
          shadowColor: blackColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/books.png'),
              Text(
                text,
                style: kbodysmallblackcolor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DepartmentCard extends StatelessWidget {
  String text;
  void Function()? OnTap;
  DepartmentCard({super.key, required this.text, required this.OnTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: SizedBox(
        height: 64.h,
        width: double.infinity,
        child: Card(
          color: boneWhite,
          elevation: 3,
          shadowColor: blackColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(
                    text,
                    style: kbodysmallblackcolor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  String text;
  void Function()? AddToLibrary;

  void Function()? OnTap;
  CourseCard({
    super.key,
    required this.text,
    required this.OnTap,
    this.AddToLibrary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: SizedBox(
        height: 64.h,
        width: double.infinity,
        child: Card(
          color: boneWhite,
          elevation: 3,
          shadowColor: blackColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(
                    text,
                    style: kbodysmallblackcolor,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      AddToLibrary!();
                    },
                    icon: Image.asset('images/library.png'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LibraryCard extends StatelessWidget {
  String text;
  void Function()? OnTap;
  LibraryCard({super.key, required this.text, required this.OnTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: SizedBox(
        height: 64.h,
        width: double.infinity,
        child: Card(
          color: boneWhite,
          elevation: 3,
          shadowColor: blackColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(
                    text,
                    style: kbodysmallblackcolor,
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Image.asset('images/smallDelete.png'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

