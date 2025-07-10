import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_checker/view/auth/sign_in/sign_in_view.dart';
import 'package:tea_checker/view/auth/verify_email/verify_email_screen.dart';
import 'package:tea_checker/view/tabs/tabs_view.dart';

class SplashViewController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  @override
  void onInit() {
    appInit();
    super.onInit();
  }

  void appInit() async {
    await Future.delayed(const Duration(seconds: 3));
    User? user = supabase.auth.currentUser;
    if (user != null && user.emailConfirmedAt != null) {
      // print(user);
      print(user.emailConfirmedAt);
      Get.off(() => TabsView());
    } else {
      Get.off(() => SignInView());
    }
  }
}
