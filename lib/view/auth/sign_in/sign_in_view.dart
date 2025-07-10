import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_checker/utils/color_utils.dart';
import 'package:tea_checker/view/auth/sign_in/sign_in_controller.dart';
import 'package:tea_checker/view/auth/sign_up/sign_up_view.dart';
import 'package:tea_checker/widget/button/custom_elevated_button.dart';
import 'package:tea_checker/widget/input/my_textfield.dart';
import 'package:tea_checker/widget/ui_helper/ui_helper.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});
  final SignInController _controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/logo/logo2.png", height: 175, width: 175),
                Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: ColorUtils.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
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
                SizedBox(height: 32),
                Obx(
                  () => CustomElevatedButton(
                    text: "Sign In",
                    onPressed: _controller.isFormValid.value ? _controller.signIn : null,
                  ),
                ),

                SizedBox(height: 36),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    text: "Don't have any account ? ",
                    children: [
                      TextSpan(
                        style: TextStyle(
                          //decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorUtils.primary,
                        ),
                        text: "SignUp",
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => SignUpView());
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
