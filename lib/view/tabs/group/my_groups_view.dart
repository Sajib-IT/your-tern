import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_checker/utils/color_utils.dart';
import 'package:tea_checker/widget/input/my_textfield.dart';

import 'my_group_controller.dart';
import 'group_members_view.dart';

class MyGroupsView extends StatelessWidget {
  final MyGroupController _controller = Get.put(MyGroupController());
  // final UserController userController = Get.put(UserController());

  MyGroupsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: _controller.groups.length,
          itemBuilder: (context, index) {
            print(_controller.groups.length);
            final group = _controller.groups[index];
            return Card(
              margin: EdgeInsets.only(bottom: 16),
              color: ColorUtils.background,
              child: ListTile(
                onTap: () {
                  Get.to(
                    () => GroupMembersView(),
                    arguments: [
                      group['id'],
                      group['name'],
                      group['admin_id'] ==
                          _controller.supabase.auth.currentUser!.id,
                    ],
                  );
                },
                title: Text(group['name'], style: TextStyle(fontSize: 22)),
                subtitle: Text(group['description'] ?? ''),
                trailing:
                    group['admin_id'] ==
                            _controller.supabase.auth.currentUser!.id
                        ? InkWell(
                          child: Icon(Icons.delete, color: Colors.red),
                          onTap: () {
                            _controller.deleteGroup(group['id']);
                          },
                        )
                        : null,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showCreateGroupDialog(context),
      ),
    );
  }

  void showCreateGroupDialog(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: Text('Create New Group'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTextField(
              textEditingController: nameController,
              hintText: "eg. Tea Making Group",
            ),
            SizedBox(height: 8),
            MyTextField(
              textEditingController: descriptionController,
              hintText: "Describe about your group",
            ),
            // TextField(
            //   controller: nameController,
            //   decoration: InputDecoration(labelText: 'Group Name'),
            // ),
            // TextField(
            //   controller: descriptionController,
            //   decoration: InputDecoration(labelText: 'Description (optional)'),
            // ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: 18, color: ColorUtils.primary),
            ),
          ),
          TextButton(
            onPressed: () async {
              await _controller.createGroup(
                nameController.text,
                description: descriptionController.text,
              );
              Get.back();
            },
            child: Text(
              'Create',
              style: TextStyle(fontSize: 18, color: ColorUtils.primary),
            ),
          ),
        ],
      ),
    );
  }
}
