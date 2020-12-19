import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;

class TextFieldWidget extends StatelessWidget {
    final String hintText;
    final String labelText;
    final String helperText;
    final FormFieldSetter<String> onSaved;
    final FormFieldValidator<String> validator;
//     final ValueChanged<String> onFieldSubmitted;

  const TextFieldWidget({this.hintText, this.labelText, this.helperText, this.onSaved, this.validator});

     @override
     Widget build(BuildContext context) {
          return TextFormField(
            maxLength: 10,
            onSaved: onSaved,
            validator: validator,
          //   onFieldSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
                filled: true,
                hintText: hintText,
                labelText: labelText,
                helperText: helperText,
                suffixIcon: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    child: Icon(
                        Icons.visibility,
                    ),
                )
            ),
        );
     }

}