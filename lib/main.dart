import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smartwaste/login_screen.dart';
import 'package:smartwaste/update_delete.dart';
import 'package:smartwaste/user_page.dart';
import 'package:smartwaste/view/detailed_status.dart';
//import 'package:smartwaste/welcome.dart';
import 'firebase_options.dart';
import 'main_page.dart';


void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: detailedStatusPage(),
    );
  }
}


