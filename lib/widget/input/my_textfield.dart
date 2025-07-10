import 'package:flutter/material.dart';

import '../../../utils/color_utils.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String hintText;
  final String? errorText;
  final int? maxLine;
  final TextInputType keyBoardType;
  final TextInputAction textInputAction;
  final Function? onChanged;
  final Function? onSubmitted;
  bool isobscureText;
  final Function? isPasswordObscure;
  final bool isPassword;
  final bool isReadOnly;
  Widget? suffixIcon;
  Widget? prefixIcon;

  MyTextField({
    super.key,
    this.textEditingController,
    this.hintText = '',
    this.keyBoardType = TextInputType.text,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.isPasswordObscure,
    this.isobscureText = false,
    this.isPassword = false,
    this.isReadOnly = false,
    this.errorText, this.maxLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      obscureText: isobscureText,
      readOnly: isReadOnly,
      maxLines: maxLine,
      onChanged: (value) => onChanged?.call(value),
      onSubmitted: (value) => onSubmitted?.call(value),
      // style: const TextStyle(
      //   color: Colors.black,
      //   fontSize: 20,
      //   fontWeight: FontWeight.w500,
      // ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        prefixIcon: prefixIcon,
        hintText: hintText,
        errorText: errorText?.isNotEmpty == true ? errorText : null,
        suffixIcon: isPassword
            ? GestureDetector(
          onTap: () {
            isobscureText = !isobscureText;
            isPasswordObscure?.call(isobscureText);
          },
          child: Icon(
            isobscureText ? Icons.visibility_off : Icons.visibility,
            color: ColorUtils.primary,
            size: 18,
          ),
        )
            : suffixIcon,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorUtils.primary),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      keyboardType: keyBoardType,
      textInputAction: textInputAction,
    );
  }
}

