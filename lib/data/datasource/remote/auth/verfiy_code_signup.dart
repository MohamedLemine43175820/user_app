import 'package:user_app/core/class/crud.dart';
import 'package:user_app/link_api.dart';
import 'package:dartz/dartz.dart';               // Assurez-vous d'importer dartz pour Either
import 'package:user_app/core/class/status_request.dart';  // Assurez-vous d'importer StatusRequest

class VerfiyCodeSignUpData {
  final Crud crud;

  VerfiyCodeSignUpData(this.crud);

  postData(
      String email, String verifycode ) async {

    var response = await crud.postData(AppLink.verfiyCodeSignUp , {

      "users_email": email,
      "verify_code" :verifycode,

    });

    return response.fold((l) => l, (r) => r);
  }

  // Fonction pour renvoyer le code de vérification par email
  Future<Either<StatusRequest, Map>> resendData(String email) async {
    try {
      var response = await crud.postData(AppLink.resendVerfiyCode, {
        "users_email": email,  // Envoyer l'email en tant que paramètre dans le body de la requête
      });

      return response.fold((l) => Left(l), (r) => Right(r));
    } catch (e) {
      // Gestion des erreurs éventuelles
      print("Erreur lors de l'envoi du code de vérification : $e");
      return Left(StatusRequest.offlinefailure);
    }
  }


}
