import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_checker/model/user_model.dart';
import 'package:tea_checker/view/auth/verify_email/verify_email_screen.dart';
import 'package:tea_checker/widget/dialog/alert_custom_dialog.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> signIn(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
    } on AuthApiException catch (e) {
      print(e.message);
      String userMessage;
      switch (e.message) {
        case 'Email not confirmed':
          userMessage = 'Please verify your email first';
          Get.to(() => VerifyEmailScreen(email: email));
          break;
        case 'Invalid login credentials':
          userMessage = 'Incorrect email or password';
          break;
        case 'Too many requests':
          userMessage = 'Too many attempts. Please try again later';
          break;
        default:
          userMessage = 'Login failed. Please try again';
      }

      AlertCustomDialogs().showAlert(msg: userMessage);

      EasyLoading.dismiss();
    }
  }

  Future<void> signUp(UserModel userModel) async {
    await supabase.auth.signUp(
      email: userModel.email,
      password: userModel.password,
      emailRedirectTo: 'io.supabase.flutter://login-callback/',
      // phone: userModel.mobile,
      data: userModel.toJson(),
    );
  }
}
