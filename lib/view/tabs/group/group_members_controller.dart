import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_checker/widget/dialog/alert_custom_dialog.dart';

class GroupMembersController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> groupMembers = <Map<String, dynamic>>[].obs;
  String groupId = '';
  String name = '';
  RxnString selectedUserId = RxnString();
  RxBool isLoading = RxBool(false);
  RxBool isAdmin = RxBool(false);
  RxBool isExist = RxBool(false);
  final allUsers = <Map<String, dynamic>>[].obs;
  final userGroups = <Map<String, dynamic>>[].obs;
  final groups = <Map<String, dynamic>>[].obs;

  @override
  void onInit() async {
    isLoading.value = true;
    if (Get.arguments != null) {
      groupId = Get.arguments[0];
      name = Get.arguments[1];
      isAdmin.value = Get.arguments[2];
    }
    await getGroupMembers(groupId);
    fetchAllUsers();
    super.onInit();
  }

  Future<void> fetchAllUsers() async {
    final response = await supabase.from('users').select();
    allUsers.value = List<Map<String, dynamic>>.from(response);
  }

  // Future<void> fetchUserGroups() async {
  //   final userId = supabase.auth.currentUser?.id;
  //   if (userId != null) {
  //     final response = await supabase
  //         .from('group_members')
  //         .select('groups(*)')
  //         .eq('user_id', userId);
  //     userGroups.value = List<Map<String, dynamic>>.from(response);
  //     print("groups ${response}");
  //   }
  // }

  Future<void> addUserToGroup(String groupId, String userId) async {
    try {
      isExist.value = false;
      await supabase.from('group_members').insert({
        'group_id': groupId,
        'user_id': userId,
        'serialNo': await getMaxSerialNo(groupId) + 1,
      });

      await getGroupMembers(groupId);
    } on PostgrestException catch (e) {
      print("nooo ${e.code}");
      if(e.code == "23505"){
        isExist.value = true;
        AlertCustomDialogs().showAlert(msg: "The member already exists in the group.");
      }

    }
  }


  // Future<void> addUserToGroup(String groupId, String userId) async {
  //   await supabase.from('group_members').insert({
  //     'group_id': groupId,
  //     'user_id': userId,
  //     'serialNo': await getMaxSerialNo(groupId) + 1,
  //   });
  //   await getGroupMembers(groupId);
  // }

  Future<void> updateUserSerialNoToGroup(String groupId, String userId) async {
    isLoading.value = true;
    final response = await supabase
        .from('group_members')
        .update({
          'serialNo':
              await getMaxSerialNo(groupId) + await getCurrentSerialNo(groupId),
        })
        .eq('group_id', groupId)
        .eq('user_id', userId);
    await getGroupMembers(groupId);
  }

  // Future<void> createGroup(String name, {String? description}) async {
  //   String id = DateTime.now().millisecondsSinceEpoch.toString();
  //   String adminId = supabase.auth.currentUser!.id;
  //   await supabase.from('groups').insert({
  //     'id': id,
  //     'admin_id': adminId,
  //     'name': name,
  //     'description': description,
  //   });
  //   await addUserToGroup(id, adminId);
  //   await fetchGroups();
  //   await fetchUserGroups();
  // }

  Future<void> removeUserFromGroup(String groupId, String userId) async {
    await supabase
        .from('group_members')
        .delete()
        .eq('group_id', groupId)
        .eq('user_id', userId);
    await getGroupMembers(groupId);
  }

  Future<void> getGroupMembers(String groupId) async {
    // print(await getMaxSerialNo(groupId));
    // print(await getTotalCount(groupId));
    // print(await getMinSerialNo(groupId));
    // print(await getCurrentSerialNo(groupId));
    isLoading.value = true;
    final response = await supabase
        .from('group_members')
        .select('users(*)')
        .eq('group_id', groupId)
        .order("serialNo", ascending: true);
    groupMembers =
        response
            .map<Map<String, dynamic>>(
              (e) => e['users'] as Map<String, dynamic>,
            )
            .toList();

    // groupMembers.value = List<Map<String, dynamic>>.from(response);
    print("$groupMembers");
    isLoading.value = false;
  }

  // (Optional) Get total count efficiently (without loading all records)
  Future<int> getTotalCount(String groupId) async {
    final response =
        await supabase
            .from('group_members')
            .select('*')
            .eq('group_id', groupId)
            .count();

    return response.count ?? 0;
  }

  // (Optional) Get max serialNo efficiently (single query)
  Future<int> getMaxSerialNo(String groupId) async {
    final response =
        await supabase
            .from('group_members')
            .select('serialNo')
            .eq('group_id', groupId)
            .order('serialNo', ascending: false)
            .limit(1)
            .single();

    return response['serialNo'] ?? 0;
  }

  // (Optional) Get min serialNo efficiently (single query)
  Future<int> getMinSerialNo(String groupId) async {
    final response =
        await supabase
            .from('group_members')
            .select('serialNo')
            .eq('group_id', groupId)
            .order('serialNo', ascending: true)
            .limit(1)
            .single();

    return response['serialNo'] ?? 0;
  }

  // (Optional) Get current user serialNo efficiently (single query)
  Future<int> getCurrentSerialNo(String groupId) async {
    final response =
        await supabase
            .from('group_members')
            .select('serialNo')
            .eq('group_id', groupId)
            .eq('user_id', supabase.auth.currentUser!.id)
            .order('serialNo', ascending: true)
            .limit(1)
            .single();

    return response['serialNo'] ?? 0;
  }
}
