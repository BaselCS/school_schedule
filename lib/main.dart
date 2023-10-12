import 'package:flutter/material.dart';
import 'package:school_schedule/pages/calender_page.dart';

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xff191C1D),
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                fontSize: 16,
                color: Colors.grey[100],
              ),
            )),
        title: 'Calendar Demo',
        home: const Scaffold(body: Directionality(textDirection: TextDirection.rtl, child: MyBody())));
    // home: const Scaffold(body: Directionality(textDirection: TextDirection.rtl, child: EnterPage())));
  }
}
