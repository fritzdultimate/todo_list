import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
// import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';

class AddTodoWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // automaticallyImplyLeading: false,
            title: Text('Add a todo'),
        ),
        body: const TodoTextFormField(),
    );
  }
}

class TodoTextFormField extends StatefulWidget {
    const TodoTextFormField({
        Key key
    }) : super(key: key);
    @override
    TodoTextFormFieldState createState() => TodoTextFormFieldState();

}

class TodoData {
    String title = '';
    String text = '';
    String scheduledDate = '';
    String priority = '';
}

class TitleField extends StatefulWidget {
    final Key fieldKey;
    final String hintText;
    final String labelText;
    final String helperText;
    final FormFieldSetter<String> onSaved;
    final FormFieldValidator<String> validator;
    final ValueChanged<String> onFieldSubmitted;

  const TitleField({Key key, this.fieldKey, this.hintText, this.labelText, this.helperText, this.onSaved, this.validator, this.onFieldSubmitted});
    @override
    _TitleFieldState createState() => _TitleFieldState();

}

class _TitleFieldState extends State<TitleField> {
    bool _obscureText = true;

    @override
    Widget build(BuildContext context) {
        return TextFormField(
            key: widget.fieldKey,
            obscureText: _obscureText,
            maxLength: 10,
            onSaved: widget.onSaved,
            validator: widget.validator,
            onFieldSubmitted: widget.onFieldSubmitted,
            decoration: InputDecoration(
                filled: true,
                hintText: widget.hintText,
                labelText: widget.labelText,
                helperText: widget.helperText,
                suffixIcon: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                        setState(() {
                            _obscureText = !_obscureText;
                        });
                    },
                    child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        // semanticLabel: _obscureText ? GalleryLocalizations,
                    ),
                )
            ),
        );
    }

}

class TodoTextFormFieldState extends State<TodoTextFormField> {
    TodoData todo = TodoData();

    void showInSnackBar(String value) {
        Scaffold.of(context).hideCurrentSnackBar();

        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(value),
        ));
    }

    bool _autovalidate = false;

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final GlobalKey<FormFieldState<String>> _titleFieldKey = GlobalKey<FormFieldState<String>>();

    void _handleSubmitted() {
        final form = _formKey.currentState;
        if(!form.validate()) {
            _autovalidate = true;
            showInSnackBar(
                'error'
            ); 
        } else {
            form.save();
            showInSnackBar('yabo');
        }
    }

    String _validateTitle(String value) {
        if(value.isEmpty) {
            return 'required';
        }
        final nameExp = RegExp(r'^[A-Za-z ]+$');
        if(!nameExp.hasMatch(value)) {
            return 'error alpha';
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
                                sizedBoxSpace,
                                _field(
                                    hint: 'The title of your todo',
                                    icon: Icons.text_fields,
                                    label: 'Todo Title',
                                    maxLi: 1,
                                    maxLe: 25,
                                    onS: (value) {
                                        todo.title = value;
                                    },
                                    vald: _validateTitle
                                ),
                                sizedBoxSpace,
                                _field(
                                    hint: 'What to do - make it descriptive enough, so you could recall after a long time',
                                    icon: Icons.text_format,
                                    label: 'Todo Body',
                                    maxLi: 8,
                                    maxLe: 1000,
                                    onS: (value) {
                                        todo.text = value;
                                    },
                                    vald: _validateTitle
                                ),
                                sizedBoxSpace,
                                Container(
                                    margin: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                                    child: DropdownScreen(),
                                ),
                                sizedBoxSpace,
                                SelectDate(),
                                sizedBoxSpace,
                                Center(
                                    child: RaisedButton(
                                        color: Colors.lightBlueAccent,
                                        child: Text(
                                            'Submit',
                                            style: TextStyle(
                                                color: Colors.white
                                            ),
                                        ),
                                        onPressed: _handleSubmitted,
                                    ),
                                ),
                                sizedBoxSpace,
                            ],
                        ),
                    )
                ),
            )
        );
    }

    TextFormField _field({
        @required IconData icon,
        @required String hint,
        @required String label,
        @required int maxLi,
        @required int maxLe,
        @required Function onS,
        @required Function vald
    }) {
        return TextFormField(
            maxLength: maxLe,
            maxLengthEnforced: true,
            maxLines: maxLi,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
                filled: true,
                icon:  new Icon(icon),
                hintText: hint,
                labelText: label,
                counterText: '33/77'
            ),
            onSaved: (value) => onS(value),
            validator: vald,
        );
    }

}

class Item {
    final String name;
    final Icon icon;

    const Item(this.name, this.icon);
}

class DropdownScreen extends StatefulWidget {
    State createState() => DropdownScreenState();
}

class DropdownScreenState extends State<DropdownScreen> {
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

class SelectDate extends StatefulWidget {
    State createState() => SelectDateState();
    }
    
    class SelectDateState extends State<SelectDate> {
        DateTime selectedDate = DateTime.now(); 
    @override
    Widget build(BuildContext context) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
                Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[700]
                    ),
                ),
                SizedBox(
                    height: 2.0
                ),
                RaisedButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                        'Sheduled date for to do',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold
                        ),
                    ),
                    color: Colors.greenAccent
                ),
            ],
        );
    }

    _selectDate(BuildContext context) async {
        final DateTime picked = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(selectedDate.year),
            lastDate: DateTime(selectedDate.year + 10)
        );
        if(picked != null && picked != selectedDate) {
            setState(() {
                selectedDate = picked;
            });
        }
    }
}