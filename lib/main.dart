import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';

import 'features/ui/pages/todo_lists.dart';

import 'package:hive/hive.dart';

void main() {
  // var path = Directory.current.path;
  // Hive.init(path);
  runApp(MyApp());
}
   
  class MyApp extends StatelessWidget {
    var path = Directory.current.path;
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Todo List',
        home: TodoLists()

      );
    }
  }
