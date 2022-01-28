import 'package:flutter/material.dart';
import 'package:showwcase_flutter_challenge/core/utils/colors.dart';
import 'package:showwcase_flutter_challenge/core/utils/enums.dart';

class AppTextField extends StatefulWidget {

  final String? label;
  final String? initialValue;
  final Function()? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;
  final void Function(String?)? onSave;
  final AppTextFieldType textFieldType;
  final Widget? surfixIcon;
  final bool autofocus;
  final FocusNode? focusNode;
  final String tag;
  final Function()? onPrefixIconTapped;
  final TextInputType keyboardType;

  const AppTextField(this.label, {
    this.initialValue,
    this.onTap,
    this.controller,
    this.autofocus = false,
    this.focusNode,
    this.validator,
    this.onSave,
    this.textFieldType = AppTextFieldType.regular,
    this.surfixIcon,
    this.onChange,
    this.tag = "",
    this.onPrefixIconTapped,
    this.keyboardType = TextInputType.text,
    Key? key
  }): super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {


    switch(widget.textFieldType) {

      case AppTextFieldType.password:
        return _passwordTextField();
      default:
        return _regularTextField();
    }
  }


  Widget _regularTextField(){
    const radius = 55.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          initialValue: widget.initialValue,
          onTap: widget.onTap,
          validator: widget.validator,
          autofocus: widget.autofocus,
          focusNode: widget.focusNode,
          onSaved:  widget.onSave,
          onChanged: widget.onChange,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(radius),
            ),
            labelText: widget.label,
            filled: true,
            fillColor:  gray,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(radius),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: gray),
              borderRadius: BorderRadius.circular(radius),
            ),
            suffixIcon: widget.surfixIcon
          ),
        )
        // Container(
        //   decoration: BoxDecoration(
        //       color: Color(0xffE5E5E5),
        //       borderRadius: BorderRadius.circular(28),
        //       border: this.bordered ? Border.all(color: Colors.black) : null
        //   ),
        //   child: ,
        // )
      ],
    );
  }


  Widget _passwordTextField(){

    const radius = 55.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.text,
          initialValue: widget.initialValue,
          onTap: widget.onTap,
          autofocus: widget.autofocus,
          focusNode: widget.focusNode,
          validator: widget.validator,
          onSaved:  widget.onSave,
          obscureText: _obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(radius),
            ),
            labelText: widget.label,
            filled: true,
            fillColor: gray,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(radius),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffE5E5E5)),
              borderRadius: BorderRadius.circular(radius),
            ),
            suffixIcon: UnconstrainedBox(
              child: IconButton(icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off), onPressed: _togglePasswordVisibility ),
            )
          ),
        )
      ],
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


}
