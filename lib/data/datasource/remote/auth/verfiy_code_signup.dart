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
}
