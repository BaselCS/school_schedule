import 'package:flutter/material.dart' show debugPrint;
import 'package:html/dom.dart';

import 'backend.dart';
import 'model.dart';

//List<Course>

Future<List<List<Course>>> justForTest() async {
  // List<List<Course>> courses = [];
  // List<List<Course>> choosingCourses = [];

  // Map<String, List<Course>> mainMap = await infoCleaner();

  // for (String courseCode in ["0901-204", "0911-220", "0911-310"]) {
  //   if (mainMap.containsKey(courseCode)) {
  //     choosingCourses.add(mainMap[courseCode]!);
  //   }
  // }

  // List<List<Course>> allAvailablePermutations = []; //تحوي كل الجداول الممكنة

  // generatePermutations(choosingCourses, allAvailablePermutations, 0, []);
  // debugPrint("allAvailablePermutations is ${allAvailablePermutations.length}");

  // for (List<Course> list in allAvailablePermutations) {
  //   if (Course.isTimeOverLap(list) == false) {
  //     List<Course> temp = [];
  //     for (Course element in list) {
  //       for (int i = 0; i < element.days.length; i = i + 2) {
  //         //أفصلها و أخلي كل محاضرة مستقله للعرض
  //         if (element.labDays.contains(element.days[i]) == false) {
  //           temp.add(Course(
  //               courseName: element.courseName,
  //               crn: element.crn,
  //               sectionNumber: element.sectionNumber,
  //               days: [element.days[i], element.days[i + 1]],
  //               doctorName: [element.doctorName.first],
  //               isSectionAvailable: element.isSectionAvailable,
  //               isTheory: element.isTheory));
  //         } else {
  //           temp.add(Course(
  //               courseName: element.courseName,
  //               crn: element.crn,
  //               sectionNumber: element.sectionNumber,
  //               days: [element.labDays.firstWhere((date) => date == element.days[i]), element.labDays.firstWhere((date) => date == element.days[i + 1])],
  //               doctorName: [element.doctorName.first],
  //               isSectionAvailable: element.isSectionAvailable,
  //               isTheory: false));
  //         }
  //       }
  //     }
  //     courses.add(temp);
  //   }
  // }
  // debugPrint("courses is ${courses.length}");

  return test;
}

//حلقة تكرار للتاكد من الأتصال تعيد معلومات الصفحة كاملة
Future<List<Element>> askForInfo() async {
  int i = 0;
  List<Element>? elements = [];

  do {
    i++;
    elements = await WebScraper.extractData();
    debugPrint("turn: $i");
  } while (elements == null);

  debugPrint("done with Scarping");
  return elements;
}

//يعدل المعلومات و التناسيق و يعيدها على شكل خريطة مواد غير مكررة
Future<Map<String, List<Course>>> infoCleaner() async {
  List<Element> elements = await askForInfo();
  Map<String, List<Course>> map = {};
  int limit = elements.length - 2; //في عنصرين لهم ذي الخصائص لكن بدون فايدة

  for (int i = 1; i < limit; i++) {
    String courseCode = Course.getCourseCode(elements[i]);

    if (courseCode != "رقم المقرر" && courseCode != "") {
      Course course = Course.toCourse(elements[i]);
      //إذا كان المقرر جديد
      if (map.containsKey(courseCode) == false) {
        map[courseCode] = [course];
        //إذا كان المقرر عملي
      } else if (course.isTheory == false && map[courseCode]!.any((element) => element.sectionNumber == course.sectionNumber - 40)) {
        map[courseCode]!.firstWhere((element) => element.sectionNumber == course.sectionNumber - 40).itHaveLab(course.doctorName.first, course.days);
        map[courseCode]!.firstWhere((element) => element.sectionNumber == course.sectionNumber - 40).labDays = course.days;
        //إذا كان المقرر مكرر و الشعبة مكررة
      } else if (map[courseCode]!.any((element) => element.crn == course.crn)) {
        map[courseCode]!.firstWhere((element) => element.crn == course.crn).days.addAll(course.days);
      } else {
        //إذا كان المقرر مكرر و الشعبة جديدة
        map[courseCode]!.add(course);
      }
    }
  }
  return map;
}

///يعمل على إيجاد كل الحالات الممكنة للمواد المدخلة
void generatePermutations(List<List<Course>> lists, List<List<Course>> result, int depth, List<Course> current) {
  if (depth == lists.length) {
    result.add(current);
    return;
  }

  for (int i = 0; i < lists[depth].length; i++) {
    generatePermutations(lists, result, depth + 1, [...current, lists[depth][i]]);
  }
}

// void printCourse(Course course) {
// writeCounter(course.crn.toString());
// writeCounter(course.sectionNumber.toString());
// writeCounter(course.days.toString());
// writeCounter(course.doctorName.toString());
// writeCounter(course.isSectionAvailable == true ? "متاحه" : "ممتلى");
// writeCounter(course.isTheory == true ? "نظري" : "عملي");
// }

