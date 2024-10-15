
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
    // Vérification que le formulaire est valide
    if (formstate.currentState!.validate()) {
      // Mise à jour du statut à "loading"
      statusRequest = StatusRequest.loading;
      update();

      // Vérification si les champs email et password sont remplis
      String emailInput = email.text.trim();
      String passwordInput = password.text;

      if (emailInput.isEmpty || passwordInput.isEmpty) {
        Get.defaultDialog(title: "Erreur", middleText: "L'email et le mot de passe ne doivent pas être vides.");
        statusRequest = StatusRequest.failure;
        update();
        return;
      }

      // Envoi de la requête de connexion
      var response = await loginData.postData(emailInput, passwordInput);
      print("=============================== Controller $response ");

      // Gestion de la réponse
      statusRequest = handlingData(response);
      print("=============================== status request $statusRequest ");

      // Si la requête est un succès
      if (statusRequest == StatusRequest.success) {
        if (response is Map && response['message'] == "Connexion réussie") {
          var user = response['user'];

          // Vérifier l'approbation de l'utilisateur
          if (user != null && user['users_approve'] != null) {
            if (user['users_approve'] == 1) {
              // Utilisateur approuvé, stockage des données utilisateur dans SharedPreferences
              myServices.sharedPreferences.setString("_id", user['_id']); // L'ID utilisateur
              myServices.sharedPreferences.setString("username", user['users_name']); // Le nom d'utilisateur
              myServices.sharedPreferences.setString("email", user['users_email']); // L'email de l'utilisateur
              myServices.sharedPreferences.setString("phone", user['users_phone']); // Le numéro de téléphone
              myServices.sharedPreferences.setString("step", "2");

              // Redirection vers la page d'accueil
              Get.offNamed(AppRoute.homepage);
            } else {
              // Si l'utilisateur n'est pas approuvé, rediriger vers la page de vérification du code
              Get.toNamed(AppRoute.verfiyCodeSignUp, arguments: {
                'users_email': emailInput
              });
            }
          } else {
            // Si la réponse ne contient pas d'utilisateur ou d'approbation, afficher une erreur
            Get.defaultDialog(title: "Erreur", middleText: "Erreur de connexion. Veuillez réessayer.");
            statusRequest = StatusRequest.failure;
          }
        } else {
          // Si l'email ou le mot de passe est incorrect
          Get.defaultDialog(title: "Avertissement", middleText: "Email ou mot de passe incorrect.");
          statusRequest = StatusRequest.failure;
        }
      }

      update();
    } else {
      // Gestion du cas où le formulaire n'est pas valide
      Get.defaultDialog(title: "Erreur", middleText: "Veuillez remplir correctement les champs.");
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