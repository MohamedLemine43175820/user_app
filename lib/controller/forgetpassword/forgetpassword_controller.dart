
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/core/functions/handingdatacontroller.dart';
import 'package:user_app/data/datasource/remote/forgetpassword/checkemail.dart';

abstract class ForgetPasswordController extends GetxController {
  checkemail(); 
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  
  CheckEmailData checkEmailData  = CheckEmailData(Get.find()) ; 

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  
  StatusRequest? statusRequest ; 

  late TextEditingController email;

  @override
  checkemail() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update(); // Mette à jour l'état pour afficher le chargement

      var response = await checkEmailData.postdata(email.text.trim());
      print("=============================== Controller $response ");

      statusRequest = handlingData(response); // Gestion de la réponse

      if (statusRequest == StatusRequest.success) {
        if (response.containsKey('message') && response['message'] == "Code de vérification envoyé à l'email") {
          Get.offNamed(AppRoute.verfiyCode, arguments: {
            "users_email": email.text.trim()
          });
        } else {
          Get.defaultDialog(title: "Avertissement", middleText: "Email non trouvé");
          statusRequest = StatusRequest.failure;
        }
      } else {
        // Si la réponse n'est pas un succès, gérer l'échec
        Get.defaultDialog(title: "Erreur", middleText: "Une erreur s'est produite. Veuillez réessayer.");
      }
      update(); // Mette à jour l'état après avoir traité la réponse
    }
  }


 
  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
