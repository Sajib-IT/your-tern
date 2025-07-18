import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_checker/utils/color_utils.dart';
import 'package:tea_checker/view/tabs/profile/edit/edit_profile_view.dart';
import 'package:tea_checker/view/tabs/profile/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final String roll;
  ProfileView({super.key, required this.roll});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () =>
            controller.isLoading.value || controller.user.value == null
                ? Center(
                  child: CircularProgressIndicator(color: ColorUtils.primary),
                )
                : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            controller.initializeDataForEdit().then(
                              (v) => Get.to(() => EditProfileView())?.then((
                                value,
                              ) {
                                if (value && value != null) {
                                  controller.fetchCurrentUser();
                                }
                              }),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorUtils.primary,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.black87,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipOval(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child:
                                  controller.user.value!['profileImageUrl'] !=
                                          null
                                      ? FadeInImage.assetNetwork(
                                        placeholder:
                                            'assets/images/colorful_loader.gif', // add this asset
                                        image:
                                            controller
                                                .user
                                                .value!['profileImageUrl']!,
                                        fit: BoxFit.cover,
                                      )
                                      : Image.asset(
                                        'assets/logo/logo.png',
                                        fit: BoxFit.cover,
                                      ),
                            ),
                          ),
                        ],
                      ),
                      // CircleAvatar(
                      //   radius: 50,
                      //   backgroundImage:
                      //       controller.userModel.value!.profileImageUrl != null
                      //           ? NetworkImage(
                      //               controller.userModel.value!.profileImageUrl!)
                      //           : const AssetImage(AssetsPath.avatar),
                      // ),
                      const SizedBox(height: 12),
                      Text(
                        controller.user.value?["fullName"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        controller.user.value!["email"],
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          children: [
                            buildRow(
                              "Gender",
                              controller.user.value!["gender"],
                            ),
                            const SizedBox(height: 12),
                            buildRow(
                              "Mobile",
                              controller.user.value!['mobile'],
                            ),
                            const SizedBox(height: 12),
                            buildRow(
                              "Date of Birth",
                              controller.user.value!['dateOfBirth'],
                            ),
                            const SizedBox(height: 12),
                            buildRow("Age", "${controller.user.value!['age']}"),
                            const SizedBox(height: 12),
                            buildRow("Active", controller.user.value!['isActive'] ? 'Yes' : 'No'),
                            // buildRow(
                            //   "Height",
                            //   controller.user.value!['height'] ?? "Not set",
                            // ),
                            // const SizedBox(height: 12),
                            // buildRow(
                            //   "Weight",
                            //   controller.user.value!['weight'] ?? "Not set",
                            // ),
                            const SizedBox(height: 12),
                            buildRow(
                              "Blood Group",
                              controller.user.value!['bloodGroup'] ?? "Not set",
                            ),
                            const SizedBox(height: 12),
                            buildRow(
                              "Present Address",
                              controller.user.value!['presentAddress'] ??
                                  "Not set",
                            ),
                            const SizedBox(height: 12),
                            buildRow(
                              "Permanent Address",
                              controller.user.value!['permanentAddress'] ??
                                  "Not set",
                            ),
                            if (roll == "doctor") const SizedBox(height: 12),
                            if (roll == "doctor")
                              buildRow(
                                "Experience",
                                "${controller.user.value!['yearOfExperience'] ?? 0} yrs",
                              ),
                            if (roll == "doctor") const SizedBox(height: 12),
                            if (roll == "doctor")
                              buildRow(
                                "Patients Checked",
                                "${controller.user.value!['patientCheck'] ?? 0}",
                              ),
                            if (roll == "doctor") const SizedBox(height: 12),
                            if (roll == "doctor")
                              buildRow(
                                "Biography",
                                controller.user.value!['biography'] ?? "N/A",
                                2,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }

  Widget buildRow(String title, String value, [int flex = 1]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            "$title:",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        Flexible(
          flex: flex,
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
