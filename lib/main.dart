import 'package:chatapp/screens/exam_timer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/youtube_video.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //check
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CourseView(
        title: 'Course',
      ),
    );
  }
}
