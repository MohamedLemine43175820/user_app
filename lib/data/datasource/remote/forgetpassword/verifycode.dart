





import 'package:user_app/core/class/crud.dart';
import 'package:user_app/link_api.dart';

class VerifyCodeForgetPasswordData {
  Crud crud;
  VerifyCodeForgetPasswordData(this.crud);
  postdata(String email ,String verifycode) async {
    var response = await crud.postData(AppLink.forget_password_verfiy_Code, {
      "users_email" :email,
      "verify_code" :verifycode
      //verify_code
    });
    return response.fold((l) => l, (r) => r);
  }
}
