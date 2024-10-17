// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/cart_controller.dart';
import 'package:user_app/core/class/handling_data_view.dart';
import 'package:user_app/view/widget/cart/app_bar_cart.dart';
import 'package:user_app/view/widget/cart/custom_bottom_navgation_bar_cart.dart';
import 'package:user_app/view/widget/cart/custom_items_cart_list.dart';
import 'package:user_app/view/widget/cart/top_card_cart.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    CartController cartController = Get.put(CartController());
    return Scaffold(
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) =>
            BottomNavgationBarCart(
            price: "${cartController.priceorders}",
            shipping: "300",
            totalprice: "1500"

        ),),
        body: GetBuilder<CartController>(
    builder: (controller)=> HandlingDataView(
    statusRequest: controller.statusRequest,
    widget: ListView(
      children: [
        TopAppbarCart(
          title: 'My Cart',
        ),
        SizedBox(height: 10),
        TopCardCart(message: "You Have ${cartController.totalcountitems} Items in Your List"),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children:  [


                ...List.generate(

                  cartController.data.length,
                      (index)=>CustomItemsCartList(
                           name: "${cartController.data[index].itemsName}",
                      price: "${cartController.data[index].totalitemsprice} \$",  // mais total price
                      count: "${cartController.data[index].countitems}",
                        imagename: '${cartController.data[index].itemsImage}',
                        onAdd: ()  async {

                           await   cartController.add(cartController.data[index].itemsId!);
                             cartController.refreshPage();
                        },
                        onRemove: () async  {
                          await cartController.delete(cartController.data[index].itemsId!);
                          cartController.refreshPage();

                        },

                  ),
                )





            ],
          ),
        )
      ],
    )),
    ));
  }
}



/*






              )
*/


