import 'package:application_todo/controllers/task_controller.dart';
import 'package:application_todo/models/task_model.dart';
import 'package:application_todo/themes/themes.dart';
import 'package:application_todo/widgets/button_widget.dart';
import 'package:application_todo/widgets/inputFieldsWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class AddTAskBar extends StatefulWidget {
  const AddTAskBar({ Key? key }) : super(key: key);

  @override
  _AddTAskBarState createState() => _AddTAskBarState();
}

class _AddTAskBarState extends State<AddTAskBar> {
  TaskController _taskController= Get.put(TaskController());
  TextEditingController titleController = new TextEditingController();
  TextEditingController noteController = new TextEditingController();
  // TextEditingController titleController = new TextEditingController();

  DateTime _selectedDate = DateTime.now();
 String _endTime="9:20 PM";
 String _startTime=DateFormat("hh:mm a").format(DateTime.now()).toString();
 
 int _selectedReminder=5;
 List<int> remindList=[5,10,15,20];

 
 String _selectedRepeat='None';
 List<String> repeatList=["None","Daily"];

int _selectedColor=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor ,
      appBar: customAppBar(context),
      body: Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Tasks", style: hedingStyle),

              MyInputFields(
                controllers: titleController,
                title: "Title", hint: "Enter your title"),
              
              MyInputFields(
                controllers: noteController,
                title: "Note", hint: "Enter you Note"),
              
              MyInputFields(
              title: 'Date',
               hint: DateFormat.yMd().format(_selectedDate),
               widget: IconButton(
                onPressed: (){
                    _pickedDate(context);
                }, 
               icon: Icon(Icons.calendar_today_outlined,
               color: Colors.grey,
               )),
               ),
               Row(
                 children: [
                   Expanded(
                     child: MyInputFields(
                       title: "Start Time", 
                       hint: _startTime,
                       widget: IconButton(
                         onPressed: (){
                           _getTimeFromUser(isStartTime: true);
                         },
                          icon: Icon(Icons.access_time)),
                       )
                   ),
                   SizedBox(width: 10,),
                   Expanded(
                     child: MyInputFields(
                       title: "End Time",
                        hint: _endTime,
                        
                       widget: IconButton(
                         onPressed: (){
                           _getTimeFromUser(isStartTime: false);
                         },
                          icon: Icon(Icons.access_time))
                        )
                   )
                 ],
               ),
               MyInputFields(
                 title: "Remind", 
                 hint: "$_selectedReminder min early",
                 widget: DropdownButton(
                   icon: Icon(
                     Icons.keyboard_arrow_down_rounded,
                     color: Colors.grey,
                     ),
                     iconSize: 30,
                     elevation: 4,
                     style: subTitleStyle,
                     underline: Container(height: 0,width: 0,),

                      onChanged: (String? newVal){
                        setState(() {
                          
                        _selectedReminder = int.parse(newVal!);
                        });
                      },

                     items: remindList.map<DropdownMenuItem<String>>((int value){
                       return DropdownMenuItem<String>(
                         value: value.toString(),
                         child: Text(value.toString()),
                       );
                     }).toList(),

                 ),
                 ),
               MyInputFields(
                 title: "Repeat", 
                 hint: "$_selectedRepeat",
                 widget: DropdownButton(
                   icon: Icon(
                     Icons.keyboard_arrow_down_rounded,
                     color: Colors.grey,
                     ),
                     iconSize: 30,
                     elevation: 4,
                     style: subTitleStyle,
                     underline: Container(height: 0,width: 0,),

                      onChanged: (String? newVal){
                        setState(() {
                          
                        _selectedRepeat = newVal!;
                        });
                      },

                     items: repeatList.map<DropdownMenuItem<String>>((String value){
                       return DropdownMenuItem<String>(
                         value: value,
                         child: Text(value,style: TextStyle(color: Colors.grey),),
                       );
                     }).toList(),

                 ),
                 )
               ,
               SizedBox(height: 12,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   colorPallette(),
                   MyButton(
                    label: "Create Task",
                    taped: ()=> _validateDate(),
                    )
                 ],
               )
            ],
          ),
        ),
      ),
    );
  }

  Column colorPallette() {
    return Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text("Color",style: titleStyle,),
                     SizedBox(height: 6,),
                     Wrap(
                       children: List<Widget>.generate(3, (index) {
                         return GestureDetector(
                           onTap: (){
                             setState(() {
                              _selectedColor=index;
                             });
                           },
                           child: Padding(
                             padding: const EdgeInsets.only(right :5.0),
                             child: CircleAvatar(
                               radius: 13,
                                backgroundColor: index==0?primaryClr:index==1? pnkClr:yellowClr,
                                child:_selectedColor==index? Icon(
                                  Icons.done,
                                  color: white,
                                )
                                :
                                Container(),
                                
                             )
                           ),
                         );
                       }
                       )
                     )
                   ],
                 );
  }


  _validateDate(){
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty){
//db entry
      addTaskToDb();
      Get.back();

    }
    else if(titleController.text.isEmpty || noteController.text.isEmpty){
      Get.snackbar(
        "Required", "All fields are required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        icon: Icon(Icons.warning_amber_outlined),
        colorText: pnkClr
        );

    }
  }

   AppBar customAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
  elevation: 0,
  leading: GestureDetector(
    onTap: (){
      Get.back();
    },
    child: Icon(
      Icons.arrow_back_ios_new
      ,size: 28,
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


   _getTimeFromUser({required bool isStartTime}) async {
     var pickedTime=await _showTime();
     String _formatedTime = pickedTime.format(context);
     if(pickedTime ==null){
       print("Time Cancelled");
     }
     else if(isStartTime == true ){
        setState(() {
          _startTime = _formatedTime;
        });
     }
     else if(isStartTime == false){
       setState(() {
        _endTime == _formatedTime;
       });
     }
   } 
   Future <void> _pickedDate(BuildContext context) async{
    DateTime? date=await showDatePicker(
      context: context,
       initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2132)
        );
        if(date !=null){
          setState(() {
          _selectedDate=date;
          print(_selectedDate);
        });
        }
        else{
          print("it's null or something wrong");
        }
  }

   _showTime(){
     return showTimePicker(
       context: context, 
       initialEntryMode: TimePickerEntryMode.input,
       initialTime: TimeOfDay(
         hour: int.parse(_startTime.split(':')[0]),
          minute: int.parse(_startTime.split(':')[1].split(" ")[0]),
          )
       );
   }

   addTaskToDb() async{
  int value= await _taskController.addTask(
       task : Task(
       note: noteController.text,
       title: titleController.text,
       date: DateFormat.yMd().format(_selectedDate),
       startTime: _startTime,
       endTime: _endTime,
       remind: _selectedReminder,
       repeat: _selectedRepeat,
       color: _selectedColor,
       isCompleted: 0
     )
    );

    print("My id is $value");
   }
}