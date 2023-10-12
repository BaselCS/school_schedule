import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_schedule/web/model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyCalender extends StatefulWidget {
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

      onTap: (calendarTapDetails) async {
        if (calendarTapDetails.appointments != null) {
          Clipboard.setData(ClipboardData(text: calendarTapDetails.appointments!.first.crn.toString()));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(milliseconds: 500),
            backgroundColor: calendarTapDetails.appointments!.first.color,
            content: const Text("تم نسخ الكود", textAlign: TextAlign.center, style: TextStyle(fontSize: 24, color: Colors.white)),
          ));
        }
      },
      appointmentTextStyle: const TextStyle(
        fontSize: 24,
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
    return "${_getCourseData(index).doctorName}";
  }

  @override
  DateTime getEndTime(int index) {
    return _getCourseData(index).days[1];
  }

  @override
  String getSubject(int index) {
    return _getCourseData(index).isTheory
        ? "${_getCourseData(index).courseName} - ${_getCourseData(index).sectionNumber}\n${_getCourseData(index).crn}\t - ${_getCourseData(index).doctorName.first}"
        : "🔬${_getCourseData(index).courseName} - ${_getCourseData(index).sectionNumber + 40}\n${_getCourseData(index).crn}\t - ${_getCourseData(index).doctorName.first}";
  }

  @override
  Color getColor(int index) {
    return _getCourseData(index).isTheory ? _getCourseData(index).color! : _getCourseData(index).color!;
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
