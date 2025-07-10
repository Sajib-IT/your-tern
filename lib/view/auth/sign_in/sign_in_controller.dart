import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_checker/view/auth/verify_email/verify_email_screen.dart';
import 'package:tea_checker/view/tabs/tabs_view.dart';
import 'package:tea_checker/widget/dialog/alert_custom_dialog.dart';

class SignInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // final FirebaseAuth auth = FirebaseAuth.instance;
  final SupabaseClient supabase = Supabase.instance.client;
  RxBool isPasswordHidden = true.obs;
  RxBool isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(validateForm);
    passwordController.addListener(validateForm);
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }

  void validateForm() {
    final emailOK = GetUtils.isEmail(emailController.text.trim());
    final passOK = passwordController.text.length >= 6;
    isFormValid.value = emailOK && passOK;
  }

  Future<void> signIn() async {
    // AuthService().supabase.auth.signOut();
    EasyLoading.show(status: "Loading...");
    try {
      await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on AuthApiException catch (e) {
      print(e.message);
      switch (e.message) {
        case 'Email not confirmed':
          Get.to(
            () => VerifyEmailScreen(email: emailController.text),
            arguments: emailController.text,
          );
          EasyLoading.dismiss();
          return;
        case 'Invalid login credentials':
          AlertCustomDialogs().showAlert(msg: 'Incorrect email or password');
          EasyLoading.dismiss();
          return;
        case 'Too many requests':
          AlertCustomDialogs().showAlert(
            msg: 'Too many attempts. Please try again later',
          );
          EasyLoading.dismiss();
          return;
        default:
          AlertCustomDialogs().showAlert(msg: 'Login failed. Please try again');
          EasyLoading.dismiss();
          return;
      }
    }
    Get.offAll(() => TabsView());
    EasyLoading.dismiss();
    // await AuthService().signIn(emailController.text, passwordController.text);
    // print(AuthService().supabase.auth.currentUser);
    // print(AuthService().supabase.auth.currentUser?.emailConfirmedAt);
    // print(AuthService().supabase.auth.currentUser!.id.toString());
    // print(AuthService().supabase.auth.currentUser!.userMetadata);
    // EasyLoading.dismiss();
  }

  // void userNavigate(User? user) async {
  //   if (user != null) {
  //     await UserRoleService().initialize(user.uid);
  //     String role = UserRoleService().role!;
  //     if (role == UserRole.patient.name) {
  //       Get.off(() => PatientTabView());
  //     }
  //     if (role == UserRole.doctor.name) {
  //       Get.off(() => DoctorTabView());
  //     }
  //     if (role == UserRole.admin.name) {
  //       Get.off(() => AdminTabView());
  //     }
  //     if (role == UserRole.superAdmin.name) {
  //       Get.off(() => SuperAdminTabView());
  //     }
  //   }
  // }
}
