import 'package:application_todo/db/db_helper.dart';
import 'package:application_todo/services/themes_services.dart';
import 'package:application_todo/themes/themes.dart';
import 'package:application_todo/views/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDb();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp (
      title: 'TODO APP',
      debugShowCheckedModeBanner: false,
     theme: Themes.light,
     darkTheme: Themes.dark,
      themeMode: ThemeService().theme ,
     
      home: MyHomePage()
    );
  }
}
