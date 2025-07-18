import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_checker/utils/color_utils.dart';
import 'package:tea_checker/view/tabs/group/group_members_controller.dart';
import 'package:tea_checker/view/tabs/group/widget/member_details_view.dart';
import 'package:tea_checker/widget/dialog/customiseable_base_dialog.dart';

class GroupMembersView extends StatelessWidget {
  final GroupMembersController _controller = Get.put(GroupMembersController());

  GroupMembersView({super.key});

  @override
  Widget build(BuildContext context) {
    print("admin ${_controller.isAdmin}");
    return Scaffold(
      appBar: AppBar(title: Text(_controller.name)),
      floatingActionButton: Obx(
        () =>
            _controller.isAdmin.value && !_controller.isLoading.value
                ? FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () => _showAddMemberDialog(context),
                )
                : SizedBox(),
      ),
      body: Obx(
        () =>
            !_controller.isLoading.value
                ? ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: _controller.groupMembers.length,
                  itemBuilder: (context, index) {
                    final members = _controller.groupMembers;
                    Map<String, dynamic> user = members[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 16),
                      color:
                          index == 0
                              ? Colors.green.shade100
                              : index == 1
                              ? Colors.orange.shade100
                              : Colors.white70,
                      child: ListTile(
                        onTap: () {
                          Get.to(() => MemberDetailsView(user: user));
                        },
                        // enabled: user['isActive'],
                        title: Text(user['fullName'] ?? ''),
                        subtitle: Text(user['email']),
                        trailing:
                            _controller.isAdmin.value
                                ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      visualDensity: VisualDensity.compact,
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed:
                                          () => _controller.removeUserFromGroup(
                                            _controller.groupId,
                                            user['id'],
                                          ),
                                    ),
                                    if (index == 0 || index == 1)
                                      IconButton(
                                        visualDensity: VisualDensity.compact,
                                        icon: Icon(
                                          index == 0
                                              ? Icons.task_alt_rounded
                                              : Icons.next_plan_outlined,
                                          color:
                                              index == 0
                                                  ? Colors.green
                                                  : Colors.orange,
                                        ),
                                        onPressed:
                                            index == 0
                                                ? () => _controller
                                                    .updateUserSerialNoToGroup(
                                                      _controller.groupId,
                                                      user['id'],
                                                    )
                                                : null,
                                      ),
                                  ],
                                )
                                : null,
                      ),
                    );
                  },
                )
                : Center(
                  child: CircularProgressIndicator(color: ColorUtils.primary),
                ),
      ),
      // Column(
      //   children: [
      //     // ListTile(
      //     //   title: Text('Add Members'),
      //     //   trailing: IconButton(
      //     //     icon: Icon(Icons.person_add),
      //     //     onPressed: () => _showAddMemberDialog(context),
      //     //   ),
      //     // ),
      //     //
      //     FutureBuilder<List<Map<String, dynamic>>>(
      //       future: groupController.getGroupMembers(groupId),
      //       builder: (context, snapshot) {
      //         if (snapshot.connectionState == ConnectionState.waiting) {
      //           return Center(child: CircularProgressIndicator());
      //         }
      //         if (snapshot.hasError) {
      //           return Center(child: Text('Error loading members'));
      //         }
      //         final members = snapshot.data ?? [];
      //         return Expanded(
      //           child: ListView.builder(
      //             padding: EdgeInsets.all(16),
      //             itemCount: members.length,
      //             itemBuilder: (context, index) {
      //               final user = members[index]['users'];
      //               return Card(
      //                 margin: EdgeInsets.only(bottom: 16),
      //                 color: Colors.white70,
      //                 child: ListTile(
      //                   title: Text(user['fullName'] ?? user['email']),
      //                   subtitle: Text(user['email']),
      //                   trailing:
      //                   isAdmin
      //                       ? IconButton(
      //                     icon: Icon(Icons.delete, color: Colors.red),
      //                     onPressed:
      //                         () => groupController.removeUserFromGroup(
      //                       groupId,
      //                       user['id'],
      //                     ),
      //                   )
      //                       : null,
      //                 ),
      //               );
      //             },
      //           ),
      //         );
      //       },
      //     ),
      //   ],
      // ),
    );
  }

  void _showAddMemberDialog(BuildContext context) {
    // String? selectedUserId;
    // final searchController = TextEditingController();
    CustomiseAbleBaseDialog()
        .showPopup(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DropdownButtonFormField2<dynamic>(
                isExpanded: true,
                value: _controller.selectedUserId.value,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: kIsWeb ? 16 : 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.deepPurple),
                  ),
                  // Add more decoration..
                ),
                hint: Text(
                  'Select Member',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                items:
                    _controller.allUsers
                        .map(
                          (user) => DropdownMenuItem<dynamic>(
                            value: user['id'],
                            onTap: () {},
                            child: Text(
                              "${user['fullName']}\n ${user['email']}",
                              // maxLines: 1,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  _controller.selectedUserId.value = value;
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 14),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.black45),
                  iconSize: 24,
                ),
                dropdownStyleData: DropdownStyleData(
                  // padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                  // offset: const Offset(10, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 18, color: ColorUtils.primary),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_controller.selectedUserId.value != null) {
                        await _controller.addUserToGroup(
                          _controller.groupId,
                          _controller.selectedUserId.value!,
                        );
                        if(!_controller.isExist.value)
                                Get.back();
                      }
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(fontSize: 18, color: ColorUtils.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
          title: "Add Member",
        )
        .then((value) => _controller.selectedUserId.value = null);
    // Get.dialog(
    //   AlertDialog(
    //     title: Text('Add Member'),
    //     content: Obx(
    //       () => DropdownButtonFormField2<dynamic>(
    //         isExpanded: true,
    //         value: _controller.selectedUserId.value,
    //         decoration: InputDecoration(
    //           contentPadding: const EdgeInsets.symmetric(
    //             vertical: kIsWeb ? 16 : 12,
    //           ),
    //           border: OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(8),
    //             borderSide: const BorderSide(color: Colors.grey),
    //           ),
    //           focusedBorder: OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(8),
    //             borderSide: const BorderSide(color: Colors.deepPurple),
    //           ),
    //           // Add more decoration..
    //         ),
    //         hint: Text(
    //           'Select Member',
    //           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    //         ),
    //         items:
    //             _controller.allUsers
    //                 .map(
    //                   (user) => DropdownMenuItem<dynamic>(
    //                     value: user['id'],
    //                     onTap: () {},
    //                     child: Text(
    //                       "${user['fullName']}\n ${user['email']}",
    //                       // maxLines: 1,
    //                       style: const TextStyle(
    //                         fontSize: 14,
    //                         fontWeight: FontWeight.w400,
    //                       ),
    //                     ),
    //                   ),
    //                 )
    //                 .toList(),
    //         onChanged: (value) {
    //           _controller.selectedUserId.value = value;
    //         },
    //         buttonStyleData: const ButtonStyleData(
    //           padding: EdgeInsets.only(right: 14),
    //         ),
    //         iconStyleData: const IconStyleData(
    //           icon: Icon(Icons.keyboard_arrow_down, color: Colors.black45),
    //           iconSize: 24,
    //         ),
    //         dropdownStyleData: DropdownStyleData(
    //           // padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
    //           // offset: const Offset(10, 10),
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(8),
    //             border: Border.all(color: Colors.grey),
    //           ),
    //         ),
    //         menuItemStyleData: const MenuItemStyleData(
    //           padding: EdgeInsets.symmetric(horizontal: 16),
    //         ),
    //       ),
    //
    //       //     DropdownButton<String>(
    //       //   hint: Text('Select User'),
    //       //   value: selectedUserId,
    //       //   items:
    //       //       userController.allUsers
    //       //           .where(
    //       //             (user) =>
    //       //                 user['id'] != userController.currentUser.value?['id'],
    //       //           )
    //       //           .map(
    //       //             (user) => DropdownMenuItem<String>(
    //       //               value: user['id'],
    //       //               child: Text(user['email']),
    //       //             ),
    //       //           )
    //       //           .toList(),
    //       //   onChanged: (value) => selectedUserId = value,
    //       // ),
    //     ),
    //     actions: [
    //       TextButton(
    //         onPressed: () => Get.back(),
    //         child: Text(
    //           'Cancel',
    //           style: TextStyle(fontSize: 18, color: ColorUtils.primary),
    //         ),
    //       ),
    //       TextButton(
    //         onPressed: () async {
    //           if (_controller.selectedUserId.value != null) {
    //             await groupController.addUserToGroup(
    //               _controller.groupId,
    //               _controller.selectedUserId.value!,
    //             );
    //             Get.back();
    //           }
    //         },
    //         child: Text(
    //           'Add',
    //           style: TextStyle(fontSize: 18, color: ColorUtils.primary),
    //         ),
    //       ),
    //     ],
    //     // actions: [
    //     //   TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
    //     //   TextButton(
    //     //     onPressed: () async {
    //     //       if (selectedUserId != null) {
    //     //         await groupController.addUserToGroup(
    //     //           _controller.groupId,
    //     //           selectedUserId!,
    //     //         );
    //     //         Get.back();
    //     //       }
    //     //     },
    //     //     child: Text('Add'),
    //     //   ),
    //     // ],
    //   ),
    // );
  }
}
