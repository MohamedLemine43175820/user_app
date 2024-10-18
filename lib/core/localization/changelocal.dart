
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:user_app/core/constant/apptheme.dart';
import 'package:user_app/core/services/services.dart';

class LocaleController extends GetxController {
  
  Locale? language;

  MyServices myServices = Get.find();

  ThemeData appTheme = themeEnglish;

  changeLang(String langcode) {
    Locale locale = Locale(langcode);
    myServices.sharedPreferences.setString("lang", langcode);
    appTheme = langcode == "ar" ? themeArabic : themeEnglish;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }



 /* requestPerLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Get.snackbar("تنبيه", "الرجاء تشغيل خدمو تحديد الموقع");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Get.snackbar("تنبيه", "الرجاء اعطاء صلاحية الموقع للتطبيق");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Get.snackbar("تنبيه", "لا يمكن استعمال التطبيق من دون اللوكيشين");
    }
  }*/




  static Future<void> requestPerLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifier si le service de localisation est activé
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Service désactivé, notifier l'utilisateur
       Get.snackbar("تنبيه", "الرجاء تشغيل خدمة تحديد الموقع");
    }

    // Vérifier si les permissions de localisation sont accordées
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Si refusé, demander les permissions
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions encore refusées, notifier l'utilisateur
         Get.snackbar("تنبيه", "الرجاء إعطاء صلاحية الموقع للتطبيق");
      }
    }

    // Si les permissions sont refusées définitivement
    if (permission == LocationPermission.deniedForever) {
      // L'application ne peut pas accéder à la localisation
      Get.snackbar("تنبيه", "لا يمكن استعمال التطبيق من دون اللوكيشن");
    }

    // Si tout est en ordre, on peut obtenir la position ou exécuter d'autres opérations
    Get.snackbar("نجاح", "صلاحيات الموقع مُعطاة، يمكنك الآن استعمال اللوكيشن");
  }


  @override
  void onInit() {

    //requestPerLocation();




    String? sharedPrefLang = myServices.sharedPreferences.getString("lang");
    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
      appTheme = themeArabic;
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
      appTheme = themeEnglish;
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      appTheme = themeEnglish;
    }
    super.onInit();
  }
}
