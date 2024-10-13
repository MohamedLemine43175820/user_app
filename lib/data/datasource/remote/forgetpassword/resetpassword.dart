





import 'package:user_app/core/class/crud.dart';
import 'package:user_app/link_api.dart';

class ResetPasswordData {
  Crud crud;
  ResetPasswordData(this.crud);
  postdata(String email ,String password) async {
    var response = await crud.postData(AppLink.resetPassword , {
      "users_email" : email ,
      "newPassword" : password
    });
    return response.fold((l) => l, (r) => r);
  }
}
