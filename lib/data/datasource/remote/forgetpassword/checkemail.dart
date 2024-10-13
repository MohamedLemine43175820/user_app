





import 'package:user_app/core/class/crud.dart';
import 'package:user_app/link_api.dart';

class CheckEmailData {
  Crud crud;
  CheckEmailData(this.crud);
  postdata(String email) async {
    var response = await crud.postData(AppLink.checkEmail, {
      "users_email" : email
    });
    return response.fold((l) => l, (r) => r);
  }
}
