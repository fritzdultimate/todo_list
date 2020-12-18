import 'package:flutter/material.dart';
import 'package:todo_list/features/ui/widgets/add_todo_widget.dart';

class TodoFooterAndAddButton {}

class TodoFooter extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
        return BottomAppBar(
            color: Colors.red[700],
            shape: const CircularNotchedRectangle(),
            child: Container(
                height: 50.0,
            ),
        );
  }

}

class _Button {
    IconData icon;
    Function action;
    _Button({
        @required this.icon,
        this.action
    });

  Widget build(BuildContext context) {
      return FloatingActionButton(
          backgroundColor: Colors.red[700],
          onPressed: () => {
              action(context)
          },
          tooltip: 'Create a todo list',
          child: Icon(icon),
      );
  }

}

class TodoActionButton extends StatelessWidget{
    Function navigate(BuildContext s) {
      Navigator.push(s, MaterialPageRoute(builder: (BuildContext context) => AddTodoWidget()));
    }
  @override
    Widget build(BuildContext context) {
        return _Button(icon: Icons.add, action: navigate)
            .build(context);
    }
    
}

class TodoActionDeleteButton extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
        return _Button(icon: Icons.cancel)
            .build(context);
    }
    
}