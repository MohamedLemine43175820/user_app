
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/functions/handingdatacontroller.dart';
import 'package:user_app/core/services/services.dart';
import 'package:user_app/data/datasource/remote/favorite_data.dart';

class FavoriteController extends GetxController {
 FavoriteData favoriteData = FavoriteData(Get.find());

  //List data = [];

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  Map isFavorite = {};

//  key => id items
//  Value => 1 OR 0

  setFavorite(id, val) {
    isFavorite[id] = val;
    update();
  }



  addFavorite(String itemsid) async {
    // Vérification de l'ID utilisateur
    String? userId = myServices.sharedPreferences.getString("_id");

    if (userId == null) {
      print("Erreur : L'ID utilisateur est null.");
      statusRequest = StatusRequest.failure;
      Get.rawSnackbar(
        title: "Erreur",
        messageText: const Text("L'ID utilisateur est manquant. Veuillez réessayer."),
      );
      return;
    }

    // Vérification de l'ID produit
    if (itemsid.isEmpty) {
      print("Erreur : L'ID produit est vide.");
      statusRequest = StatusRequest.failure;
      Get.rawSnackbar(
        title: "Erreur",
        messageText: const Text("L'ID du produit est manquant. Veuillez réessayer."),
      );
      return;
    }

    try {
      statusRequest = StatusRequest.loading;
      var response = await favoriteData.addFavorite(userId, itemsid);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.rawSnackbar(
            title: "Notification",
            messageText: const Text("Le produit a été ajouté aux favoris avec succès."),
          );
        } else {
          statusRequest = StatusRequest.failure;
          Get.rawSnackbar(
            title: "Erreur",
            messageText: const Text("Impossible d'ajouter aux favoris."),
          );
        }
      }
    } catch (e) {
      print('Erreur inattendue : $e');
      statusRequest = StatusRequest.failure;
      Get.rawSnackbar(
        title: "Erreur",
        messageText: const Text("Une erreur s'est produite. Veuillez réessayer."),
      );
    }
  }




 removeFavorite(String itemsid) async {
   // data.clear();
    statusRequest = StatusRequest.loading;
    var response = await favoriteData.removeFavorite(
        myServices.sharedPreferences.getString("_id")!, itemsid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.rawSnackbar(
          title: "Notification",
          messageText: const Text("Le produit a été retiré des favoris"),
        );

        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
  }


}