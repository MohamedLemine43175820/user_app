
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/forgetpassword/forgetpassword_controller.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/constant/color.dart';
import 'package:user_app/view/widget/auth/custombuttonauth.dart';
import 'package:user_app/view/widget/auth/customtextbodyauth.dart';
import 'package:user_app/view/widget/auth/customtextformauth.dart';
import 'package:user_app/view/widget/auth/customtexttitleauth.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundcolor,
        elevation: 0.0,
        title: Text('14'.tr,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColor.grey)),
      ),
      body: GetBuilder<ForgetPasswordControllerImp>(
          builder: (controller) => Container(
            padding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Form(
              key: controller.formstate,
              child: ListView(children: [
                const SizedBox(height: 20),
                CustomTextTitleAuth(text: "27".tr),
                const SizedBox(height: 10),
                CustomTextBodyAuth(
                  // please Enter Your Email Address To Recive A verification code
                    text: "29".tr),
                const SizedBox(height: 15),
                CustomTextFormAuth(
                  isNumber: false,
                  valid: (val) {},
                  mycontroller: controller.email,
                  hinttext: "12".tr,
                  iconData: Icons.email_outlined,
                  labeltext: "18".tr,
                  // mycontroller: ,
                ),
                controller.statusRequest ==
                    StatusRequest.loading
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    :
                CustomButtomAuth(
                    text: "30".tr,
                    onPressed: () {
                      controller.checkemail();
                    }),
                const SizedBox(height: 40),
              ]),
            ),
          )),
    );
  }
}