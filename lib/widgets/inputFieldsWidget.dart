import 'package:application_todo/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyInputFields extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controllers;
  final Widget ? widget;
   MyInputFields({ Key? key, 
   required this.title, 
   required this.hint ,
    this.controllers ,
    this.widget
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),

          Container(
            height: 52,
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0
              ),
              borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget==null ? false : true,

                    controller: controllers ,
                    autofocus: false,
                    cursorColor: Get.isDarkMode ? Colors.grey[100] :Colors.grey[700] ,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: subTitleStyle,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none
                      )
                    ),
                  ),
                  widget==null ?
                   Container()
                  :
                  Container(child:widget)
                   
              ],
            ),
          )
        ],
      ),
    );
  }
}