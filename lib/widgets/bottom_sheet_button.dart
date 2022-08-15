import 'package:application_todo/models/task_model.dart';
import 'package:application_todo/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class BottomSheetButtom extends StatelessWidget {
  String ?label;
  Task ? task;
  VoidCallback ?press;
  bool ? isClose=false ;
  Color ?clr;

   BottomSheetButtom({ Key? key , this.label,this.press,this.clr,this.task,this.isClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1.5,
        color: isClose==true ? Get.isDarkMode? Colors.grey[600]!:Colors.grey[300]! : clr!,
        ),
        color: isClose==true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label!,
            style:isClose==true ? titleStyle : titleStyle.copyWith(color: white) ,
            )
          ),
      ),
    );
  }
}