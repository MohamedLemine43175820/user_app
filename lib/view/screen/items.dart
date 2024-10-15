

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/favorite_controller.dart';
import 'package:user_app/controller/items_controller.dart';
import 'package:user_app/core/class/handling_data_view.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/data/model/items_model.dart';
import 'package:user_app/view/widget/home/custom_app_bar.dart';
import 'package:user_app/view/widget/items/custom_list_items.dart';
import 'package:user_app/view/widget/items/list_categories_items.dart';

class Items extends StatelessWidget {
  const Items({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ItemsControllerImp());
    FavoriteController controllerFav = Get.put(FavoriteController());

    return Scaffold(
      body: Container(
        padding:const EdgeInsets.all(15),
        child:  ListView(children: [
                  CustomAppBar(
                      titleappbar: "Find Product",
                      onPressedIcon: () {},
                      onPressedSearch: () {},
                    onPressedIconFavorite: (){
                      Get.toNamed(AppRoute.myfavroite) ;
                    },

                  ),
                  const SizedBox(height: 20),
                  const ListCategoriesItems(),
                  GetBuilder<ItemsControllerImp>(
                   builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
               widget:
                  GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:controller.data.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.6),
                      itemBuilder: (BuildContext context, index) {
                        controllerFav.isFavorite[controller.data[index]
                        ['_id']] = controller.data[index]['favorite'];
                        return CustomListItems(

                            itemsModel:
                            ItemsModel.fromJson(controller.data[index]));
                      })))
                ]),
      ),
    );
  }
}