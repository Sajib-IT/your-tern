import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_checker/utils/color_utils.dart';
import 'package:tea_checker/view/tabs/tabs_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env["PROJECT_URL"]!,
    anonKey: dotenv.env["API_KEY"]!,
  );
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 3)
    ..loadingStyle = EasyLoadingStyle.custom
    ..textColor = Colors.black
    //..textStyle = TextStyle(fontFamily: "Fieldwork", fontSize: 17)
    ..backgroundColor = Colors.white
    ..indicatorColor = ColorUtils.primary
    ..maskColor = Colors.transparent
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..indicatorSize = 30
    ..maskType = EasyLoadingMaskType.clear
    ..userInteractions = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabsView(),

      builder: EasyLoading.init(),
    );
  }
}
