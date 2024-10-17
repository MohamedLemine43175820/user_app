
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/home_screen_controller.dart';
import 'package:user_app/core/constant/color.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/view/widget/home/custom_buttom_app_bar_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenControllerImp());
    return GetBuilder<HomeScreenControllerImp>(
        builder: (controller) => Scaffold(
          floatingActionButton: FloatingActionButton(
              backgroundColor: AppColor.primaryColor,
              onPressed: () {
                
                Get.toNamed(AppRoute.cart);
              },
              child: const Icon(Icons.shopping_basket_outlined)),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const CustomBottomAppBarHome(),
          body: controller.listPage.elementAt(controller.currentpage),
        ));
  }
}