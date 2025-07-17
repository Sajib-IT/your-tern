import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tea_checker/utils/color_utils.dart';
import 'package:tea_checker/view/tabs/profile/profile_controller.dart';
import 'package:tea_checker/widget/button/custom_elevated_button.dart';
import 'package:tea_checker/widget/button/yes_no_radio_button.dart';
import 'package:tea_checker/widget/drop_down/my_dropdown_button.dart';
import 'package:tea_checker/widget/input/date_picker_field.dart';
import 'package:tea_checker/widget/input/my_textfield.dart';
import 'package:tea_checker/widget/input/suffix_textfield.dart';
import 'package:tea_checker/widget/ui_helper/document_option_dialog.dart';
import 'package:tea_checker/widget/ui_helper/height_input_field.dart';
import 'package:tea_checker/widget/ui_helper/ui_helper.dart';

class EditProfileView extends StatelessWidget {
  final ProfileController _controller = Get.find();
  EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {

                await DocumentOptionDialog().show(
                  callback: (value) {
                    _controller.documentToUpload.value = value;
                    if (_controller.documentToUpload.value != null) {
                      _controller.uploadProfileImageToBucket();
                    }
                  },
                );
              },
              child: Obx(
                () =>
                    _controller.documentToUpload.value == null
                        ? CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              _controller.user.value!['profileImageUrl'] != null
                                  ? NetworkImage(
                                    _controller.user.value!['profileImageUrl']!,
                                  )
                                  : const AssetImage("assets/logo/logo.png")
                                      as ImageProvider,
                          child: Align(
                            alignment: const Alignment(0.8, 0.8),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorUtils.primary,
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 25,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        )
                        : CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(
                            _controller.documentToUpload.value!,
                          ),
                          child: Align(
                            alignment: const Alignment(0.8, 0.8),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorUtils.primary,
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
              ),
            ),
            UIHelper().columTitleWithWidget(
              title: 'Full Name *',
              widget: MyTextField(
                textEditingController: _controller.fullNameController,
                hintText: 'Enter full name',
                prefixIcon: Icon(Icons.person, color: ColorUtils.primary),
              ),
            ),
            UIHelper().columTitleWithWidget(
              title: "Mobile *",
              widget: MyTextField(
                textEditingController: _controller.phoneController,
                keyBoardType: TextInputType.phone,
                hintText: "Enter your mobile number",
                prefixIcon: Icon(Icons.phone, color: ColorUtils.primary),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: UIHelper().columTitleWithWidget(
                    title: "Gender *",
                    widget: MyDropdownButton(
                      value: _controller.selectedGender.value,
                      hint: "Select one",
                      items: _controller.genderList,
                      onChanged: (val) {
                        _controller.selectedGender.value = val ?? '';
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: UIHelper().columTitleWithWidget(
                    title: "Blood Group *",
                    widget: MyDropdownButton(
                      value: _controller.selectedBloodGroup.value,
                      hint: "Select one",
                      items: _controller.bloodGroupList,
                      onChanged: (val) {
                        _controller.selectedBloodGroup.value = val ?? '';
                      },
                    ),
                  ),
                ),
              ],
            ),
            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DatePickerField(
                    title: 'Date of Birth *',
                    pickedDate: _controller.dob.value,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    callback: (val) {
                      final birth = DateTime.parse(val);
                      final formatted = DateFormat('dd-MM-yyyy').format(birth);
                      _controller.dob.value = formatted;
                      final today = DateTime.now();
                      int years = today.year - birth.year;
                      if (today.month < birth.month ||
                          (today.month == birth.month &&
                              today.day < birth.day)) {
                        years--;
                      }
                      _controller.age.value = years;
                      _controller.ageController.text = years.toString();
                    },
                    isDelete: _controller.dob.value.isNotEmpty,
                    onPressedForDeleteDate: () {
                      _controller.dob.value = '';
                      _controller.age.value = 0;
                      _controller.ageController.clear();
                    },
                  ),
                  if (_controller.age.value > 0)
                    UIHelper().columTitleWithWidget(
                      title: "Age *",
                      widget: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: MyTextField(
                          textEditingController: _controller.ageController,
                          hintText: 'Auto-filled age',
                          isReadOnly: true,
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: ColorUtils.primary,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
            // HeightInputField(
            //   feetController: _controller.feetController,
            //   inchController: _controller.inchController,
            //   feetOnChanged:
            //       (value) => _controller.feet.value = int.parse(value),
            //   inchOnChanged:
            //       (value) => _controller.inch.value = int.parse(value),
            // ),
            // UIHelper().columTitleWithWidget(
            //   title: 'Weight *',
            //   widget: SuffixTextField(
            //     textEditingController: _controller.weightController,
            //     onChanged: (value) {
            //       _controller.weight.value = int.parse(value);
            //     },
            //     keyBoardType: TextInputType.number,
            //     suffixText: "  Kg  ",
            //     hintText: "Enter weight",
            //   ),
            // ),
            YesNoRadio(title: "Are you Active ?",onChanged: (v){
             _controller.selectedActive.value = v;
            },),
            UIHelper().columTitleWithWidget(
              title: 'Present Address *',
              widget: MyTextField(
                textEditingController: _controller.presentAddressController,
                hintText: 'Enter present address',
                prefixIcon: Icon(Icons.add_location, color: ColorUtils.primary),
                onChanged: (value) {
                  _controller.presentAddress.value = value;
                },
              ),
            ),
            UIHelper().columTitleWithWidget(
              title: 'Permanent Address *',
              widget: MyTextField(
                textEditingController: _controller.permanentAddressController,
                hintText: 'Enter permanent address',
                prefixIcon: Icon(
                  Icons.add_location_alt,
                  color: ColorUtils.primary,
                ),
                onChanged: (value) {
                  _controller.permanentAddress.value = value;
                },
              ),
            ),
            SizedBox(height: 24),
            CustomElevatedButton(
              text: 'Update',
              onPressed: () async {
                if (_controller.checkForm()) {
                  await _controller.updateUserData();
                  Get.back(result: true);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
