import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyGroupController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  final groups = <Map<String, dynamic>>[].obs;

  @override
  void onInit() async {
    await fetchGroups();
    // await fetchUserGroups();
    super.onInit();
  }

  Future<void> fetchGroups() async {
    // final response = await supabase.from('groups').select();
    final response = await supabase
        .from('group_members')
        .select('''
            groups:group_id (*)  // Join with groups table and get 'name'
          ''')
        .eq('user_id', supabase.auth.currentUser!.id);
    groups.value =
        response.map((item) => item['groups'] as Map<String, dynamic>).toList();
    print("groups $groups");
    // groups.value = List<Map<String, dynamic>>.from(response);
  }

  Future<void> deleteGroup(String groupId) async {
    // Delete the group (cascade will handle group_members entries)
    await supabase.from('groups').delete().eq('id', groupId);

    // Update local state
    groups.removeWhere((group) => group['id'] == groupId);
    // userGroups.removeWhere((group) => group['groups']['id'] == groupId);
  }

  Future<void> createGroup(String name, {String? description}) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    String adminId = supabase.auth.currentUser!.id;
    await supabase.from('groups').insert({
      'id': id,
      'admin_id': adminId,
      'name': name,
      'description': description,
    });
    await addUserToGroup(id, adminId);
    await fetchGroups();
    // await fetchUserGroups();
  }

  Future<void> addUserToGroup(String groupId, String userId) async {
    await supabase.from('group_members').insert({
      'group_id': groupId,
      'user_id': userId,
      'serialNo': 1,
    });
    // await fetchUserGroups();
  }

  // Future<List<Map<String, dynamic>>> getGroupMembers(String groupId) async {
  //   final response = await supabase
  //       .from('group_members')
  //       .select('users(*)')
  //       .eq('group_id', groupId)
  //       .order("serialNo", ascending: true);
  //   return List<Map<String, dynamic>>.from(response);
  // }
}
