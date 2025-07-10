import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tea_checker/utils/color_utils.dart';
import 'package:tea_checker/view/auth/sign_up/sign_up_view_controller.dart';
import 'package:tea_checker/view/auth/sign_up/widget/personal_info_widget.dart';
import 'package:tea_checker/widget/button/custom_elevated_button.dart';
import 'package:tea_checker/widget/input/my_textfield.dart';
import 'package:tea_checker/widget/ui_helper/ui_helper.dart';

class SignUpView extends StatelessWidget {
  final SignUpViewController _controller = Get.put(SignUpViewController());
  SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/logo/logo2.png", height: 160, width: 160),
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorUtils.primary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              // Full Name
              UIHelper().columTitleWithWidget(
                title: 'Full Name *',
                widget: MyTextField(
                  textEditingController: _controller.fullNameController,
                  hintText: 'Enter full name',
                  prefixIcon: Icon(Icons.person, color: ColorUtils.primary),
                  onChanged: (_) => _controller.validateForm(),
                ),
              ),

              // Email
              UIHelper().columTitleWithWidget(
                title: 'Email *',
                widget: MyTextField(
                  textEditingController: _controller.emailController,
                  hintText: 'Enter email address',
                  keyBoardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email, color: ColorUtils.primary),
                  onChanged: (_) => _controller.validateForm(),
                ),
              ),

              // Password
              UIHelper().columTitleWithWidget(
                title: 'Password *',
                widget: Obx(
                  () => MyTextField(
                    textEditingController: _controller.passwordController,
                    hintText: 'Enter password',
                    isPassword: true,
                    isobscureText: _controller.isPasswordHidden.value,
                    isPasswordObscure:
                        (val) => _controller.isPasswordHidden.value = val,
                    onChanged: (_) => _controller.validateForm(),
                    prefixIcon: Icon(Icons.lock, color: ColorUtils.primary),
                  ),
                ),
              ),

              // Confirm Password
              UIHelper().columTitleWithWidget(
                title: 'Confirm Password *',
                widget: Obx(
                  () => MyTextField(
                    textEditingController:
                        _controller.confirmPasswordController,
                    hintText: 'Re-enter password',
                    isPassword: true,
                    isobscureText: _controller.isConfirmHidden.value,
                    isPasswordObscure:
                        (val) => _controller.isConfirmHidden.value = val,
                    onChanged: (_) => _controller.validateForm(),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: ColorUtils.primary,
                    ),
                    errorText: _controller.confirmError.value,
                  ),
                ),
              ),

              SizedBox(height: 24),
              Obx(
                () => CustomElevatedButton(
                  text: 'Continue',
                  onPressed:
                      _controller.isFormValid.value
                          ? () => Get.to(() => PersonalInfoWidget())
                          : null,
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
                            TapGestureRecognizer()..onTap = () => Get.back(),
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
