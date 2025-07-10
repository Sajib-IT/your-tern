import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tea_checker/utils/color_utils.dart';

class SuffixTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String suffixText;
  final String hintText;
  final TextInputType keyBoardType;
  final TextInputAction textInputAction;
  final Function? onChanged;
  final int? length;

  const SuffixTextField(
      {super.key,
      this.textEditingController,
      required this.suffixText,
      required this.hintText,
      this.keyBoardType = TextInputType.text,
      this.onChanged,
      this.textInputAction = TextInputAction.next,
      this.length});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController ?? TextEditingController(),
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      maxLength: keyBoardType == TextInputType.phone ? 11 : length,
      // focusNode: FocusNode(),
      autofocus: false,
      style: const TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        suffixIcon: Container(
          margin: const EdgeInsets.only(left: 14, right: 1),
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
          decoration: BoxDecoration(
            color: ColorUtils.greyF4F4F4,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0)),
            // border: Border.all(color: Colors.grey)
          ),
          child: Text(suffixText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              )),
        ),
        suffixIconConstraints: const BoxConstraints(maxHeight: 64),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        // counter: Container(),
        counterText: '',
        hintStyle: const TextStyle(
            color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
        hintText: hintText,
        focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: ColorUtils.primary),
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorUtils.greyE0E0E0),
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
      inputFormatters: keyBoardType == TextInputType.phone ||
              keyBoardType == TextInputType.number ||
              keyBoardType ==
                  const TextInputType.numberWithOptions(signed: true)
          ? [FilteringTextInputFormatter.digitsOnly]
          : [FilteringTextInputFormatter.singleLineFormatter],
      keyboardType: keyBoardType,
      textInputAction: textInputAction,
    );
  }
}
