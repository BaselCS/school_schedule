import 'package:flutter/material.dart' show Color, debugPrint;
import 'package:html/dom.dart';
import 'package:school_schedule/custom/my_textfiled.dart';

import 'backend.dart';
import 'model.dart';

//أكتب خورزمية تعيد تختار اللون بناء على المادة

Future<List<List<Course>>> justForTest(List<String> courseCodes) async {
  List<List<Course>> courses = [];
  List<List<Course>> choosingCourses = [];
  final Map<String, Color> colorMap = {
    courseCodes[0]: colors[0],
    courseCodes[1]: colors[1],
    courseCodes[2]: colors[2],
    courseCodes[3]: colors[3],
    courseCodes[4]: colors[4],
    courseCodes[5]: colors[5],
  };
  Map<String, List<Course>> mainMap = await infoCleaner();

  for (String courseCode in courseCodes) {
    if (courseCodes.isNotEmpty && mainMap.containsKey(courseCode)) {
      for (Course element in mainMap[courseCode]!) {
        element.color = colorMap[courseCode];
      }
      choosingCourses.add(mainMap[courseCode]!);
    }
  }

  List<List<Course>> allAvailablePermutations = []; //تحوي كل الجداول الممكنة

  generatePermutations(choosingCourses, allAvailablePermutations, 0, []);
  debugPrint("allAvailablePermutations is ${allAvailablePermutations.length}");

  for (List<Course> list in allAvailablePermutations) {
    if (Course.isTimeOverLap(list) == false) {
      List<Course> temp = [];
      for (Course element in list) {
        for (int i = 0; i < element.days.length; i = i + 2) {
          //أفصلها و أخلي كل محاضرة مستقله للعرض
          if (element.labDays.contains(element.days[i]) == false) {
            temp.add(Course(
                courseName: element.courseName,
                crn: element.crn,
                sectionNumber: element.sectionNumber,
                days: [element.days[i], element.days[i + 1]],
                doctorName: [element.doctorName.first],
                isSectionAvailable: element.isSectionAvailable,
                isTheory: element.isTheory,
                color: element.color));
          } else {
            temp.add(Course(
                courseName: element.courseName,
                crn: element.crn,
                sectionNumber: element.sectionNumber,
                days: [element.labDays.firstWhere((date) => date == element.days[i]), element.labDays.firstWhere((date) => date == element.days[i + 1])],
                doctorName: [element.doctorName.first],
                isSectionAvailable: element.isSectionAvailable,
                isTheory: false,
                color: element.color));
          }
        }
      }
      courses.add(temp);
    }
  }
  debugPrint("courses is ${courses.length}");

  return courses;
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
