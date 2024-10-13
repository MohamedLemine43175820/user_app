
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/view/widget/language/custombuttomlang.dart';


import '../../core/localization/changelocal.dart';


class Language extends GetView<LocaleController> {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("1".tr, style: Theme.of(context).textTheme.displayLarge),
              const SizedBox(height: 20),
              CustomButtonLang(
                  textbutton: "Arabic",
                  onPressed: () {
                    controller.changeLang("ar");
                    Get.toNamed(AppRoute.onBoarding) ;
                  }),
              CustomButtonLang(
                  textbutton: "English",
                  onPressed: () {
                    controller.changeLang("en");
                    Get.toNamed(AppRoute.onBoarding) ;
                  }),
              CustomButtonLang(
                  textbutton: "France",
                  onPressed: () {
                    controller.changeLang("fr");
                    Get.toNamed(AppRoute.onBoarding) ;
                  }),
            ],
          )),
    );
  }
}
