
import 'package:get/get.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/core/services/services.dart';

class SettingsController extends GetxController {
  MyServices myServices = Get.find();

  logout() {
    myServices.sharedPreferences.clear();
    Get.offAllNamed(AppRoute.login) ;
  }
}