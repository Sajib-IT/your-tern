import 'package:flutter/material.dart';
import 'package:tea_checker/utils/color_utils.dart';

class YesNoRadio extends StatefulWidget {
  final String title;
    String selectedValue;
  final void Function(String)? onChanged;

   YesNoRadio({super.key, required this.title, this.onChanged, required this.selectedValue});

  @override
  _YesNoRadioState createState() => _YesNoRadioState();
}

class _YesNoRadioState extends State<YesNoRadio> {
  // String? selectedValue = 'Yes';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                // padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        widget.selectedValue == "Yes"
                            ? ColorUtils.primary
                            : Colors.grey,
                  ),
                  color: widget.selectedValue == "Yes" ? ColorUtils.background : null,
                ),
                child: RadioListTile<String>(
                  visualDensity: VisualDensity.compact,
                  title: const Text('Yes'),
                  value: 'Yes',
                  groupValue: widget.selectedValue,
                  onChanged: (value) {
                    setState(() => widget.selectedValue = value!);
                    widget.onChanged?.call(value!);
                  },
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                    widget.selectedValue == "No"
                            ? ColorUtils.primary
                            : Colors.grey,
                  ),
                  color: widget.selectedValue == "No" ? ColorUtils.background : null,
                ),
                child: RadioListTile<String>(
                  visualDensity: VisualDensity.compact,
                  title: const Text('No'),
                  value: 'No',
                  groupValue: widget.selectedValue,
                  onChanged: (value) {
                    setState(() => widget.selectedValue = value!);
                    widget.onChanged?.call(value!);
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
