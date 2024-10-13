
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/core/functions/handingdatacontroller.dart';
import 'package:user_app/data/datasource/remote/forgetpassword/resetpassword.dart';

abstract class ResetPasswordController extends GetxController {
  resetpassword();
  goToSuccessResetPassword();
}

class ResetPasswordControllerImp extends ResetPasswordController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  ResetPasswordData resetPasswordData = ResetPasswordData(Get.find());

  StatusRequest? statusRequest;

  late TextEditingController password;
  late TextEditingController repassword;

  String? email;

  @override
  resetpassword() {}

  @override
  goToSuccessResetPassword() async {
    if (password.text != repassword.text) {
      return Get.defaultDialog(
          title: "Avertissement", middleText: "Les mots de passe ne correspondent pas");
    }

    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update(); // Met à jour l'état pour afficher le chargement

      var response = await resetPasswordData.postdata(email!, password.text);
      print("=============================== Controller $response ");

      statusRequest = handlingData(response); // Gérer la réponse

      if (statusRequest == StatusRequest.success) {
        if (response['message'] == "Mot de passe réinitialisé avec succès") {
          Get.offNamed(AppRoute.successResetpassword);
        } else {
          Get.defaultDialog(
              title: "Avertissement", middleText: "Réessayez");
          statusRequest = StatusRequest.failure;
        }
      } else {
        Get.defaultDialog(
          title: "Erreur",
          middleText: "Une erreur s'est produite. Veuillez réessayer.",
        );
      }
      update(); // Met à jour l'état après avoir traité la réponse
    } else {
      print("Non valide");
    }
  }


  @override
  void onInit() {

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
    password = TextEditingController();
    repassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    repassword.dispose();
    super.dispose();
  }
}
