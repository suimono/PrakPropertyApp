// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/controllers/auth_controller.dart';
import 'package:mobileapp/app/modules/home/bindings/home_binding.dart';
import 'package:mobileapp/app/routes/app_pages.dart';
import 'package:mobileapp/app/services/paket_controller.dart';
import 'package:mobileapp/app/modules/Gallery/controllers/gallery_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Controller global
  Get.put(AuthController(), permanent: true);
  Get.put(PaketController(), permanent: false);
  Get.put(GalleryController(), permanent: false);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proverti App',
      initialBinding: HomeBinding(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}
