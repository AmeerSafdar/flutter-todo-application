import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
const Color bluishClr=Color(0xff4e5ae8);
const Color yellowClr=Color(0xffff8746);
const Color pnkClr=Color(0xffff4667);
const Color white=Colors.white;
const Color primaryClr=bluishClr;
const Color darkGreyClr=Color(0xff121212);
Color darkHeaderClr=Color(0xff424242);

class Themes{

 static final light= ThemeData(
       backgroundColor: white,
        primaryColor: primaryClr,
        // primarySwatch: Colors.blue,
        brightness: Brightness.light,

      );

   static final dark= ThemeData(
     backgroundColor: darkGreyClr,
        primaryColor: darkGreyClr,
        brightness: Brightness.dark
      );
       
}

TextStyle get subHedingStyle{
  return GoogleFonts.lato(
    textStyle: (
      TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.grey[400] : Colors.grey

      )
    )
  );
}

TextStyle get hedingStyle{
  return GoogleFonts.lato(
    textStyle: (
      TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? white : Colors.black
        
      )
    )
  );
}

TextStyle get titleStyle{
  return GoogleFonts.lato(
    textStyle: (
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? white : Colors.black
        
      )
    )
  );
}

TextStyle get subTitleStyle{
  return GoogleFonts.lato(
    textStyle: (
      TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[400]
        
      )
    )
  );
}