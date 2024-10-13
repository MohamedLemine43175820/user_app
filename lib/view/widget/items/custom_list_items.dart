import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/items_controller.dart';
import 'package:user_app/core/constant/color.dart';
import 'package:user_app/core/functions/translate_data_base.dart';
import 'package:user_app/data/model/items_model.dart';

class CustomListItems extends GetView<ItemsControllerImp> {
  final ItemsModel itemsModel;
 // final bool active ;
  const CustomListItems( {Key? key, required this.itemsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          controller.goToPageProductDetails(itemsModel)  ;
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: "${itemsModel.itemsId}",
                    child: Image.network(
                      "${itemsModel.itemsImage!}",  // URL de l'image
                      height: 100,                  // Hauteur de l'image
                      fit: BoxFit.fill,             // Adaptation de l'image
                      // Gestion de l'erreur si l'image ne peut pas être chargée
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.broken_image,  // Icône d'image cassée
                              size: 100,           // Taille de l'icône
                              color: Colors.grey,   // Couleur de l'icône
                            ),
                            Text(
                              'Image not available',  // Message d'erreur
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        );
                      },
                      // Optionnel : Afficher un indicateur de chargement pendant le téléchargement de l'image
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;  // L'image est chargée, on la renvoie
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 10) ,
                  Text(translateDatabase(itemsModel.itemsNameAr! , itemsModel.itemsName),
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rating 3.5 ", textAlign: TextAlign.center),
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 22,
                        child: Row(
                          children: [
                            ...List.generate(
                                5,
                                    (index) => Icon(
                                  Icons.star,
                                  size: 15,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${itemsModel.itemsPrice} \$",
                          style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "sans")),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                           itemsModel.favorite == true  ? Icons.favorite : Icons.favorite_border_outlined,
                            color: AppColor.primaryColor,
                          ))
                    ],
                  )
                ]),
          ),
        ));
  }
}