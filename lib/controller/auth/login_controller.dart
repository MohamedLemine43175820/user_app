
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/core/functions/handingdatacontroller.dart';
import 'package:user_app/core/services/services.dart';
import 'package:user_app/data/datasource/remote/auth/login_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {

  LoginData loginData  = LoginData(Get.find()) ;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;

  bool isshowpassword = true;

  MyServices myServices = Get.find();

  StatusRequest? statusRequest ;

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  @override
  login() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update() ;
      var response = await loginData.postData(email.text.trim() , password.text);
      print("=============================== Controller $response ");

      statusRequest = handlingData(response);
      print("=============================== status request $statusRequest ");

      if (statusRequest == StatusRequest.success) {

        if (response is Map && response['message'] == "Connexion réussie") {

          // Stockage des données utilisateur dans SharedPreferences

          myServices.sharedPreferences.setString("_id", response['user']['_id']); // L'ID utilisateur
          myServices.sharedPreferences.setString("username", response['user']['users_name']); // Le nom d'utilisateur
          myServices.sharedPreferences.setString("email", response['user']['users_email']); // L'email de l'utilisateur
          myServices.sharedPreferences.setString("phone", response['user']['users_phone']); // Le numéro de téléphone
          myServices.sharedPreferences.setString("step", "2"); // Étape de progression
          Get.offNamed(AppRoute.homepage);
        } else {
          Get.defaultDialog(title: "ُWarning" , middleText: "Email Or Password Not Correct");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {

    }
  }

  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }

  @override
  void onInit() {

    FirebaseMessaging.instance.getToken().then((value) {
      print('===================================== token: $value');
      String? token = value;
    });
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }
}