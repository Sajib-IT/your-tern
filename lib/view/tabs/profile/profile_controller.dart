import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_checker/model/user_model.dart';
import 'package:tea_checker/widget/dialog/alert_custom_dialog.dart';

class ProfileController extends GetxController {
  // Rxn<user> user = Rxn<user>();
  // final uid = FirebaseAuth.instance.currentUser?.uid;
  final Rx<Map<String, dynamic>?> user = Rx<Map<String, dynamic>?>(null);
  SupabaseClient supabase = Supabase.instance.client;

  RxBool isLoading = RxBool(false);
  Rxn<File> documentToUpload = Rxn<File>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
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

  RxnString selectedGender = RxnString();
  RxString selectedActive = RxString('Yes');
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
  RxString presentAddress = ''.obs;
  RxString permanentAddress = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    try {
      isLoading.value = true;

      // Get the current auth user
      final authUser = supabase.auth.currentUser;
      if (authUser == null) {
        throw Exception('No authenticated user');
      }

      // Fetch user data from 'users' table
      final response =
          await supabase.from('users').select().eq('id', authUser.id).single();

      user.value = response;
      print("current ${user.value}");
    } catch (e) {
      print(e);
      user.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUserData() async {
    // isLoading.value = true;
    // final doc =
    //     await FirebaseFirestore.instance.collection('user').doc(uid).get();
    // user.value = user.fromJson(doc.data()!);
    // isLoading.value = false;
  }

  Future<void> initializeDataForEdit() async {
    EasyLoading.show(status: "Loading...");
    final height = user.value!['height'].split(' ');
    print(height);
    final splitWeight = user.value!['weight']!.split(' ');

    fullNameController.text = user.value!['fullName'];
    phoneController.text = user.value!['mobile'];
    dob.value = user.value!['dateOfBirth'];
    ageController.text = user.value!['age'].toString();
    age.value = user.value!['age'];
    selectedGender.value = user.value!['gender'];
    selectedBloodGroup.value = user.value!['bloodGroup'];
    feetController.text = height[0];
    feet.value = int.parse(height[0]);
    inchController.text = height[2];
    inch.value = int.parse(height[2]);
    weightController.text = splitWeight[0];
    weight.value = int.parse(splitWeight[0]);
    presentAddressController.text = user.value!['presentAddress'];
    permanentAddressController.text = user.value!['permanentAddress'];
    EasyLoading.dismiss();
  }

  Future<void> updateUserData() async {
    EasyLoading.show(status: "Loading...");
    final authUser = supabase.auth.currentUser;
    await supabase
        .from('users')
        .update({
          'fullName': fullNameController.text,
          'mobile': phoneController.text,
          'dateOfBirth': dob.value,
          'age': age.value,
          'isActive': selectedActive.value == "Yes" ? true : false,
          'gender': selectedGender.value,
          'bloodGroup': selectedBloodGroup.value,
          'presentAddress': presentAddressController.text,
          'permanentAddress': permanentAddressController.text,
        })
        .eq('id', authUser!.id);

    // height.value = "${feet.value} feet ${inch.value} inch";
    // log(user.value!.userId);
    // await FirebaseFirestore.instance.collection('user').doc(uid).update({
    //   "fullName": fullNameController.text,
    //   "gender": selectedGender.value,
    //   "mobile": phoneController.text,
    //   "dateOfBirth": dob.value,
    //   "age": age.value,
    //   // "profileImageUrl": documentToUpload.value != null
    //   //     ? await uploadProfileImage(documentToUpload.value!)
    //   //     : null,
    //   "height": height.value,
    //   "weight": "${weight.value} kg",
    //   "presentAddress": presentAddressController.text,
    //   "permanentAddress": permanentAddressController.text,
    //   "bloodGroup": selectedBloodGroup.value,
    // });
    EasyLoading.dismiss();
  }

  Future<void> saveProfileImageToFireStore() async {
    // EasyLoading.show(status: "Loading...");
    // String profileUrl = await uploadProfileImage(documentToUpload.value!);
    // user.value!.profileImageUrl = profileUrl;
    // await FirebaseFirestore.instance.collection('user').doc(uid).update({
    //   "profileImageUrl": documentToUpload.value != null ? profileUrl : null,
    // });
    // EasyLoading.dismiss();
  }

  Future<String> uploadProfileImage(File imageFile) async {
    // String path = imageFile.path.split('/').last;
    // if (kDebugMode) {
    //   print("dj path $path");
    // }
    // final storageRef =
    //     FirebaseStorage.instance.ref().child('profileImage/$path');
    // await storageRef.putFile(imageFile);
    // final downloadURL = await storageRef.getDownloadURL();
    // return downloadURL;
    return '';
  }

  bool checkForm() {
    if (fullNameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        selectedGender.value == null ||
        selectedBloodGroup.value == null ||
        dob.value.isEmpty ||
        // feetController.text.isEmpty ||
        // inchController.text.isEmpty ||
        // weightController.text.isEmpty ||
        presentAddressController.text.isEmpty ||
        permanentAddressController.text.isEmpty) {
      AlertCustomDialogs().showAlert(msg: "Please fill up required field");
      return false;
    }
    print(presentAddressController.text);
    print(permanentAddressController.text);
    return true;
  }
}
