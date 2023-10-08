import 'package:html/dom.dart';

class Course {
  int crn;
  int sectionNumber;
  bool isSectionAvailable = true;
  String courseName;
  List<DateTime> days;
  bool isTheory = true;
  List<String> doctorName;
  Course({
    required this.crn,
    required this.sectionNumber,
    required this.isSectionAvailable,
    required this.courseName,
    required this.days,
    required this.isTheory,
    required this.doctorName,
  });
  static Course toCourse(Element element) {
    return Course(
        crn: int.parse(element.getElementsByTagName('td')[1].text.replaceAll("\n", "")),
        sectionNumber: int.parse(element.getElementsByTagName('td')[2].text.replaceAll("\n", "")),
        isSectionAvailable: element.getElementsByTagName('td')[3].text.replaceAll("\n", "") == "متاحه",
        courseName: element.getElementsByTagName('td')[4].text.replaceAll("\n", ""),
        days: stringToDateTime(element.getElementsByTagName('td')[6].text.replaceAll("\n", "").split(" "),
            element.getElementsByTagName('td')[8].text.replaceAll("\n", "").replaceAll("-", "")),
        isTheory: element.getElementsByTagName('td')[7].text.replaceAll("\n", "") == "نظري",
        doctorName: [element.getElementsByTagName('td')[9].text.replaceAll("\n", "")]);
  }

  ///تحول النصوص إلى وقت
  static List<DateTime> stringToDateTime(List<String> days, String hours) {
    List<DateTime> data = [];
    days.removeWhere((element) => element == "" || element == " ");
    int dayDate = 0, hours1 = 0, minute1 = 0, hours2 = 0, minute2 = 0;
    for (String day in days) {
      //سنة 23 أول يوم فيها أحد
      switch (day) {
        case 'ح':
          dayDate = 1;
          break;
        case 'ن':
          dayDate = 2;
          break;
        case 'ث':
          dayDate = 3;
          break;
        case 'ر':
          dayDate = 4;
          break;
        case 'خ':
          dayDate = 5;
          break;
      }
      //الوقت يكون على صيغة 0730  0820
      hours1 = int.parse(hours.substring(0, 2));
      minute1 = int.parse(hours.substring(2, 4));
      hours2 = int.parse(hours.substring(6, 8));
      minute2 = int.parse(hours.substring(8, 10));
      data.add(DateTime(2023, 1, dayDate, hours1, minute1));
      data.add(DateTime(2023, 1, dayDate, hours2, minute2));
    }
    return data;
  }

  ///يحدد هل هنالك تعارض في الأوقات أو لا
  static bool isTimeOverLap(List<Course> courses) {
    for (int i = 0; i < courses.length; i++) {
      for (int j = i + 1; j < courses.length; j++) {
        if (isOverLap(courses[i].days, courses[j].days)) {
          return true;
        }
      }
    }
    return false;
  }

  static bool isOverLap(List<DateTime> time1, List<DateTime> time2) {
    for (int i = 0; i < time1.length; i += 2) {
      for (int j = 0; j < time2.length; j += 2) {
        if (time1[i].isBefore(time2[j + 1]) && time1[i + 1].isAfter(time2[j]) || time2[j + 1].isBefore(time1[i]) && time2[j].isAfter(time1[i + 1])) {
          return true;
        }
      }
    }
    return false;
  }

  void itHaveLab(String labDoctorName, List<DateTime> time) {
    doctorName.first = "نظري : ${doctorName.first}";
    doctorName.add("عملي : $labDoctorName");

    days.addAll(time);
  }

  //عشان الخريطة
  static String getCourseCode(Element element) {
    return element.getElementsByTagName('td')[0].text.replaceAll("\n", "");
  }
}
