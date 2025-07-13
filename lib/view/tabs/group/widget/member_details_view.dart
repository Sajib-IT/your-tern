import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:tea_checker/utils/color_utils.dart';

class MemberDetailsView extends StatelessWidget {
  final Map<String, dynamic> user;

  const MemberDetailsView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    String getValue(String key) =>
        (user[key] == null || user[key].toString().isEmpty)
            ? 'N/A'
            : user[key].toString();

    return Scaffold(
      appBar: AppBar(title: Text('Member Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ClipOval(
            //   child: AnyImageView(
            //     imagePath: 'assets/logo/logo.png',
            //     height: 80,
            //     width: 80,
            //     shape: BoxShape.circle,
            //     // onTap: () => _showProfileDetails(),
            //   ),
            // ),

            ClipOval(
              child: SizedBox(
                width: 90,
                height: 90,
                child:
                    user['profileImageUrl'] != null
                        ? FadeInImage.assetNetwork(
                          placeholder:
                              'assets/images/colorful_loader.gif', // add this asset
                          image: user['profileImageUrl'],
                          fit: BoxFit.cover,
                        )
                        : Image.asset(
                          'assets/logo/logo.png',
                          fit: BoxFit.cover,
                        ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              getValue('fullName'),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Card(
              color: ColorUtils.cardSurface,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(16),
                children: [
                  _buildRow("Email", getValue('email')),
                  _buildRow("Mobile", getValue('mobile')),
                  _buildRow("Gender", getValue('gender')),
                  _buildRow("Blood Group", getValue('bloodGroup')),
                  _buildRow("Date of Birth", getValue('dateOfBirth')),
                  _buildRow("Present Address", getValue('presentAddress')),
                  _buildRow(
                    "Permanent Address",
                    getValue('permanentAddress'),
                  ),
                  _buildRow("Height", getValue('height')),
                  _buildRow("Weight", getValue('weight')),
                  _buildRow("Active", getValue('isActive')),
                  _buildRow("Role", getValue('role')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(child: Text(value, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
