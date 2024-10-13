
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/core/functions/handingdatacontroller.dart';
import 'package:user_app/data/datasource/remote/forgetpassword/verifycode.dart';

abstract class VerifyCodeController extends GetxController {
  checkCode();
  goToResetPassword(String verifycode);
}

class VerifyCodeControllerImp extends VerifyCodeController {

  String? email;

  VerifyCodeForgetPasswordData verifyCodeForgetPasswordData =
      VerifyCodeForgetPasswordData(Get.find());

  StatusRequest? statusRequest;

  @override
  checkCode() {}

  @override
  goToResetPassword(String verifycode) async {
    statusRequest = StatusRequest.loading;
    update(); // Met à jour l'état pour afficher le chargement

    var response = await verifyCodeForgetPasswordData.postdata(email!, verifycode);
    statusRequest = handlingData(response); // Gérer la réponse

    if (statusRequest == StatusRequest.success) {
      if (response['message'] == "Vérification réussie") {
        Get.offNamed(AppRoute.resetPassword, arguments: {
          "users_email": email
        });
      } else {
        Get.defaultDialog(
          title: "Avertissement",
          middleText: "Le code de vérification est incorrect",
        );
        statusRequest = StatusRequest.failure;
      }
    } else {
      // Si la réponse n'est pas un succès, afficher un message d'erreur
      Get.defaultDialog(
        title: "Erreur",
        middleText: "Une erreur s'est produite. Veuillez réessayer.",
      );
    }

    update(); // Met à jour l'état après avoir traité la réponse
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
