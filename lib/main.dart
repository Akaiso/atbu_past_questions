import 'package:atbu_pq/firebase_options.dart';
import 'package:atbu_pq/pages/QuestionTabs/tabs.dart';
import 'package:atbu_pq/pages/btn_nav_screen.dart';
import 'package:atbu_pq/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
            inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blue), // Color of the underline when focused
          ),
        )),
        home: SplashScreen(),
      ),
      designSize: const Size(430, 932),
    );
  }
}
