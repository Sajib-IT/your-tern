import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_checker/view/auth/sign_in/sign_in_view.dart';
import 'package:tea_checker/view/auth/verify_email/verify_email_controller.dart';
import 'package:tea_checker/widget/button/custom_elevated_button.dart';

class VerifyEmailScreen extends StatelessWidget {
  final String email;
  final VerifyEmailController _controller = Get.put(VerifyEmailController());

  VerifyEmailScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Your Email'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Verification Required',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 16),
                children: [
                  const TextSpan(text: 'We sent a verification link to '),
                  TextSpan(
                    text: email,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text:
                        '. Please check your inbox and click the link to verify your account.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Didn't receive the email?",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            Obx(
              () =>
                  _controller.isLoading.value
                      ? Center(child: const CircularProgressIndicator())
                      : CustomElevatedButton(
                        text: 'Resend Verification Email',
                        onPressed: () {
                          _controller.resendVerificationEmail(email);
                        },
                      ),
            ),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () {
                Get.offAll(() => SignInView());
              },
              child: const Text(
                'Back to Login',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
