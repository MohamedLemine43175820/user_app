
import 'package:get/get.dart';
import 'package:user_app/core/services/services.dart';

translateDatabase(columnar, columnen) {
  MyServices myServices = Get.find();

  if (myServices.sharedPreferences.getString("lang") == "ar") {
    return columnar;
  } else {
    return columnen;
  }
}