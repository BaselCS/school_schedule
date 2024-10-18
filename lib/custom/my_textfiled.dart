import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const List<Color> colors = [
  Color(0xff00363D),
  Color(0xff1C3438),
  Color(0xff005835),
  Color(0xff24304D),
  Color(0xff3B4665),
  Color(0xff334B4F),
];

class MyTextFiled extends StatefulWidget {
  const MyTextFiled({super.key, required this.colorNumber, required this.textEditingController});
  final int colorNumber;
  final TextEditingController textEditingController;

  @override
  State<MyTextFiled> createState() => _MyTextFiledState();
}

class _MyTextFiledState extends State<MyTextFiled> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: (MediaQuery.of(context).size.width / 6) - 10,
        child: TextField(
            controller: widget.textEditingController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
            ],
            decoration: InputDecoration(fillColor: colors[widget.colorNumber], filled: true, hintText: ("أدخل رقم المقرر...."))));
  }
}
