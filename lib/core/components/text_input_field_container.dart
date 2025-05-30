
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputFieldContainer extends StatelessWidget {
  const TextInputFieldContainer(
      {
        super.key,
        required this.hintText,
        required this.controller,
        required this.Label,
        this.validator,
        this.maxlines
      });

  final String Label;
  final String hintText;
  final TextEditingController controller;
  final int? maxlines;
  final Function(String?)? validator;


  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Label, style: Theme.of(context).textTheme.displaySmall),
          SizedBox(height: 12),
          TextFormField(
            controller: controller,
            maxLines: maxlines,
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(hintText: hintText),
            validator: (String? value) {
              if (validator != null) {
                return validator!(value);
              }
              return null;
            }
          )
        ],
    );
  }
}
