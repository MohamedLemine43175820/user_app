
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/home_controller.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/functions/handingdatacontroller.dart';
import 'package:user_app/core/services/services.dart';
import 'package:user_app/data/datasource/remote/items_data.dart';
import 'package:user_app/data/model/items_model.dart';

abstract class ItemsController extends GetxController {
  intialData();
  changeCat(int val, String catval);
  getItems(String categoryid);
  goToPageProductDetails(ItemsModel itemsModel);
}

class ItemsControllerImp extends SearchMixController {
  List categories = [];
  String? catid;
  int? selectedCat;

  ItemsData itemsData = ItemsData(Get.find());

  List data = [];

  late StatusRequest statusRequest;
  
  MyServices myServices = Get.find();
  @override
  void onInit() {
    search = TextEditingController();
    intialData();
    super.onInit();
  }

  @override
  intialData() {
    categories = Get.arguments['categories'];
    selectedCat = Get.arguments['selectedcat'];
    catid = Get.arguments['catid'];
    getItems(catid!);
  }

  @override
  changeCat(val, catval) {
    selectedCat = val;
    catid = catval;
    getItems(catid!);
    update();
  }
  //, myServices.sharedPreferences.getString("id")!);

  @override
  Future<void> getItems(String categoryId) async {
    // Réinitialiser les données et mettre le statut à "loading"
    data.clear();
    statusRequest = StatusRequest.loading;

    // Récupérer l'ID de l'utilisateur à partir des préférences partagées
    String? userId = myServices.sharedPreferences.getString("id");

    // Appeler la méthode pour obtenir les données en passant categoryId et userId
    var response = await itemsData.getData(categoryId, userId: userId);

    print("=============================== Controller $response ");

    // Gérer la réponse
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      // Vérifier si la réponse est un succès du côté `Right`
      response.fold(
            (failure) {
          // Si c'est un échec (Left), mettre le statut à échec
          statusRequest = StatusRequest.failure;
        },
            (success) {
          // Si c'est un succès (Right), traiter les données du backend
          if (success['status'] == "success") {
            // Ajouter les données reçues
            data.addAll(success['data']);
          } else {
            // Si le statut du backend indique un échec
            statusRequest = StatusRequest.failure;
          }
        },
      );
    }

    // Mettre à jour l'état après avoir géré la réponse
    update();
  }



  @override
  goToPageProductDetails(itemsModel) {
    Get.toNamed("productdetails", arguments: {"itemsmodel": itemsModel});
  }
}