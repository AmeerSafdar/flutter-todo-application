import 'package:application_todo/controllers/task_controller.dart';
import 'package:application_todo/models/task_model.dart';
import 'package:application_todo/services/notification_helper.dart';
import 'package:application_todo/services/themes_services.dart';
import 'package:application_todo/themes/themes.dart';
import 'package:application_todo/widgets/add_taskar_widget.dart';
import 'package:application_todo/widgets/bottom_sheet_button.dart';
import 'package:application_todo/widgets/button_widget.dart';
import 'package:application_todo/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate=DateTime.now();
  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper=NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: Column(
        children: [
         addTaskBar(),
         addDatePickerBar(),
         SizedBox(height: 12,),
         _showTasks(),
           ],
      ),
    );
  }
  _showTasks(){
    
    print(_taskController.taskList.length);
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (context,index){
            Task task=_taskController.taskList[index];
            print(task.toJson());
            if(task.repeat=='Daily'){ 
              DateTime date = DateFormat.jm().parse(task.startTime.toString());
              var myDate=DateFormat('HH:mm').format(date);
              notifyHelper.scheduledNotification(
                int.parse(myDate.toString().split(':')[0]),
                int.parse(myDate.toString().split(':')[1]),
                task

              );
              return AnimationConfiguration.staggeredList(
              position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            print('tapped');
                            showBottomSheet(context,task);

                          },
                          child: TaskTile(task),
                        )
                      ],
                    ),
                  ),
                )
                );
            }
            if(task.date==DateFormat.yMd().format(_selectedDate)){
              return AnimationConfiguration.staggeredList(
              position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            print('tapped');
                            showBottomSheet(context,task);
                          },
                          child: TaskTile(task),
                        )
                      ],
                    ),
                  ),
                )
                );
            }
            else{
              return Container();
            }
            // Container(
            //   margin: EdgeInsets.only(bottom: 10),
            //   height: 50,
            //   width: double.infinity,
            //   color: Colors.green,
            //   child: Text(
            //     _taskController.taskList[index].title.toString()
            //   ),
            // );
          },
        );
      }),
    );
  }
  showBottomSheet(BuildContext context , Task task){
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: 4),
        height: task.isCompleted ==1 ? 
        MediaQuery.of(context).size.height*0.24 :
         MediaQuery.of(context).size.height*0.32,
         decoration: BoxDecoration(
           color: Get.isDarkMode ? darkGreyClr : white,
         ),
        child: Column(
          children: [
            Container(
              height: 6,
              width:120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600]:Colors.grey[300]
              ),
            ),
            SizedBox(
              height: 40,
            ),
            task.isCompleted==1 ? 
            Container() :
             BottomSheetButtom(
               label: "Task Completed",
               press: () {
                 _taskController.markTaskCompleted(task.id!);
                 _taskController.getTasks();
                 Get.back();
               },
               clr: primaryClr,
             ),

             SizedBox(
              height: 8,
            ),
             BottomSheetButtom(
               label: "Delete Task",
               press: () {
                 _taskController.delete(task);
                 _taskController.getTasks();
                 Get.back();
               },
               clr: Colors.redAccent,
             ),
              SizedBox(
              height: 12,
            ),
             BottomSheetButtom(
               isClose: true,
               label: "Close Task",
               press: () {
                 Get.back();
               },
             ),
          ],
        ),
      )
    );
  }
  Container addDatePickerBar() {
    return Container(
         margin: EdgeInsets.only(left: 15,top: 15),
         child: DatePicker(
           DateTime.now(),
           height: 100,
           width: 80,
           
           initialSelectedDate: DateTime.now(),
           selectionColor: primaryClr,
           selectedTextColor: white,
           dateTextStyle: GoogleFonts.lato(
             textStyle: TextStyle(
             fontSize: 17,
             fontWeight: FontWeight.w600,
             color: Colors.grey
           ),
           ),
           dayTextStyle: GoogleFonts.lato(
             textStyle: TextStyle(
             fontSize: 15,
             fontWeight: FontWeight.w600,
             color: Colors.grey
           ),
           
         ),
         monthTextStyle: GoogleFonts.lato(
             textStyle: TextStyle(
             fontSize: 13,
             fontWeight: FontWeight.w600,
             color: Colors.grey
           ),
       ),
       onDateChange: (date){
         setState(() {
         _selectedDate=date;
         });
       },
         )
         );
  }

  Container addTaskBar() {
    return Container(
         margin:EdgeInsets.only(left: 20,right: 20,top: 10),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Container(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                  Text(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    style: subHedingStyle,
                    ), 
                  Text("Today",
                        style: hedingStyle,
                  ),
                  
                 ],
               ),
             ),
             MyButton(label: "+ Add Task", taped: () async {
               
               await Get.to(()=>AddTAskBar());
               _taskController.getTasks();
                })
           ],
         ),
       );
  }

  AppBar customAppbar() => AppBar(
    backgroundColor: context.theme.backgroundColor,
    elevation: 0,
    leading: GestureDetector(
      onTap: (){
        ThemeService().switchTheme(); 
        notifyHelper.displayNotification(
          title: "Theme Changed",
          body:Get.isDarkMode  ?  "Active Light Theme":"Active Dark theme " 
        );
        // notifyHelper.scheduledNotification();
      },
      child: Icon(
        Get.isDarkMode? 
        Icons.wb_sunny_rounded
        :
        Icons.nightlight,size: 28,
      color: Get.isDarkMode ? white:Colors.black,
      ),
    ),
    actions: [
      CircleAvatar(
        radius: 18,
        backgroundImage: AssetImage(
          "assets/images/profile.png"
        ),
      ),
      // Icon(Icons.person,size: 28,),
      SizedBox(width:28 ,)
    ],
  );
}

class Rxint {
}

