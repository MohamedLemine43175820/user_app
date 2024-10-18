
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/my_favorite_controller.dart';
import 'package:user_app/core/class/handling_data_view.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/view/widget/home/custom_app_bar.dart';
import 'package:user_app/view/widget/my_favorite/custom_list_favorite_item.dart';

class MyFavorite extends StatelessWidget {
  const MyFavorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MyFavoriteController());
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: GetBuilder<MyFavoriteController>(
            builder: ((controller) => ListView(children: [
             /* CustomAppBar(
                titleappbar: "Find Product",
                onPressedIcon: () {},
                onPressedSearch: () {},
                onPressedIconFavorite: () {
                  Get.toNamed(AppRoute.myfavroite);
                },
              ),*/
              SizedBox(height: 20) ,
              HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.data.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.6),
                    itemBuilder: (context, index) {
                      return  CustomListFavoriteItems(itemsModel: controller.data[index]) ;
                    },
                  ))
            ]))),
      ),
    );
  }
}