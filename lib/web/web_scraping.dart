import 'package:flutter/material.dart' show debugPrint;
import 'package:html/dom.dart';

import 'backend.dart';
import 'model.dart';

// void main() async {
//   // List<Element> elements = await askForInfo();
//   // inputTest(infoCleaner(elements));
// }

Future<List<List<Course>>> justForTest() async {
  List<List<Course>> courses = [];
  List<List<Course>> choosingCourses = [];

  Map<String, List<Course>> mainMap = await infoCleaner();

  for (var courseCode in ["0901-204", "0911-220", "0911-310"]) {
    if (mainMap.containsKey(courseCode)) {
      choosingCourses.add(mainMap[courseCode]!);
    }
  }

  List<List<Course>> allAvailablePermutations = []; //تحوي كل الجداول الممكنة

  generatePermutations(choosingCourses, allAvailablePermutations, 0, []);
  debugPrint("allAvailablePermutations is ${allAvailablePermutations.length}");

  for (List<Course> list in allAvailablePermutations) {
    if (Course.isTimeOverLap(list) == false) {
      List<Course> temp = [];
      for (var element in list) {
        for (var i = 0; i < element.days.length; i = i + 2) {
          temp.add(Course(
              courseName: element.courseName,
              crn: element.crn,
              sectionNumber: element.sectionNumber,
              days: [element.days[i], element.days[i + 1]],
              doctorName: element.doctorName,
              isSectionAvailable: element.isSectionAvailable,
              isTheory: element.isTheory));
        }
      }
      courses.add(temp);
    }
    debugPrint("-" * 50);
  }

  debugPrint("courses is ${courses.length}");
  return courses;
}

void printCourse(Course course) {
  debugPrint(course.courseName);
  debugPrint(course.crn.toString());
  debugPrint(course.sectionNumber.toString());
  debugPrint(course.days.toString());
  debugPrint(course.doctorName.toString());
  debugPrint(course.isSectionAvailable == true ? "متاحه" : "ممتلى");
  debugPrint(course.isTheory == true ? "نظري" : "عملي");
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

// void inputTest(Map<String, List<Course>> mainMap) {
//   List<List<Course>> choosingCourses = [];

//   stdin.readLineSync()!.split(" ").forEach((courseCode) {
//     if (mainMap.containsKey(courseCode)) {
//       choosingCourses.add(mainMap[courseCode]!);
//     }
//   });

//   List<List<Course>> allAvailablePermutations = []; //تحوي كل الجداول الممكنة

//   generatePermutations(choosingCourses, allAvailablePermutations, 0, []);
//   int i = 0;
//   for (List<Course> list in allAvailablePermutations) {
//     if (Course.isTimeOverLap(list) == false) {
//       for (Course course in list) {

//         i++;
//       }
//       debugPrint("-" * 50);
//     }
//   }
// }

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
