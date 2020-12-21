import 'dart:convert';

import 'package:hive/hive.dart';

import 'dart:io';

// @HiveType(typeId: 1)
// class Todo {
//      @HiveField(0)
//      String title;

//      @HiveField(1)
//      String body;

//      @HiveField(2)
//      int priority;

//      @HiveField(3)
//      int lastId;

//      @HiveField(4)
//      bool isTrashed = false;

// }

class TodoListModel {
     Future createTodo(Map data) async {
          var box = await Hive.openBox('TODO');

          List list;
          if(box == null) {
               list = [];
          } else {
               list = jsonDecode(box.get("TODO"));
          }
          list.add(data);

          await box.put("TODO", list);

          return true;
     }

     Future<List> getTodoData() async {
          var box = await Hive.openBox("TODO");

          return box.get("TODO");
     }
}