import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_checker/model/user_model.dart';
import 'package:tea_checker/service/auth_service.dart';
import 'package:tea_checker/view/auth/verify_email/verify_email_screen.dart';
import 'package:tea_checker/view/tabs/tabs_view.dart';
import 'package:tea_checker/widget/dialog/alert_custom_dialog.dart';

class SignUpViewController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController feetController = TextEditingController();
  final TextEditingController inchController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController presentAddressController =
      TextEditingController();
  final TextEditingController permanentAddressController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  RxnString selectedGender = RxnString();
  List<String> genderList = ['Male', 'Female', 'Other'];
  RxnString selectedBloodGroup = RxnString();
  List<String> bloodGroupList = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  RxString dob = ''.obs;
  RxInt age = 0.obs;
  RxInt feet = 0.obs;
  RxInt inch = 0.obs;
  RxString height = RxString('');
  RxInt weight = 0.obs;
  RxBool isPasswordHidden = true.obs;
  RxBool isConfirmHidden = true.obs;
  RxBool isFormValid = false.obs;
  RxString phoneError = ''.obs;
  RxString confirmError = ''.obs;
  RxString presentAddress = ''.obs;
  RxString permanentAddress = ''.obs;
  final SupabaseClient supabase = Supabase.instance.client;
  late UserModel userModel;

  @override
  void onInit() {
    super.onInit();
    fullNameController.addListener(validateForm);
    emailController.addListener(validateForm);
    // addressController.addListener(validateForm);
    phoneController.addListener(validateForm);
    passwordController.addListener(validateForm);
    confirmPasswordController.addListener(validateForm);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    // addressController.dispose();
    phoneController.dispose();
    dobController.dispose();
    ageController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  /// 1) Private helper to validate BD number
  bool _isValidBDNumber(String number) {
    final regex = RegExp(r'^01[3-9]\d{8}$');
    return regex.hasMatch(number);
  }

  void onPhoneChanged(String val) {
    if (_isValidBDNumber(val)) {
      phoneError.value = '';
    } else {
      phoneError.value = 'Invalid BD phone number';
    }
    validateForm();
  }

  Future<void> createUser(String uid) async {
    height.value = "${feet.value} feet ${inch.value} inch";
    userModel = UserModel(
      id: uid,
      fullName: fullNameController.text,
      email: emailController.text,
      role: "user",
      gender: selectedGender.value!,
      bloodGroup: selectedBloodGroup.value!,
      height: height.value,
      weight: "${weight.value} kg",
      mobile: phoneController.text,
      dateOfBirth: dob.value,
      age: age.value,
      presentAddress: presentAddressController.text,
      permanentAddress: permanentAddressController.text,
      password: passwordController.text,
      profileImageUrl: null,
    );
    Map<String, dynamic> userModelJson = userModel.toJson();
    try {
      final res = await supabase.from("users").insert(userModelJson);
      print("res $res");
    } catch (e) {
      print(e);
    }

    log(userModel.id);
    log(userModel.fullName);
    // try {
    //   await firestore
    //       .collection('user')
    //       .doc(userModel.userId)
    //       .set(userModelJson);
    // } on FirebaseException catch (e) {
    //   log(e.code);
    //   EasyLoading.dismiss();
    // }
  }

  void signUp() async {
    EasyLoading.show(status: "Loading...");
    AuthResponse authResponse = await supabase.auth.signUp(
      email: emailController.text,
      password: passwordController.text,
      // emailRedirectTo: 'io.supabase.flutter://login-callback/',
      // data: userModel.toJson(),
    );
    print(authResponse.user?.email);
    await createUser(authResponse.user!.id);
    EasyLoading.dismiss();
    print(supabase.auth.currentUser?.emailConfirmedAt);
    if (supabase.auth.currentUser?.emailConfirmedAt == null) {
      Get.off(
        () => VerifyEmailScreen(email: emailController.text),
        arguments: emailController.text.trim(),
      );
    } else {
      Get.off(() => TabsView());
    }

    // try {
    //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //     email: emailController.text,
    //     password: passwordController.text,
    //   );
    //   // sendEmailVerifyLink();
    //   // Get.offAll(()=> AuthView());
    //   await createUser();
    //   Get.offAll(() => TabsView());
    // } on FirebaseAuthException catch (e) {
    //   log(e.code);
    //   if (e.code == 'email-already-in-use') {
    //     AlertCustomDialogs()
    //         .showAlert(msg: "The account already exists .. Please LogIn");
    //   }
    //   if (e.code == 'weak-password') {
    //     AlertCustomDialogs()
    //         .showAlert(msg: "Please Enter Password At Least 6 length");
    //   }
    // }
    // EasyLoading.dismiss();
  }

  bool isValidEmail(String email) {
    final regex = RegExp(r'^it\d{5}@mbstu\.ac\.bd$');
    return regex.hasMatch(email);
  }

  void validateForm() {
    final nameOK = fullNameController.text.trim().isNotEmpty;
    final emailOK = GetUtils.isEmail(emailController.text.trim());
    // final phoneOK = _isValidBDNumber(phoneController.text.trim());
    // final dobOK = dob.isNotEmpty;
    // final addressOk = addressController.text.isNotEmpty;
    final passOK = passwordController.text.length >= 6;
    final confirmOK = confirmPasswordController.text == passwordController.text;

    confirmError.value = confirmOK ? '' : 'Passwords do not match';
    isFormValid.value = nameOK && emailOK && passOK && confirmOK;
  }

  bool validateForm2() {
    if (selectedGender.value != null &&
        selectedBloodGroup.value != null &&
        presentAddress.value.isNotEmpty &&
        permanentAddress.value.isNotEmpty &&
        _isValidBDNumber(phoneController.text.trim())) {
      return true;
    }
    return false;
  }
}
