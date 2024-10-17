
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/cart_controller.dart';
import 'package:user_app/core/constant/color.dart';
import 'package:user_app/core/constant/imgaeasset.dart';

class CustomItemsCartList extends StatelessWidget {
  final String name ;
  final String price  ;
  final String count   ;
  final String imagename;
  final void Function()? onAdd ;
  final void Function()? onRemove ;
  const CustomItemsCartList({Key? key, required this.name, required this.price, required this.count, required this.imagename,required this.onAdd,required this.onRemove , }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Container(
        child: Row(children: [
          Expanded(
              flex: 2,
              child: Container(
                //color: AppColor.primaryColor,
                child: Image.network(

                  "$imagename",
                  height: 80,
                 // fit: BoxFit.cover,
                ),
              )),
          Expanded(
              flex: 3,
              child: ListTile(
                title: Text(name, style: TextStyle(fontSize: 15)),
                subtitle: Text(price,
                    style:
                    TextStyle(color: AppColor.primaryColor, fontSize: 17)),
              )),
          Expanded(
              child: Column(
                children: [
                  Container(
                      height: 35,
                      child: IconButton(onPressed: onAdd, icon: Icon(Icons.add))),
                  Container(
                      height: 30,
                      child: Text(
                        count,
                        style: TextStyle(fontFamily: "sans"),
                      )),
                  Container(
                      height: 25,
                      child: IconButton(onPressed: onRemove, icon: Icon(Icons.remove)))
                ],
              ))
        ]),
      ),
    );
  }
}