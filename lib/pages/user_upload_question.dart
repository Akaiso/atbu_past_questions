import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:atbu_pq/utils/show_message.dart';
import 'package:atbu_pq/widgets/btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserUploadQuestion extends StatefulWidget {
  const UserUploadQuestion({super.key});

  @override
  State<UserUploadQuestion> createState() => _UserUploadQuestionState();
}

class _UserUploadQuestionState extends State<UserUploadQuestion> {
  dynamic _image;
  String? _imageName;
  bool isLoading = false;

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // pick image
  pickImagee() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    // store the picked image in a global variable
    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        // getting the image name
        _imageName = result.files.first.name;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected')),
      );
    }
  }

  // upload banner to firebase Storage
  uploadBannerToFirebaseStorage(dynamic images) async {
    try {
      Reference ref = _storage.ref().child('Questions').child(_imageName!);
      UploadTask uploadTask = ref.putData(images);
      TaskSnapshot snapshot = await uploadTask;
      // get the download url
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image')),
      );
      throw e;
    }
  }

  // upload to firestore
  uploadBannerToFirestore() async {
    setState(() {
      isLoading = true;
    });
    if (_image != null) {
      try {
        String imageUrl = await uploadBannerToFirebaseStorage(_image);
        //store to firestore
        await _firestore.collection('Questions').doc(_imageName).set({
          'image': imageUrl,
        }).whenComplete(() {
          setState(() {
            _image = null;
            isLoading = false;
          });
          suceesMessage(context, 'Success', ' Image uploaded succesful');
        });
      } catch (e) {
        isLoading = false;
        errorMessage(context, 'Oops', 'Failed to upload image');
      }
    } else {
      errorMessage(context, 'Oops', 'No image selected');
      isLoading = false;
    }
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
                      height: 25.h,
                    ),
                    Text(
                      'Contribute',
                      style: kbodylargeboldText,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'Thank you gabata Adams for contributing '
                      'to this work, kindly upload past question '
                      'or solutions',
                      style: kbodysmallgreycolor,
                    ),
                    SizedBox(
                      height: 123.h,
                    ),
                    Center(
                      child: _image != null
                          ? Flexible(
                              child: Image.memory(
                                _image,
                                fit: BoxFit.cover,
                              ),
                            )
                          : SizedBox(
                              height: 280.h,
                              width: 343.w,
                              child: Card(
                                color: coolGreyColor,
                                elevation: 3,
                                shadowColor: blackColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Upload file in image format',
                                      style: kbodysmallwhitecolor,
                                    ),
                                    SizedBox(
                                      height: 19.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        pickImagee();
                                      },
                                      child: Container(
                                        height: 39.h,
                                        width: 180.w,
                                        decoration: BoxDecoration(
                                            color: whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(24)),
                                        child: Center(
                                          child: Text(
                                            'Add file',
                                            style: kbodysmallblackcolor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : btn(
                            text: 'Upload',
                            onTap: () {
                              uploadBannerToFirestore();
                            },
                          )
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
