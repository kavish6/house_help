import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      this.height, this.text, this.obscure, this._focusNode, this.change);
  final double height;
  final String text;
  final bool obscure;
  final FocusNode _focusNode;
  final Function change;
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        widget.change(text);
      },
      focusNode: widget._focusNode,
      obscureText: widget.obscure,
      keyboardType: widget.obscure
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade600),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade600),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0))),
          filled: true,
          fillColor: Color(0xff1e1c24),
          hintText: widget.text,
          hintStyle: TextStyle(
            wordSpacing: 3.0,
            color: Colors.grey.shade600,
            fontFamily: 'DelaGothicOne',
            fontSize: (widget.height * .018),
          )),
    );
  }
}
