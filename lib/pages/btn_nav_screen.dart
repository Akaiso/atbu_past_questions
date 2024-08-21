import 'package:atbu_pq/pages/home_page.dart';
import 'package:atbu_pq/pages/mylibrary.dart';
import 'package:atbu_pq/pages/profile.dart';
import 'package:atbu_pq/pages/quiz.dart';
import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:flutter/material.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _pageIndex = 0;

  // store the screens------------------------------
  final List<Widget> _pages = [
    const HomePage(),
     MyLibrary(),
    const QuizPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          enableFeedback: false,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          currentIndex: _pageIndex,
          onTap: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          selectedItemColor: primaryColor,
          unselectedItemColor: coolGreyColor,
          selectedLabelStyle: kbodysmallblackcolor,
          unselectedLabelStyle: kbodysmallblackcolor,
          items: [
            BottomNavigationBarItem(
              icon: _pageIndex == 0
                  ? Image.asset(
                      'images/home.png',
                      color: primaryColor,
                    )
                  : Image.asset(
                      'images/home.png',
                    ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: _pageIndex == 1
                    ? Image.asset(
                        'images/library.png',
                        color: primaryColor,
                      )
                    : Image.asset(
                        'images/library.png',
                      ),
                label: 'My Library'),
            BottomNavigationBarItem(
                icon: _pageIndex == 2
                    ? Image.asset(
                        'images/quiz.png',
                        color: primaryColor,
                      )
                    : Image.asset(
                        'images/quiz.png',
                      ),
                label: 'Quiz'),
            BottomNavigationBarItem(
                icon: _pageIndex == 3
                    ? Image.asset(
                        'images/profile.png',
                        color: primaryColor,
                      )
                    : Image.asset('images/profile.png'),
                label: 'Profile'),
          ]),
      body: _pages[_pageIndex],
    );
  }
}
