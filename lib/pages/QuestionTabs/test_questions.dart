import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

class TestQuestions extends StatelessWidget {
  final dynamic questionData;
  const TestQuestions({super.key, required this.questionData});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: coolGreyColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.h,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: questionData['TestImageURLs'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(
                          bottom: 16.h,
                        ),
                        child: Container(
                          height: 500,
                          width: double.infinity,
                          child: PhotoView(
                            imageProvider: NetworkImage(
                              questionData['ExamImageURLs'][index],
                            ),
                            backgroundDecoration:
                                BoxDecoration(color: coolGreyColor),
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
