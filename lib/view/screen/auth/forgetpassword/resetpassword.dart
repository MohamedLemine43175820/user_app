

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/forgetpassword/resetpassword_controller.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/constant/color.dart';
import 'package:user_app/core/functions/validinput.dart';
import 'package:user_app/view/widget/auth/custombuttonauth.dart';
import 'package:user_app/view/widget/auth/customtextbodyauth.dart';
import 'package:user_app/view/widget/auth/customtextformauth.dart';
import 'package:user_app/view/widget/auth/customtexttitleauth.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundcolor,
        elevation: 0.0,
        title: Text('ResetPassword',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColor.grey)),
      ),
      body: GetBuilder<ResetPasswordControllerImp>(
          builder: (controller) => Container(
            padding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Form(
              key: controller.formstate,
              child: ListView(children: [
                const SizedBox(height: 20),
                CustomTextTitleAuth(text: "35".tr),
                const SizedBox(height: 10),
                CustomTextBodyAuth(text: "35".tr),
                const SizedBox(height: 15),
                CustomTextFormAuth(
                  isNumber: false,
                  valid: (val) {
                    return validInput(val!, 3, 40, "password");
                  },
                  mycontroller: controller.password,
                  hinttext: "13".tr,
                  iconData: Icons.lock_outline,
                  labeltext: "19".tr,
                  // mycontroller: ,
                ),
                CustomTextFormAuth(
                  isNumber: false,

                  valid: (val) {
                    return validInput(val!, 3, 40, "password");
                  },
                  mycontroller: controller.repassword,
                  hinttext: "Re" + " " + "13".tr,
                  iconData: Icons.lock_outline,
                  labeltext: "19".tr,
                  // mycontroller: ,
                ),
                controller.statusRequest ==
                    StatusRequest.loading
                    ? const Center(child: CircularProgressIndicator())
                    :
                CustomButtomAuth(
                    text: "33".tr,
                    onPressed: () {
                      controller.goToSuccessResetPassword();
                    }),
                const SizedBox(height: 40),
              ]),
            ),
          )),
    );
  }
}