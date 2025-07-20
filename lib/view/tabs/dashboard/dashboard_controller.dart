import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxBool isLoading = RxBool(false);
  final supabase = Supabase.instance.client;
  List<String> groupNames = [];
  @override
  void onInit() async {
    // print("groupNmae ${await getGroupsWhereUserHasMinSerial(supabase.auth.currentUser!.id)}");
    await getGroupsWhereUserHasMinSerial(supabase.auth.currentUser!.id);
    print("groupNmae ${groupNames}");
    super.onInit();
  }

  final List<Map<String, String>> carouselItems = [
    {
      "image": "assets/images/first.png",
      "text": "Clean spaces create clear minds. Let's keep it tidy, together!",
    },
    {
      "image": "assets/images/second.png",
      "text": "It’s your turn for tea! A warm cup, a warmer bond",
    },
    {
      "image": "assets/images/third.png",
      "text": "Don’t forget! Clean water starts with shared responsibility",
    },
    {
      "image": "assets/images/fourth.png",
      "text": "Shared spaces, shared duties. Let’s all do our part",
    },
    {
      "image": "assets/images/fifth.png",
      "text":
          "Great roommates don’t just live together — they build routines together!",
    },
  ];

  Future<void> getGroupsWhereUserHasMinSerial(String userId) async {
    isLoading.value = true;
    try {
      // Step 1: Fetch all groups the user is in with their serialNo
      final response = await supabase
          .from('group_members')
          .select('group_id, serialNo, groups(name)')
          .eq('user_id', userId);
      print(response);
      final List data = response;
      // List<String> groupNames = [];

      for (var entry in data) {
        final groupId = entry['group_id'];
        final userSerial = entry['serialNo'];

        // Step 2: Get the minimum serialNo for this group
        final minSerialResponse =
            await supabase
                .from('group_members')
                .select('serialNo')
                .eq('group_id', groupId)
                .order('serialNo', ascending: true)
                .limit(1)
                .single();

        final minSerial = minSerialResponse['serialNo'];

        // Step 3: If current user has the minimum serialNo, include group name
        if (userSerial == minSerial) {
          final groupName = entry['groups']['name'];
          groupNames.add(groupName);
        }
      }

      // return [];
    } catch (e) {
      print('Error fetching groups: $e');
      isLoading.value = false;
      // return groupNames;
    }
    isLoading.value = false;
  }
}