List<List<Course>> test = [
  [
    Course(
        courseName: " البرمجة الهندسية",
        crn: 56920,
        sectionNumber: 1,
        days: [DateTime(2023, 01, 02, 07, 30, 00, 000), DateTime(2023, 01, 02, 08, 20, 00, 000)],
        doctorName: ["صائب علي الصيصان"],
        isSectionAvailable: false,
        isTheory: true),
    Course(
        courseName: " البرمجة الهندسية",
        crn: 56920,
        sectionNumber: 1,
        days: [DateTime(2023, 01, 04, 07, 30, 00, 000), DateTime(2023, 01, 04, 08, 20, 00, 000)],
        doctorName: ["صائب علي الصيصان"],
        isSectionAvailable: false,
        isTheory: true),
    Course(
        courseName: " البرمجة الهندسية",
        crn: 56920,
        sectionNumber: 1,
        days: [DateTime(2023, 01, 04, 08, 30, 00, 000), DateTime(2023, 01, 04, 09, 20, 00, 000)],
        doctorName: ["صائب علي الصيصان"],
        isSectionAvailable: false,
        isTheory: true),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        sectionNumber: 1,
        days: [DateTime(2023, 01, 02, 14, 00, 00, 000), DateTime(2023, 01, 02, 14, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        sectionNumber: 1,
        days: [DateTime(2023, 01, 02, 13, 00, 00, 000), DateTime(2023, 01, 02, 13, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        sectionNumber: 1,
        days: [DateTime(2023, 01, 04, 13, 00, 00, 000), DateTime(2023, 01, 04, 13, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        sectionNumber: 1,
        days: [DateTime(2023, 01, 01, 14, 00, 00, 000), DateTime(2023, 01, 01, 14, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: false),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        sectionNumber: 1,
        days: [DateTime(2023, 01, 03, 14, 00, 00, 000), DateTime(2023, 01, 03, 14, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: false),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        sectionNumber: 3,
        days: [DateTime(2023, 01, 01, 08, 30, 00, 000), DateTime(2023, 01, 01, 09, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        sectionNumber: 3,
        days: [DateTime(2023, 01, 03, 08, 30, 00, 000), DateTime(2023, 01, 03, 09, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        sectionNumber: 3,
        days: [DateTime(2023, 01, 05, 08, 30, 00, 000), DateTime(2023, 01, 05, 09, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        sectionNumber: 3,
        days: [DateTime(2023, 01, 01, 09, 30, 00, 000), DateTime(2023, 01, 01, 10, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: false),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        sectionNumber: 3,
        days: [DateTime(2023, 01, 02, 09, 30, 00, 000), DateTime(2023, 01, 02, 10, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: false),
  ],
  [
    Course(
        courseName: " البرمجة الهندسية",
        crn: 28331,
        sectionNumber: 2,
        days: [DateTime(2023, 01, 04, 09, 30, 00, 000), DateTime(2023, 01, 04, 10, 20, 00, 000)],
        doctorName: ["محمد مصطفى الغوانم"],
        isSectionAvailable: false,
        isTheory: true),
    Course(
        courseName: " البرمجة الهندسية",
        crn: 28331,
        sectionNumber: 2,
        days: [DateTime(2023, 01, 02, 08, 30, 00, 000), DateTime(2023, 01, 02, 09, 20, 00, 000)],
        doctorName: ["محمد مصطفى الغوانم"],
        isSectionAvailable: false,
        isTheory: true),
    Course(
        courseName: " البرمجة الهندسية",
        crn: 28331,
        sectionNumber: 2,
        days: [DateTime(2023, 01, 04, 08, 30, 00, 000), DateTime(2023, 01, 04, 09, 20, 00, 000)],
        doctorName: ["محمد مصطفى الغوانم"],
        isSectionAvailable: false,
        isTheory: true),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        sectionNumber: 1,
        days: [DateTime(2023, 01, 02, 14, 00, 00, 000), DateTime(2023, 01, 02, 14, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        sectionNumber: 1,
        days: [DateTime(2023, 01, 02, 13, 00, 00, 000), DateTime(2023, 01, 02, 13, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        sectionNumber: 1,
        days: [DateTime(2023, 01, 04, 13, 00, 00, 000), DateTime(2023, 01, 04, 13, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        sectionNumber: 1,
        days: [DateTime(2023, 01, 01, 14, 00, 00, 000), DateTime(2023, 01, 01, 14, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: false),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        sectionNumber: 1,
        days: [DateTime(2023, 01, 03, 14, 00, 00, 000), DateTime(2023, 01, 03, 14, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: false),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        sectionNumber: 3,
        days: [DateTime(2023, 01, 01, 08, 30, 00, 000), DateTime(2023, 01, 01, 09, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        sectionNumber: 3,
        days: [DateTime(2023, 01, 03, 08, 30, 00, 000), DateTime(2023, 01, 03, 09, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        sectionNumber: 3,
        days: [DateTime(2023, 01, 05, 08, 30, 00, 000), DateTime(2023, 01, 05, 09, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        sectionNumber: 3,
        days: [DateTime(2023, 01, 01, 09, 30, 00, 000), DateTime(2023, 01, 01, 10, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: false),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        sectionNumber: 3,
        days: [DateTime(2023, 01, 02, 09, 30, 00, 000), DateTime(2023, 01, 02, 10, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: false),
  ]
];
