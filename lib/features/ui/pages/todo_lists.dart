import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/core/ui/widgets/todo_footer_and_add_button.dart';
import 'package:todo_list/features/ui/widgets/todo_item_widget.dart';

class TodoLists extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return
            // widget for home >>> where all todo will be listed...
            Scaffold(
                appBar: AppBar(
                    backgroundColor: Colors.red,
                    title: Text('Todo List App'),
                ),
                body: Center(
                    child: SingleChildScrollView(
                    child: TodoItemWidget()
                    ),
                ),
                bottomNavigationBar: TodoFooter(),
                floatingActionButton: TodoActionButton(),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
    }
}