import 'package:flutter/material.dart';
import 'package:todo_list/features/ui/pages/edit_todo_item_page.dart';

class TodoItemWidget extends StatelessWidget {
    BuildContext s;
    @override
    Widget build(BuildContext context) {
        s = context;
        return Column (
            children: [
                sl(),
                sl(),
                sl(),
                sl(),
                sl(),
                sl(),
                sl(),
            ],
        );
    }
    
    Widget sl() {
        return new GestureDetector(
            onTap: () {
                Navigator.push(s, MaterialPageRoute(builder: (BuildContext context) => EditTodoItemPage()));
            },
            child: Card(
        margin: EdgeInsets.all(3.0),
        elevation: 10.0,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                Container(
                    color: Colors.yellow[700],
                    child: Column(
                        children: [
                            ListTile(
                                leading: Icon(Icons.star, size: 25),
                                trailing: Text(
                                    '2020/12/09',
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.bold
                                    ),
                                ),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 7.0),
                                child: const ListTile(
                                    title: Text('Richly Blessed'),
                                    subtitle: Text('Best of rictee jrjuibf enned ffdniiof fdjiudf uunn jjjj jjjj jjjj iiiin iiii iiii iiii'),
                                ),
                            )
                        ],
                    ),
                )
            ],
        )
    )
 
        );
    }
}