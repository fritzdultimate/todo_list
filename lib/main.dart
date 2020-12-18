import 'package:flutter/material.dart';

import 'features/ui/pages/todo_lists.dart';

void main() {
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
