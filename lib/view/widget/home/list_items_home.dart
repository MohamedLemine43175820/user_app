
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/home_controller.dart';
import 'package:user_app/core/constant/color.dart';
import 'package:user_app/data/model/items_model.dart';

class ListItemsHome extends GetView<HomeControllerImp> {
  const ListItemsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
          itemCount: controller.items.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return ItemsHome(
                itemsModel: ItemsModel.fromJson(controller.items[i]));
          }),
    );
  }
}

class ItemsHome extends StatelessWidget {
  final ItemsModel itemsModel;
  const ItemsHome({Key? key, required this.itemsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Image.network(
            "${itemsModel.itemsImage}",
           // height: 100,
           // width: 150,
           // fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              // Widget à afficher en cas d'erreur de chargement de l'image
              return Icon(
                Icons.broken_image, // Icône d'image cassée
                size: 50,          // Taille de l'icône
                color: Colors.grey, // Couleur de l'icône
              );
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColor.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20)),
          height: 120,
          width: 200,
        ),
        Positioned(
            left: 10,
            child: Text(
              "${itemsModel.itemsName}",
              style: const TextStyle(
                  color: Colors.white,
                  // fontWeight: FontWeight.bold,
                  fontSize: 14),
            ))
      ],
    );
  }
}