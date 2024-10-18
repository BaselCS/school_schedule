import 'dart:math';

import 'package:flutter/material.dart';
import 'package:school_schedule/custom/calender.dart';
import 'package:school_schedule/custom/my_textfiled.dart';
import 'package:school_schedule/web/model.dart';
import 'package:school_schedule/web/web_scraping.dart';

class MyBody extends StatefulWidget {
  const MyBody({super.key});

  @override
  State<MyBody> createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  List<TextEditingController> textEditingController = List<TextEditingController>.generate(6, (index) => TextEditingController());
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    //النوع مستقبل يرجع قيمة بعد مده فأفضل طريقة لوأبي أعرض شيء بعد مده معينة أستخدم النباء المستقبلي
    return Column(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(children: [
          MyTextFiled(colorNumber: 0, textEditingController: textEditingController[0]),
          MyTextFiled(colorNumber: 1, textEditingController: textEditingController[1]),
          MyTextFiled(colorNumber: 2, textEditingController: textEditingController[2]),
          MyTextFiled(colorNumber: 3, textEditingController: textEditingController[3]),
          MyTextFiled(colorNumber: 4, textEditingController: textEditingController[4]),
          MyTextFiled(colorNumber: 5, textEditingController: textEditingController[5]),
          IconButton(
            onPressed: () {
              setState(() {
                isLoaded = true;
              });
            },
            iconSize: 25,
            icon: const Icon(Icons.search),
          )
        ]),
      ),
      !isLoaded
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: MyCalender(
                courses: [
                  Course(
                      courseName: 'Loading',
                      days: [DateTime(2023, 1, 1, 1), DateTime(2023, 1, 1, 3)],
                      crn: 123 - 123,
                      doctorName: ["Loading"],
                      isSectionAvailable: false,
                      isTheory: false,
                      sectionNumber: 1,
                      color: Colors.black87),
                ],
                earliestHour: 9,
                lastHour: 6,
              ))
          : FutureBuilder<List<List<Course>>>(
              future: justForTest([
                textEditingController[0].text, //القيمة التي أريد أن أبحث عنها
                textEditingController[1].text, //القيمة التي أريد أن أبحث عنها
                textEditingController[2].text, //القيمة التي أريد أن أبحث عنها
                textEditingController[3].text, //القيمة التي أريد أن أبحث عنها
                textEditingController[4].text, //القيمة التي أريد أن أبحث عنها
                textEditingController[5].text
              ]), //القيمة التي أريد عرضها
              builder: (context, courseState) {
                if (courseState.hasData) {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: ListView.builder(
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
                              Divider(
                                color: Colors.black87,
                                thickness: MediaQuery.of(context).size.height * 0.01,
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                            ],
                          );
                        },
                      ));
                } else if (courseState.hasError) {
                  return Text(courseState.error.toString());
                } else {
                  return const CircularProgressIndicator();
                }
              })
    ]);
  }
}
