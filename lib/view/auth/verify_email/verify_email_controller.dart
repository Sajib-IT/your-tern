import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_checker/view/tabs/tabs_view.dart';
import 'package:tea_checker/widget/dialog/alert_custom_dialog.dart';

class VerifyEmailController extends GetxController {
  RxBool isLoading = RxBool(false);
  final SupabaseClient supabase = Supabase.instance.client;
  String email = '';
  @override
  void onInit() async{
    if (Get.arguments != null) {
      email = Get.arguments;
    }
    // Future.delayed(Duration(seconds: 2));
    print(email);
   await supabase.auth.signInWithOtp(email: email);
   // await resendVerificationEmail(email);
    super.onInit();
  }

  Future<void> resendVerificationEmail(String email) async {
    print(email);
    try {
      isLoading.value = true;
      await supabase.auth.resend(type: OtpType.signup, email: email);
      isLoading.value = false;
      AlertCustomDialogs().showAlert(
        msg: 'Verification email resent to $email',
      );
    } on AuthException catch (error) {
      isLoading.value = false;

      AlertCustomDialogs().showAlert(msg: error.message);
    } catch (error) {
      isLoading.value = false;
      print(error);
      AlertCustomDialogs().showAlert(
        msg: 'Failed to resend verification email',
      );
    }
  }
}
