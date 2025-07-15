
import 'package:flutter/material.dart';
import 'package:tea_checker/widget/input/suffix_textfield.dart';
import 'package:tea_checker/widget/ui_helper/ui_helper.dart';

class HeightInputField extends StatelessWidget {
  final TextEditingController? feetController;
  final TextEditingController? inchController;
  final Function(String) feetOnChanged;
  final Function(String) inchOnChanged;

  const HeightInputField(
      {super.key,
      required this.feetOnChanged,
      required this.inchOnChanged,
      this.feetController,
      this.inchController});

  @override
  Widget build(BuildContext context) {
    return UIHelper().columTitleWithWidget(
        title: 'Height *',
        widget: Row(
          children: [
            Expanded(
              child: SuffixTextField(
                textEditingController: feetController,
                hintText: '0',
                length: 2,
                keyBoardType: TextInputType.number,
                onChanged: (value) {
                  feetOnChanged(value);
                },
                suffixText: 'Feet',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SuffixTextField(
                textEditingController: inchController,
                hintText: '0',
                length: 2,
                keyBoardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  inchOnChanged(value);
                },
                suffixText: 'Inch',
              ),
            )
          ],
        ));
  }
}
