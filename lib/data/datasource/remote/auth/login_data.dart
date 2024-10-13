import 'package:user_app/core/class/crud.dart';
import 'package:user_app/link_api.dart';
import 'package:dartz/dartz.dart';               // Assurez-vous d'importer dartz pour Either
import 'package:user_app/core/class/status_request.dart';  // Assurez-vous d'importer StatusRequest

class LoginData {
  final Crud crud;

  LoginData(this.crud);

  postData(String email,
       String password, ) async {
    var response = await crud.postData(AppLink.login, {
      "users_email": email,
      "users_password": password,


    });

    return response.fold((l) => l, (r) => r);
  }
}
