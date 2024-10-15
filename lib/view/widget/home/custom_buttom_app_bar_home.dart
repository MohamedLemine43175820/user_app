
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/home_screen_controller.dart';
import 'package:user_app/view/widget/home/custom_button_app_bar.dart';

class CustomBottomAppBarHome extends StatelessWidget {
  const CustomBottomAppBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerImp>(
        builder: (controller) => BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 10,
            child: Row(
              children: [
                ...List.generate(controller.listPage.length + 1, ((index) {
                  int i = index > 2 ? index - 1 : index;
                  return index == 2
                      ? const Spacer()
                      : CustomButtonAppBar(
                      textbutton:  controller.bottomappbar[i]['title'],
                      icondata: controller.bottomappbar[i]['icon'],
                      onPressed: () {
                        controller.changePage(i);
                      },
                      active: controller.currentpage == i ? true : false);
                }))
              ],
            )));
  }
}