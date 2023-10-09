import 'dart:math';

import 'package:flutter/material.dart';
import 'package:school_schedule/custom/calender.dart';
import 'package:school_schedule/web/model.dart';
import 'package:school_schedule/web/web_scraping.dart';

void main() {
  return runApp(MaterialApp(
      theme: ThemeData.dark(), title: 'Calendar Demo', home: const Scaffold(body: Directionality(textDirection: TextDirection.rtl, child: MyBody()))));
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
      builder: (context, state) {
        if (state.hasData) {
          //عرض القيمة
          return ListView.builder(
            itemCount: state.data!.length,
            itemBuilder: (context, index) {
              //أول ساعة في الأسبوع و أخر ساعة
              int earliestHour = state.data![index][0].days[0].hour;
              int lastHour = state.data![index][0].days[0].hour;
              for (var i = 0; i < state.data![index].length; i++) {
                earliestHour = min(state.data![index][i].days[0].hour, earliestHour);
                lastHour = max(state.data![index][i].days[1].hour, lastHour);
              }

              return Column(
                children: [
                  SizedBox(
                      height: (lastHour - earliestHour + 1) * 85, //المدة * حجم المادة
                      child: MyCalender(
                        courses: state.data![index],
                        earliestHour: earliestHour.toDouble(),
                        lastHour: lastHour.toDouble(),
                      )),
                  // const SizedBox(height: 20),
                  // Row(
                  //   children: [
                  //     ListView.builder(itemBuilder: (context, index) {
                  //       return Text("${state.data![index][0].courseName} ${state.data![index][0].sectionNumber} ${state.data![index][0].crn}");
                  //     })
                  //   ],
                  // )
                ],
              );
            },
          );
        } else if (state.hasError) {
          return Text(state.error.toString());
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
