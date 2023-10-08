import 'package:flutter/material.dart';
import 'package:school_schedule/web/model.dart';
import 'package:school_schedule/web/web_scraping.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// The hove page which hosts the calendar
class MyCalender extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  final List<Course> courses;
  const MyCalender({Key? key, required this.courses}) : super(key: key);

  @override
  State<MyCalender> createState() => _MyCalenderState();
}

class _MyCalenderState extends State<MyCalender> {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.week,
      headerHeight: 0,
      minDate: DateTime(2023, 1, 1),
      maxDate: DateTime(2023, 1, 6),
      initialDisplayDate: DateTime(2023, 1, 1),
      dataSource: CourseDataSource(widget.courses //   [
          ),
      viewNavigationMode: ViewNavigationMode.none,
    );
  }
}

class CourseDataSource extends CalendarDataSource {
  CourseDataSource(List<Course> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getCourseData(index).days[0];
  }

  @override
  String getNotes(int index) {
    return _getCourseData(index).doctorName.toString();
  }

  @override
  DateTime getEndTime(int index) {
    return _getCourseData(index).days[1];
  }

  @override
  String getSubject(int index) {
    return _getCourseData(index).courseName;
  }

  @override
  Color getColor(int index) {
    return _getCourseData(index).isTheory ? Colors.blue : Colors.red;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  Course _getCourseData(int index) {
    final dynamic course = appointments![index];
    late final Course courseData;
    if (course is Course) {
      printCourse(course);
      courseData = course;
    }

    return courseData;
  }
}
