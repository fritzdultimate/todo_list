import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;

class TextFieldWidget extends StatelessWidget {
    final String hintText;
    final String labelText;
    final FormFieldSetter<String> onSaved;
    final FormFieldValidator<String> validator;
    final IconData icon;
    final int maxLine;
    final int maxLen;
    final TextCapitalization textCapitalize;
//     final ValueChanged<String> onFieldSubmitted;

     const TextFieldWidget({
          @required this.icon,
          @required this.hintText, 
          @required this.labelText,  
          @required this.onSaved, 
          @required this.validator,
          @required this.maxLine,
          @required this.maxLen,
          @required this.textCapitalize
     });

     @override
     Widget build(BuildContext context) {
          return TextFormField(
            maxLength: maxLen,
            maxLines: maxLine,
            onSaved: onSaved,
            validator: validator,
            textCapitalization: textCapitalize,
            decoration: InputDecoration(
                filled: true,
                hintText: hintText,
                labelText: labelText,
                icon:  new Icon(icon),
            ),
        );
     }

}