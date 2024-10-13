
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/home_controller.dart';
import 'package:user_app/core/constant/color.dart';
import 'package:user_app/core/functions/translate_data_base.dart';
import 'package:user_app/data/model/categories_model.dart';

class ListCategoriesHome extends GetView<HomeControllerImp> {
  const ListCategoriesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: controller.categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Categories(
            i: index,
            categoriesModel:
            CategoriesModel.fromJson(controller.categories[index]),
          );
        },
      ),
    );
  }
}

class Categories extends GetView<HomeControllerImp> {
  final CategoriesModel categoriesModel;
  final int? i;
  const Categories({Key? key, required this.categoriesModel, required this.i})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.goToItems(controller.categories, i! , categoriesModel.categoriesId!);
      },


      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColor.thirdColor,
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 70,
            width: 70,
            child: Image.network(
              "${categoriesModel.categoriesImage}",
             // height: 100,
              //width: 150,
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
          Text(
            "${translateDatabase(categoriesModel.categoriesNameAr, categoriesModel.categoriesName)}",
            style: const TextStyle(fontSize: 13, color: AppColor.black),
          )
        ],
      ),
    );
  }
}
//categoriesModel.categoriesName