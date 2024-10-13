
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/core/functions/handingdatacontroller.dart';
import 'package:user_app/data/datasource/remote/auth/signup_data.dart';

abstract class SignUpController extends GetxController {
  signUp();
  goToSignIn();
}

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;

   StatusRequest? statusRequest;

  SignupData signupData = SignupData(Get.find());        // Instance de SignupData


  List data =[];


  @override
  signUp()  async {
    if (formstate.currentState!.validate()) {

     // Get.offNamed(AppRoute.verfiyCodeSignUp);    // backend

      statusRequest = StatusRequest.loading;
      update(); // Mettre à jour l'interface utilisateur

      var response = await signupData.postData(
        username.text,
        password.text,
        email.text.trim(),
        phone.text,
      );

      print("=============================== Controller $response ");

      // Gérer la réponse
      statusRequest = handlingData(response);

      print("=============================== status request $statusRequest ");
      if (statusRequest == StatusRequest.success) {



        // Assurez-vous que la réponse est bien structurée


        if (response['status'] == "success") {
         // data.addAll(response['data']);
          String status = response['status'];
          String message = response['message'];

          // Afficher les résultats
          print('Status: $status');
          print('Message: $message');


          // Rediriger vers la page de vérification

          Get.offNamed(AppRoute.verfiyCodeSignUp ,
              arguments: {

            'users_email': email.text.trim()        // send email to page verfiycode


          }

          );

        } else {
          // Afficher un message d'erreur si le numéro de téléphone ou l'email existe déjà
          Get.defaultDialog(
            title: "Warning",
            middleText: "Phone Number or Email Already Exists",
          );
          statusRequest = StatusRequest.failure;
        }
      } else {
        // Gérer les autres statuts (échec de la requête, etc.)
        Get.defaultDialog(
          title: "Error",
          middleText: "An error occurred while signing up. Please try again.",
        );
      }
      update(); // Mettre à jour l'interface utilisateur
    } else {
      // Afficher un message d'erreur si le formulaire n'est pas valide
      Get.defaultDialog(
        title: "Validation Error",
        middleText: "Please check your input and try again.",
      );
    }
  }


  @override
  goToSignIn() {
    Get.offNamed(AppRoute.login);
  }

  @override
  void onInit() {
    username = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }
}
