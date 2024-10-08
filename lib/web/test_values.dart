import 'package:flutter/material.dart';
import 'package:school_schedule/custom/my_textfiled.dart';
import 'package:school_schedule/web/model.dart';

void printCourse(Course course) {
  debugPrint(course.crn.toString());
  debugPrint(course.sectionNumber.toString());
  debugPrint(course.days.toString());
  debugPrint(course.doctorName.toString());
  debugPrint(course.isSectionAvailable == true ? "متاحه" : "ممتلى");
  debugPrint(course.isTheory == true ? "نظري" : "عملي");
}

List<List<Course>> test = [
  [
    Course(
        courseName: " البرمجة الهندسية",
        crn: 56920,
        color: colors[0],
        sectionNumber: 1,
        days: [DateTime(2023, 01, 02, 07, 30, 00, 000), DateTime(2023, 01, 02, 08, 20, 00, 000)],
        doctorName: ["صائب علي الصيصان"],
        isSectionAvailable: false,
        isTheory: true),
    Course(
        courseName: " البرمجة الهندسية",
        crn: 56920,
        color: colors[0],
        sectionNumber: 1,
        days: [DateTime(2023, 01, 04, 07, 30, 00, 000), DateTime(2023, 01, 04, 08, 20, 00, 000)],
        doctorName: ["صائب علي الصيصان"],
        isSectionAvailable: false,
        isTheory: true),
    Course(
        courseName: " البرمجة الهندسية",
        crn: 56920,
        color: colors[0],
        sectionNumber: 1,
        days: [DateTime(2023, 01, 04, 08, 30, 00, 000), DateTime(2023, 01, 04, 09, 20, 00, 000)],
        doctorName: ["صائب علي الصيصان"],
        isSectionAvailable: false,
        isTheory: true),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        color: colors[1],
        sectionNumber: 1,
        days: [DateTime(2023, 01, 02, 14, 00, 00, 000), DateTime(2023, 01, 02, 14, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        color: colors[1],
        sectionNumber: 1,
        days: [DateTime(2023, 01, 02, 13, 00, 00, 000), DateTime(2023, 01, 02, 13, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        color: colors[1],
        sectionNumber: 1,
        days: [DateTime(2023, 01, 04, 13, 00, 00, 000), DateTime(2023, 01, 04, 13, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        color: colors[1],
        sectionNumber: 1,
        days: [DateTime(2023, 01, 01, 14, 00, 00, 000), DateTime(2023, 01, 01, 14, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: false),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        color: colors[1],
        sectionNumber: 1,
        days: [DateTime(2023, 01, 03, 14, 00, 00, 000), DateTime(2023, 01, 03, 14, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: false),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        color: colors[2],
        sectionNumber: 3,
        days: [DateTime(2023, 01, 01, 08, 30, 00, 000), DateTime(2023, 01, 01, 09, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        color: colors[2],
        sectionNumber: 3,
        days: [DateTime(2023, 01, 03, 08, 30, 00, 000), DateTime(2023, 01, 03, 09, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        color: colors[2],
        sectionNumber: 3,
        days: [DateTime(2023, 01, 05, 08, 30, 00, 000), DateTime(2023, 01, 05, 09, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        color: colors[2],
        sectionNumber: 3,
        days: [DateTime(2023, 01, 01, 09, 30, 00, 000), DateTime(2023, 01, 01, 10, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: false),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        color: colors[2],
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
        color: colors[3],
        sectionNumber: 2,
        days: [DateTime(2023, 01, 04, 09, 30, 00, 000), DateTime(2023, 01, 04, 10, 20, 00, 000)],
        doctorName: ["محمد مصطفى الغوانم"],
        isSectionAvailable: false,
        isTheory: true),
    Course(
        courseName: " البرمجة الهندسية",
        crn: 28331,
        color: colors[3],
        sectionNumber: 2,
        days: [DateTime(2023, 01, 02, 08, 30, 00, 000), DateTime(2023, 01, 02, 09, 20, 00, 000)],
        doctorName: ["محمد مصطفى الغوانم"],
        isSectionAvailable: false,
        isTheory: true),
    Course(
        courseName: " البرمجة الهندسية",
        crn: 28331,
        color: colors[3],
        sectionNumber: 2,
        days: [DateTime(2023, 01, 04, 08, 30, 00, 000), DateTime(2023, 01, 04, 09, 20, 00, 000)],
        doctorName: ["محمد مصطفى الغوانم"],
        isSectionAvailable: false,
        isTheory: true),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        color: colors[1],
        sectionNumber: 1,
        days: [DateTime(2023, 01, 02, 14, 00, 00, 000), DateTime(2023, 01, 02, 14, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        color: colors[1],
        sectionNumber: 1,
        days: [DateTime(2023, 01, 02, 13, 00, 00, 000), DateTime(2023, 01, 02, 13, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        color: colors[1],
        sectionNumber: 1,
        days: [DateTime(2023, 01, 04, 13, 00, 00, 000), DateTime(2023, 01, 04, 13, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        color: colors[1],
        sectionNumber: 1,
        days: [DateTime(2023, 01, 01, 14, 00, 00, 000), DateTime(2023, 01, 01, 14, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: false),
    Course(
        courseName: "البرمجة كائنية",
        crn: 34278,
        color: colors[1],
        sectionNumber: 1,
        days: [DateTime(2023, 01, 03, 14, 00, 00, 000), DateTime(2023, 01, 03, 14, 50, 00, 000)],
        doctorName: ["محمد شجاع صميم"],
        isSectionAvailable: true,
        isTheory: false),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        color: colors[2],
        sectionNumber: 3,
        days: [DateTime(2023, 01, 01, 08, 30, 00, 000), DateTime(2023, 01, 01, 09, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        color: colors[2],
        sectionNumber: 3,
        days: [DateTime(2023, 01, 03, 08, 30, 00, 000), DateTime(2023, 01, 03, 09, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        color: colors[2],
        sectionNumber: 3,
        days: [DateTime(2023, 01, 05, 08, 30, 00, 000), DateTime(2023, 01, 05, 09, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: true),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        color: colors[2],
        sectionNumber: 3,
        days: [DateTime(2023, 01, 01, 09, 30, 00, 000), DateTime(2023, 01, 01, 10, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: false),
    Course(
        courseName: "هندسة البرمجيات",
        crn: 63394,
        color: colors[2],
        sectionNumber: 3,
        days: [DateTime(2023, 01, 02, 09, 30, 00, 000), DateTime(2023, 01, 02, 10, 20, 00, 000)],
        doctorName: ["شاكيل  احمد"],
        isSectionAvailable: true,
        isTheory: false),
  ]
];
