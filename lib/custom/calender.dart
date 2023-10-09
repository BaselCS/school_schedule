import 'package:flutter/material.dart';
import 'package:school_schedule/web/model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// The hove page which hosts the calendar
class MyCalender extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  final List<Course> courses;
  final double earliestHour;
  final double lastHour;

  const MyCalender({Key? key, required this.courses, required this.earliestHour, required this.lastHour}) : super(key: key);

  @override
  State<MyCalender> createState() => _MyCalenderState();
}

class _MyCalenderState extends State<MyCalender> {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.workWeek,
      headerHeight: 0,

      minDate: DateTime(2023, 1, 1),
      maxDate: DateTime(2023, 1, 7),
      initialDisplayDate: DateTime(2023, 1, 1),
      dataSource: CourseDataSource(widget.courses),
      viewNavigationMode: ViewNavigationMode.none,
      // showDatePickerButton: true,
      timeSlotViewSettings: TimeSlotViewSettings(
        startHour: widget.earliestHour,
        endHour: widget.lastHour,
        timeIntervalHeight: 85,
        nonWorkingDays: const [DateTime.saturday, DateTime.friday],
      ),

      onTap: (calendarTapDetails) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(calendarTapDetails.appointments![0].courseName),
                content: Text(calendarTapDetails.appointments![0].doctorName.first),
              )),
      appointmentTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
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
    return "${_getCourseData(index).courseName}\n${_getCourseData(index).doctorName.first}\n ${_getCourseData(index).sectionNumber}";
  }

  @override
  Color getColor(int index) {
    return _getCourseData(index).isTheory ? Colors.blue : Colors.red; //لو لها أسمين إذا هي عملي
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  Course _getCourseData(int index) {
    final dynamic course = appointments![index];
    late final Course courseData;
    if (course is Course) {
      courseData = course;
    }

    return courseData;
  }
}
