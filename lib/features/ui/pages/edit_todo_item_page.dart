import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/core/ui/widgets/todo_footer_and_add_button.dart';

class EditTodoItemPage extends StatelessWidget {
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
                    child: Container(
                      child: Text('some text here')
                    )
                ),
                bottomNavigationBar: TodoFooter(),
                floatingActionButton: TodoActionDeleteButton(),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
    }
}