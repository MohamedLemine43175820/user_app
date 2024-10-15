
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/core/functions/handingdatacontroller.dart';
import 'package:user_app/data/datasource/remote/auth/verfiy_code_signup.dart';

abstract class VerifyCodeSignUpController extends GetxController {
  checkCode();
  goToSuccessSignUp(String verfiyCodeSignUp);
}

class VerifyCodeSignUpControllerImp extends VerifyCodeSignUpController {

  VerfiyCodeSignUpData verfiyCodeSignUpData = VerfiyCodeSignUpData(Get.find());


  String? email;

 // late String verfiycode  ;

  StatusRequest? statusRequest;

  @override
  checkCode() {}

  @override
  goToSuccessSignUp(String verfiyCodeSignUp)  async{
   // Get.offNamed(AppRoute.successSignUp);

    // before go to success signup  verfiy code et email

      statusRequest = StatusRequest.loading;
      update();

      var response = await verfiyCodeSignUpData.postData(email!,verfiyCodeSignUp);
      print("Response before handling: $response");

      statusRequest = handlingData(response);
      print("Status after handling: $statusRequest");

      if (StatusRequest.success == statusRequest) {
        if (response is Map && response['status'] == "success"){
          print("Code vérifié avec succès");
          print("===================================== statusRequest $statusRequest ");

          // Imprimer le statut et le message
          print("Status: ${response['status']}");
          print("Message: ${response['message']}");

          Get.offNamed(AppRoute.successSignUp);
        } else {
          print("Échec de la vérification du code : ${response['message']}");
          Get.defaultDialog(
            title: "Warning",
            middleText: response['message'] ?? "Verify Code Not Correct",
          );
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }

  reSend(){
    verfiyCodeSignUpData.resendData(email!);
  }






  @override
  void onInit() {
    super.onInit(); // Appel de super en premier

    var arguments = Get.arguments;            // Récupérer les arguments
    print(arguments); //                      Vérifie ce que contient Get.arguments

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (arguments != null && arguments['users_email'] != null) {
        email = arguments['users_email'];
      } else {
        // Affiche un message d'erreur si l'argument est manquant
        Get.defaultDialog(
          title: "Error",
          middleText: "Email argument is missing.",
        );
      }
    });
  }

 
}
