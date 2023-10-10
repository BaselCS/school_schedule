import 'dart:math';

import 'package:flutter/material.dart';
import 'package:school_schedule/custom/calender.dart';
import 'package:school_schedule/web/model.dart';
import 'package:school_schedule/web/web_scraping.dart';

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xff191C1D),
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                fontSize: 18,
                color: Colors.grey[100],
              ),
            )),
        title: 'Calendar Demo',
        home: const Scaffold(body: Directionality(textDirection: TextDirection.rtl, child: MyBody())));
  }
}

class MyBody extends StatefulWidget {
  const MyBody({super.key});

  @override
  State<MyBody> createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  @override
  Widget build(BuildContext context) {
    //النوع مستقبل يرجع قيمة بعد مده فأفضل طريقة لوأبي أعرض شيء بعد مده معينة أستخدم النباء المستقبلي
    return FutureBuilder<List<List<Course>>>(
      future: justForTest(), //القيمة التي أريد عرضها
      builder: (context, courseState) {
        if (courseState.hasData) {
          //عرض القيمة
          return ListView.builder(
            itemCount: courseState.data!.length,
            itemBuilder: (context, calenderIndex) {
              //أول ساعة في الأسبوع و أخر ساعة
              int earliestHour = courseState.data![calenderIndex][0].days[0].hour;
              int lastHour = courseState.data![calenderIndex][0].days[0].hour;
              for (var i = 0; i < courseState.data![calenderIndex].length; i++) {
                earliestHour = min(courseState.data![calenderIndex][i].days[0].hour, earliestHour);
                lastHour = max(courseState.data![calenderIndex][i].days[1].hour, lastHour);
              }

              return Column(
                children: [
                  SizedBox(
                      height: (lastHour - earliestHour + 1) * 85, //المدة * حجم المادة
                      child: MyCalender(
                        courses: courseState.data![calenderIndex],
                        earliestHour: earliestHour.toDouble(),
                        lastHour: lastHour.toDouble(),
                      )),
                  const Divider(
                    color: Colors.black87,
                    height: 1,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: ListView.builder(
                        itemCount: courseState.data![calenderIndex].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Center(
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width / (courseState.data![calenderIndex].length),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(
                                      color: courseState.data![calenderIndex][index].isTheory ? const Color(0xff007D8B) : const Color(0xff004F58),
                                      child: Center(
                                        child: SelectableText(
                                          "${courseState.data![calenderIndex][index].courseName}\n${courseState.data![calenderIndex][index].sectionNumber}\n${courseState.data![calenderIndex][index].crn}",
                                        ),
                                      )),
                                )),
                          );
                        }),
                  ),
                  const Divider(
                    color: Colors.black87,
                    height: 1,
                  ),
                ],
              );
            },
          );
        } else if (courseState.hasError) {
          return Text(courseState.error.toString());
        } else {
          return const Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Loading...'),
            ],
          ));
        }
      },
    );
  }
}
