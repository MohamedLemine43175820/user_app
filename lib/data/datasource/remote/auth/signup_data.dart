import 'package:user_app/core/class/crud.dart';
import 'package:user_app/link_api.dart';
import 'package:dartz/dartz.dart';               // Assurez-vous d'importer dartz pour Either
import 'package:user_app/core/class/status_request.dart';  // Assurez-vous d'importer StatusRequest

class SignupData {
  final Crud crud;

  SignupData(this.crud);

  postData(
      String username, String password, String email, String phone) async {
    var response = await crud.postData(AppLink.signUp, {
      "users_name": username,
      "users_password": password,
      "users_email": email,
      "users_phone": phone,
    });

    return response.fold((l) => l, (r) => r);
  }
}
