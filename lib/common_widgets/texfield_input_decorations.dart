import 'package:flutter/material.dart';

import 'colors.dart';

class InputDecorations {
  static InputDecoration inputDecorationNoBorder({labelText = ""}) =>
      InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 12,
          color: Colors.black.withOpacity(0.4),
        ),
      );

  static InputDecoration inputDecorationAllBorder({labelText = ""}) =>
      InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.grey.withOpacity(0.6), width: 2.0),
          borderRadius: BorderRadius.circular(12),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.6),
            )),
      );
}

class CommonTextfield extends StatefulWidget {
  bool numKeypad;
  String labelText;
  String hintText;
  TextEditingController myController;
  Image image;
  final String? Function(String?)? validator;

  CommonTextfield(
      {Key? key,
      required this.validator,
      required this.hintText,
      required this.labelText,
      required this.myController,
      required this.image,
      this.numKeypad = false})
      : super(key: key);

  @override
  State<CommonTextfield> createState() => _CommonTextfieldState();
}

class _CommonTextfieldState extends State<CommonTextfield> {
  FocusNode myFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType:
            widget.numKeypad ? TextInputType.phone : TextInputType.text,
        validator: widget.validator,
        controller: widget.myController,
        cursorColor: Colors.grey,
        focusNode: myFocusNode,
        decoration: InputDecoration(
          prefixIcon: widget.image,
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.3), width: 2.0),
            borderRadius: BorderRadius.circular(7),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.8), width: 2.0),
            borderRadius: BorderRadius.circular(7),
          ),
          labelText: widget.labelText,
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.black.withOpacity(0.4)),
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: myFocusNode.hasFocus
                ? AppColors.black.withOpacity(0.4)
                : AppColors.black.withOpacity(0.4),
            fontSize: 13,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.6),
              )),
        ));
  }
}
