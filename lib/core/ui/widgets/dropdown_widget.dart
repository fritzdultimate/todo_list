import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/core/ui/widgets/todo_form_widget.dart';

class DropDownWidget extends StatefulWidget{
    State createState() => DropDownWidgetState();
}

class Item {
    final String name;
    final Icon icon;
    const Item(this.name, this.icon);

    static setPriority(String value) {
        TodoData().priority = value;
    }
}

class DropDownWidgetState extends State<DropDownWidget> {
    Item selectedItem;
    String selected = '';
    List<Item> priorities = <Item> [
        const Item('low', Icon(Icons.low_priority, color: const Color(0xFF167F67))),
        const Item('medium', Icon(Icons.low_priority, color: const Color(0xFF167F67))),
        const Item('high', Icon(Icons.priority_high, color: const Color(0xFF167F67)))
    ];

    

    @override
    Widget build(BuildContext context) {
        return DropdownButtonFormField(
            hint: Text('Select priority'),
            value: selectedItem,
            onChanged: (Item value) {
                setState(() {
                    selectedItem = value;
                    selected = value.name;
                    Item.setPriority(value.name);
                });
            },
            items: priorities.map((Item priority) {
                return DropdownMenuItem<Item>(
                    value: priority,
                    child: Row(
                        children: <Widget>[
                            priority.icon,
                            SizedBox(width: 10),
                            Text(
                                priority.name.substring(0, 1).toUpperCase() + priority.name.substring(1),
                                style: TextStyle(color: Colors.black)
                            ),
                        ],
                    ),
                );
            }).toList(),
            validator: ( Item selectedItem) {
                if(selected.isEmpty) {
                    return 'Please choose your todo priority.';
                }
                return null;
            },
        );
    }
}