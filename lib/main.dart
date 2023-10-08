import 'package:flutter/material.dart';
import 'package:school_schedule/custom/calender.dart';
import 'package:school_schedule/web/model.dart';
import 'package:school_schedule/web/web_scraping.dart';

void main() {
  return runApp(const MaterialApp(title: 'Calendar Demo', home: Scaffold(body: MyBody())));
}

class MyBody extends StatefulWidget {
  const MyBody({super.key});

  @override
  State<MyBody> createState() => _MyBodyState();
}

// class _MyBodyState extends State<MyBody> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       itemCount: test.length,
//       separatorBuilder: (BuildContext context, int index) {
//         return SizedBox(
//           height: MediaQuery.of(context).size.height * 0.15,
//         );
//       },
//       itemBuilder: (context, index) {
//         return SizedBox(height: MediaQuery.of(context).size.height * 0.8, width: MediaQuery.of(context).size.width * 0.8, child: MyCalender(courses: test));
//       },
//     );
//   }
// }

class _MyBodyState extends State<MyBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<Course>>>(
      future: justForTest(),
      builder: (context, state) {
        if (state.hasData) {
          return ListView.separated(
            itemCount: state.data!.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              );
            },
            itemBuilder: (context, index) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: MyCalender(courses: state.data![index]));
            },
          );
        } else if (state.hasError) {
          return Text(state.error.toString());
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
// List<Course> test = [
//   Course(
//       courseName: 'test',
//       crn: 1,
//       days: [
//         DateTime(2023, 1, 1, 1),
//         DateTime(2023, 1, 1, 1, 50),
//         DateTime(2023, 1, 2, 1),
//         DateTime(2023, 1, 2, 1),
//         DateTime(2023, 1, 3, 1),
//         DateTime(2023, 1, 3, 1),
//       ],
//       doctorName: ["Dr. Ahmed"],
//       isSectionAvailable: true,
//       isTheory: true,
//       sectionNumber: 1),
  // Course(
  //     courseName: 'Math',
  //     crn: 1,
  //     days: [DateTime(2023, 1, 2, 1), DateTime(2023, 1, 2, 1, 50)],
  //     doctorName: ["Dr. Ahmed"],
  //     isSectionAvailable: true,
  //     isTheory: true,
  //     sectionNumber: 1),
  // Course(
  //     courseName: 'Math',
  //     crn: 1,
  //     days: [DateTime(2023, 1, 1, 8), DateTime(2023, 1, 1, 8, 50)],
  //     doctorName: ["Dr. Ahmed"],
  //     isSectionAvailable: true,
  //     isTheory: true,
  //     sectionNumber: 1)
// ];
