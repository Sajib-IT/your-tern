import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;

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
}
