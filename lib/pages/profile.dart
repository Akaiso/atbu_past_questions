import 'package:atbu_pq/pages/appsetthings.dart';
import 'package:atbu_pq/pages/editprofile.dart';
import 'package:atbu_pq/pages/login_page.dart';
import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:atbu_pq/utils/routers.dart';
import 'package:atbu_pq/widgets/setthingscard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String message = "Hi there, I have a question about...";
// Help team's phone number

  void openWhatsAppSupport(String message) async {
    // Encode the message for proper URL formatting
    String encodedMessage = Uri.encodeComponent(message);

    // WhatsApp URL scheme with pre-filled message
    String whatsappUrl = "whatsapp://send?text=$encodedMessage";

    // Check if the WhatsApp app is installed
    if (await canLaunchUrl(whatsappUrl as Uri)) {
      // Launch WhatsApp with the predefined message
      await launchUrl(whatsappUrl as Uri);
    } else {
      // If WhatsApp is not installed, display an error message
      print("WhatsApp is not installed on this device.");
      // You can display a message to the user indicating that WhatsApp is not installed
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(_auth.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
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
                            'Profile',
                            style: kbodylargeboldText,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          SizedBox(
                            height: 180.h,
                            width: double.infinity,
                            child: Card(
                              color: boneWhite,
                              elevation: 3,
                              shadowColor: blackColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.h),
                                            child: CircleAvatar(
                                              radius: 30.r,
                                              backgroundImage: const AssetImage(
                                                  'images/avater.jpg'),
                                            ),
                                          ),
                                          // Positioned(
                                          //   bottom: 0,
                                          //   top: 10,
                                          //   right: 0,
                                          //   left: 40,
                                          //   child: IconButton(
                                          //     onPressed: () {},
                                          //     icon: Image.asset(
                                          //         'images/avater.jpg'),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      Text(
                                        data['fullName'],
                                        style: kbodylargeboldText,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 80.0),
                                    child: Text(
                                      data['email'],
                                      style: kbodysmallgreycolor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Divider(
                                    height: 0,
                                    color: Colors.grey.shade300,
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 95.h),
                                    child: GestureDetector(
                                      onTap: () {
                                        PageNavigator(context: context)
                                            .nextPage(
                                                page: EditProfile(
                                          userData: data,
                                        ));
                                      },
                                      child: Text(
                                        'Edit Profile',
                                        style: kbodysmallblackcolor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 26.h,
                          ),
                          settingsCard(
                            textOne: ' Personal Information',
                            textTwo: 'Settings',
                            ontapone: () {
                              PageNavigator(context: context).nextPage(
                                  page: EditProfile(
                                userData: data,
                              ));
                            },
                            ontaptwo: () {
                              PageNavigator(context: context)
                                  .nextPage(page: const AppSetthings());
                            },
                          ),
                          SizedBox(
                            height: 26.h,
                          ),
                          settingsCard(
                            textOne: 'Help Center',
                            textTwo: 'Logout',
                            ontapone: () {
                              openWhatsAppSupport(message);
                            },
                            ontaptwo: () {
                              PageNavigator(context: context)
                                  .nextPage(page: const LoginPage());
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

        return Center(
            child: CircularProgressIndicator(
          color: primaryColor,
        ));
      },
    );
  }
}
