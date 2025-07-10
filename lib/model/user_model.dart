import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String userId;
  final String role;              // super_admin, admin, doctor, patient
  final String fullName;
  final String email;
  final String gender;
  final String mobile;
  final String dateOfBirth;
  final int age;
  final String password;
   String? profileImageUrl;
  final int? yearOfExperience;     // For doctors
  final String? biography;         // About the user
  final int? patientCheck;         // Count of patients
  final String? height;            // e.g., "5'6" or "168 cm"
  final String? weight;            // e.g., "60 kg"
  final String? presentAddress;    // Current location
  final String? permanentAddress;  // Permanent residence
  final String? bloodGroup;        // e.g., "A+", "O-", etc.
  final bool isActive;        // e.g., "A+", "O-", etc.

  UserModel({
    required this.userId,
    required this.role,
    required this.fullName,
    required this.email,
    required this.gender,
    required this.mobile,
    required this.dateOfBirth,
    required this.age,
    required this.password,
    this.profileImageUrl,
    this.yearOfExperience,
    this.biography,
    this.patientCheck,
    this.height,
    this.weight,
    this.presentAddress,
    this.permanentAddress,
    this.bloodGroup,
    this.isActive = false
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json["userId"],
    role: json["role"],
    fullName: json["fullName"],
    email: json["email"],
    gender: json["gender"],
    mobile: json["mobile"],
    dateOfBirth: json["dateOfBirth"],
    age: json["age"],
    password: json["password"],
    profileImageUrl: json["profileImageUrl"],
    yearOfExperience: json["yearOfExperience"],
    biography: json["biography"],
    patientCheck: json["patientCheck"],
    height: json["height"],
    weight: json["weight"],
    presentAddress: json["presentAddress"],
    permanentAddress: json["permanentAddress"],
    bloodGroup: json["bloodGroup"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "role": role,
    "fullName": fullName,
    "email": email,
    "gender": gender,
    "mobile": mobile,
    "dateOfBirth": dateOfBirth,
    "age": age,
    "password": password,
    "profileImageUrl": profileImageUrl,
    "yearOfExperience": yearOfExperience,
    "biography": biography,
    "patientCheck": patientCheck,
    "height": height,
    "weight": weight,
    "presentAddress": presentAddress,
    "permanentAddress": permanentAddress,
    "bloodGroup": bloodGroup,
    "isActive": isActive,
  };
}
