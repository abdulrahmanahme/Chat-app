import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget(
      {this.labelText,
      this.hintText,
      this.suffixIcon,
      this.controller,
      this.fillColor,
      this.prefix,
      this.keyboardTyp,
      this.label,
      this.labelStyle,
      this.maxLines,
      this.onChanged,
      this.onFieldSubmitted,
      this.style,
      this.validator,
      this.obscureText = false,
      this.focusNode,
      this.onTap,
      super.key,
      this.inputFormatters,
      this.initialValue,
      this.readOnly = false});

  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffixIcon;
  final String? labelText;
  final Color? fillColor;
  final Widget? prefix;
  final int? maxLines;
  final TextStyle? labelStyle;
  final String? label;
  final TextStyle? style;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool obscureText;
  final TextInputType? keyboardTyp;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final bool readOnly;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool _fillColor = false;

  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _fillColor = !_fillColor;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode ?? _focus,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardTyp ?? TextInputType.text,
      obscureText: widget.obscureText,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      validator: widget.validator,
      maxLines: widget.maxLines,
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
      onTap: widget.onTap,
      initialValue: widget.initialValue,
      readOnly:  widget.readOnly,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: widget.labelStyle,
        hintText: widget.hintText,
        // hintStyle: AppTextStyle.font16darkGray400,
        // fillColor: widget.fillColor ?? AppColor.primaryColor.withOpacity(0.15),
        filled: _fillColor,
        
        // focusColor: const Color(0xff116ACC),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(8.0),
        //   borderSide: const BorderSide(
        //     color: Colors.blue,
        //     width: 1.0,
        //   ),
        // ),
        errorStyle:const TextStyle(
          color: Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.w400
        ),
        contentPadding:const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        prefixIcon: widget.prefix,
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(8.0),
        //   borderSide: const BorderSide(
        //     color:Colors.grey,
        //     width: 1.0,
        //   ),
        // ),
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(8.0),
        //   borderSide: const BorderSide(
        //     color: Colors.red,
        //     width: 1.0,
        //   ),
        // ),
        suffixIcon: widget.suffixIcon,
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(8.0),
        //   borderSide: const BorderSide(
        //     color: Colors.black,
        //   ),
        // ),
      ),
    );
  }
}
