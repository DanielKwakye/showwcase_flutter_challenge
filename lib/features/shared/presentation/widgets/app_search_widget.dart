import 'package:flutter/material.dart';
import 'package:showwcase_flutter_challenge/core/utils/colors.dart';

class AppSearchWidget extends StatelessWidget {

  final String placeholder;
  final Function(String?)? onTextChanged;
  final Function()? onTap;
  final Icon? rightIcon;
  final Icon? leftIcon;
  final bool readOnly;
  final TextEditingController? controller;
  final Function()? rightIconTapped;

  const AppSearchWidget({
    Key? key,
    this.placeholder = 'Search ....',
    this.onTextChanged,
    this.readOnly = false,
    this.onTap,
    this.rightIcon,
    this.leftIcon,
    this.controller,
    this.rightIconTapped
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final radius = 15.0;

    return TextFormField(
      onChanged: this.onTextChanged,
      readOnly: this.readOnly,
      controller: this.controller,
      onTap: this.onTap ?? () {},
      style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(radius),
          ),
          labelText: placeholder,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor:  gray,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(radius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(radius),
          ),

          prefixIcon: this.leftIcon != null ? Container(
            height: 30,
            child: this.leftIcon,
          ) : null,

          suffixIcon: this.rightIcon != null ? InkWell(
            onTap: this.rightIconTapped,
            child: Container(
              height: 30,
              child: this.rightIcon,
            ),
          ) : null,

        ));
  }
}
