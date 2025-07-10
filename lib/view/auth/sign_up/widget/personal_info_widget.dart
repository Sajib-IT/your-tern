import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tea_checker/utils/color_utils.dart';
import 'package:tea_checker/view/auth/sign_up/sign_up_view_controller.dart';
import 'package:tea_checker/widget/button/custom_elevated_button.dart';
import 'package:tea_checker/widget/dialog/alert_custom_dialog.dart';
import 'package:tea_checker/widget/drop_down/my_dropdown_button.dart';
import 'package:tea_checker/widget/input/my_textfield.dart';
import 'package:tea_checker/widget/ui_helper/ui_helper.dart';

class PersonalInfoWidget extends StatelessWidget {
  final SignUpViewController _controller = Get.find();
  PersonalInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/logo/logo2.png", height: 150, width: 150),
              Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorUtils.primary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              // Obx(() {
              //   return Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       DatePickerField(
              //         title: 'Date of Birth *',
              //         pickedDate: _controller.dob.value,
              //         firstDate: DateTime(1900),
              //         lastDate: DateTime.now(),
              //         callback: (val) {
              //           final birth = DateTime.parse(val);
              //           final formatted =
              //               DateFormat('dd-MM-yyyy').format(birth);
              //           _controller.dob.value = formatted;
              //           final today = DateTime.now();
              //           int years = today.year - birth.year;
              //           if (today.month < birth.month ||
              //               (today.month == birth.month &&
              //                   today.day < birth.day)) {
              //             years--;
              //           }
              //           _controller.age.value = years;
              //           _controller.ageController.text = years.toString();
              //           _controller.validateForm();
              //         },
              //         isDelete: _controller.dob.value.isNotEmpty,
              //         onPressedForDeleteDate: () {
              //           _controller.dob.value = '';
              //           _controller.age.value = 0;
              //           _controller.ageController.clear();
              //           _controller.validateForm();
              //         },
              //       ),
              //       if (_controller.age.value > 0)
              //         UIHelper().columTitleWithWidget(
              //           title: "Age *",
              //           widget: Padding(
              //             padding: const EdgeInsets.only(top: 8),
              //             child: MyTextField(
              //               textEditingController: _controller.ageController,
              //               hintText: 'Auto-filled age',
              //               isReadOnly: true,
              //               prefixIcon: Icon(Icons.calendar_today,
              //                   color: ColorUtils.primary),
              //             ),
              //           ),
              //         ),
              //     ],
              //   );
              // }),
              Obx(
                () => UIHelper().columTitleWithWidget(
                  title: "Mobile *",
                  widget: MyTextField(
                    textEditingController: _controller.phoneController,
                    keyBoardType: TextInputType.phone,
                    hintText: "Enter your mobile number",
                    prefixIcon: Icon(Icons.phone, color: ColorUtils.primary),
                    onChanged: (val) => _controller.onPhoneChanged(val),
                    errorText: _controller.phoneError.value,
                  ),
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
                          _controller.validateForm();
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
                          _controller.validateForm();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // HeightInputField(
              //   feetController: _controller.feetController,
              //   inchController: _controller.inchController,
              //   feetOnChanged: (value) =>
              //       _controller.feet.value = int.parse(value),
              //   inchOnChanged: (value) =>
              //       _controller.inch.value = int.parse(value),
              // ),
              // UIHelper().columTitleWithWidget(
              //     title: 'Weight *',
              //     widget: SuffixTextField(
              //       textEditingController: _controller.weightController,
              //       onChanged: (value) {
              //         _controller.weight.value = int.parse(value);
              //       },
              //       keyBoardType: TextInputType.number,
              //       suffixText: "  Kg  ",
              //       hintText: "Enter weight",
              //     )),
              UIHelper().columTitleWithWidget(
                title: 'Present Address *',
                widget: MyTextField(
                  textEditingController: _controller.presentAddressController,
                  hintText: 'Enter present address',
                  prefixIcon: Icon(
                    Icons.add_location,
                    color: ColorUtils.primary,
                  ),
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
              Obx(
                () => CustomElevatedButton(
                  text: 'Create Account',
                  backgroundColor:
                      !_controller.validateForm2()
                          ? Colors.grey.shade300
                          : null,
                  onPressed: () {
                    if (_controller.validateForm2()) {
                      _controller.signUp();
                    } else {
                      AlertCustomDialogs().showAlert(
                        msg: "Please fill up all required field",
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          color: ColorUtils.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.back();
                                Get.back();
                              },
                        // ..onTap = () => Get.to(() => SignInView()),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
