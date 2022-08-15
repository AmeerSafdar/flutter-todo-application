import 'package:application_todo/themes/themes.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? taped;
   MyButton({ Key? key, required this.label, required this.taped }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap :taped ,

      child:Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:primaryClr,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: white
            ),
          ),
        ),
      ),
    );
  }
}