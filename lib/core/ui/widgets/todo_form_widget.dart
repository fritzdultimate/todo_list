import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:todo_list/core/ui/widgets/text_field_widget.dart';
import 'package:todo_list/features/data/models/todo_list_model.dart';
import 'package:hive/hive.dart';
import 'dropdown_widget.dart';

String formHeader = 'some test';
class TodoFormWidget extends StatelessWidget {
    final String header;

    TodoFormWidget({Key key, @required this.header}) {
        formHeader = header;
    }

    @override
    Widget build(BuildContext context) {
        return Card(
                child: TodoTextFormField(),
            elevation: 10.0,
            margin: EdgeInsets.all(20.0),
            shadowColor: Colors.grey[300],
        );
    }
    
}

class TodoData {
    String title = '';
    String text = '';
    String priority = '';
}


class TodoTextFormField extends StatefulWidget {
    const TodoTextFormField({
        Key key
    }) : super(key: key);
    @override
    TodoTextFormFieldState createState() => TodoTextFormFieldState();

}

class TodoTextFormFieldState extends State<TodoTextFormField> {
    TodoData todo = TodoData();

    void showInSnackBar(String value, Color bg, Color color) {
        Scaffold.of(context).hideCurrentSnackBar();

        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
                value,
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
            ),
            backgroundColor: bg,
            duration: Duration(seconds: 5),

        ));
    }

    bool _autovalidate = false;

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final GlobalKey<FormFieldState<String>> _titleFieldKey = GlobalKey<FormFieldState<String>>();

    void _handleSubmitted() async {
        final form = _formKey.currentState;
        if(!form.validate()) {
            _autovalidate = true;
            showInSnackBar(
                'Please review errors on the form to continue!',
                Colors.red[700],
                Colors.white
            ); 
        } else {
            Map data = {
                "title": TodoData().title,
                "text": TodoData().text,
                "priority": TodoData().priority
            };
            form.save();
            var result = await TodoListModel().createTodo(data);
            showInSnackBar(
                'Todo Created Successfully!' + result,
                Colors.green[600],
                Colors.white
            );
            
        }
    }

    String _validateTitle(String value) {
        if(value.isEmpty) {
            return 'please write your todo title';
        }
        final nameExp = RegExp(r'^[A-Za-z ]+$');
        if(!nameExp.hasMatch(value)) {
            return 'only alphabets and space are accepted';
        }
        if(value.length < 5) {
            return 'minimum of 5 chars. is required';
        }
        return null;
    }

    String _validateBody(String value) {
        if(value.isEmpty) {
            return 'please write something about the todo';
        }
        if(value.length < 25) {
            return 'minimum of 25 chars. is required';
        }
        return null;
    }

    @override
    Widget build(BuildContext context) {
        const sizedBoxSpace = SizedBox(
            height: 24
        );
        return Scaffold(
            body: Form(
                key: _formKey,
                autovalidate: _autovalidate,
                child: Scrollbar(
                    child: SingleChildScrollView(
                        dragStartBehavior: DragStartBehavior.down,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                                Container(
                                    // color: Colors.red[700],
                                    child: ListTile(
                                        title: Center(
                                            child: Text(
                                                formHeader,
                                                style: TextStyle(
                                                    color: Colors.red[700],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0,
                                                ),
                                            )
                                        ),
                                    ),
                                ),
                                sizedBoxSpace,
                                TextFieldWidget(
                                    icon: Icons.text_fields,
                                    hintText: 'The title of your todo',
                                    labelText: 'Todo Title',
                                    maxLen: 25,
                                    maxLine: 1,
                                    textCapitalize: TextCapitalization.words,
                                    onSaved: (value) {
                                        todo.title = value;
                                    },
                                    validator: _validateTitle,
                                ).build(context),
                                sizedBoxSpace,
                                TextFieldWidget(
                                    icon: Icons.text_format,
                                    hintText: 'Todo description - make it long and descriptive for easier understanding in a long time.',
                                    labelText: 'Todo Description',
                                    maxLen: 1000,
                                    maxLine: 8,
                                    textCapitalize: TextCapitalization.sentences,
                                    onSaved: (value) {
                                        todo.text = value;
                                    },
                                    validator: _validateBody,
                                ).build(context),
                                sizedBoxSpace,
                                Container(
                                    margin: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                                    child: DropDownWidget(),
                                ),
                                sizedBoxSpace,
                                Center(
                                    child: RaisedButton(
                                        color: Colors.red[700],
                                        child: Text(
                                            'Submit',
                                            style: TextStyle(
                                                color: Colors.white
                                            ),
                                        ),
                                        onPressed: _handleSubmitted,
                                    ),
                                ),
                            ],
                        ),
                    )
                ),
            )
        );
    }
}