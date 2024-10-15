// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:user_app/view/widget/cart/app_bar_cart.dart';
import 'package:user_app/view/widget/cart/custom_bottom_navgation_bar_cart.dart';
import 'package:user_app/view/widget/cart/custom_items_cart_list.dart';
import 'package:user_app/view/widget/cart/top_card_cart.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavgationBarCart(
            price: "1200", shipping: "300", totalprice: "1500"),
        body: ListView(
          children: [
            TopAppbarCart(
              title: 'My Cart',
            ),
            SizedBox(height: 10),
            TopCardCart(message: "You Have 2 Items in Your List"),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: const [
                  CustomItemsCartList(
                      name: "Macbook M1", price: "1100.0 \$", count: "2"),
                  CustomItemsCartList(
                      name: "Macbook M2 Max", price: "2100.0 \$", count: "1"),
                ],
              ),
            )
          ],
        ));
  }
}