import 'package:application_todo/db/db_helper.dart';
import 'package:application_todo/models/task_model.dart';
import 'package:get/get.dart';

class TaskController extends GetxController{

@override
  void onReady() {
    // TODO: implement onReady
    getTasks();
    super.onReady();
  }

 var taskList=<Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DbHelper.insert(task);
  }

  void getTasks() async{
    List<Map<String , dynamic>> tasks=await DbHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }


  void delete(Task task){
   DbHelper.delete(task);
  }

  void markTaskCompleted(int id) async{
 await DbHelper.update(id);
  }
}