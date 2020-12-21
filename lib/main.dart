import 'dart:io';

import 'package:flutter/material.dart';

import 'features/ui/pages/todo_lists.dart';

import 'package:hive/hive.dart';

void main() {
  var path = Directory.current.path;
  Hive.init(path);
  runApp(MyApp());
}
   
  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Todo List',
        home: TodoLists()
      );
    }
  }
