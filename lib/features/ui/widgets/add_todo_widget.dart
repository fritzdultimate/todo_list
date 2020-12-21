import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:todo_list/core/ui/widgets/todo_form_widget.dart';

class AddTodoWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[700],
            title: Text('Add a todo'),
        ),
        body: Container(
            color: Colors.white70,
            child: TodoFormWidget(header: 'Create a todo item',))
    );
  }
}

