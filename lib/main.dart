
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/bindings/intialbindings.dart';
import 'package:user_app/core/class/crud.dart';
import 'package:user_app/core/localization/translation.dart';
import 'package:user_app/core/services/services.dart';
import 'package:user_app/firebase_options.dart';
import 'package:user_app/routes.dart';
import 'core/localization/changelocal.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  Crud.init();                    // Initialisation de Dio
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return GetMaterialApp(
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: controller.language,
      theme: controller.appTheme,
      initialBinding:InitialBindings() ,
      // routes: routes,
      getPages: routes,
    );
  }
}
