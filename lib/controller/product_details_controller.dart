
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/cart_controller.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/functions/handingdatacontroller.dart';
import 'package:user_app/core/services/services.dart';
import 'package:user_app/data/datasource/remote/cart_data.dart';
import 'package:user_app/data/model/items_model.dart';

abstract class ProductDetailsController extends GetxController {}

class ProductDetailsControllerImp extends ProductDetailsController {
  late ItemsModel itemsModel;

 //  CartController cartController = Get.put(CartController());
  MyServices myServices = Get.find();

  CartData cartData = CartData(Get.find());

  late StatusRequest statusRequest;
   int   countitems = 0 ;

  /*
  intialData()  async{
    statusRequest = StatusRequest.loading;
    itemsModel = Get.arguments['itemsmodel'];
    countItems =  await  cartController.getCountItems(itemsModel.itemsId!);
    statusRequest = StatusRequest.success;
    update();
  }*/

  intialData() async {
    statusRequest = StatusRequest.loading;
    update(); // Mettre à jour l'état après avoir défini le statusRequest

    // Récupérer 'itemsmodel' des arguments
    itemsModel = Get.arguments['itemsmodel'];

    // Vérifier si itemsModel.itemsId n'est pas nul avant de l'utiliser
    if (itemsModel?.itemsId != null) {
      countitems = await getCountItems(itemsModel.itemsId!);

      statusRequest = StatusRequest.success;
    } else {
      statusRequest = StatusRequest.failure; // Si itemsId est nul, définir l'état en échec
    }

    update(); // Mettre à jour l'état après avoir défini success ou failure
  }

  addItems(String itemsid) async {
    // Initialiser le statut à "loading" et mettre à jour l'interface
    statusRequest = StatusRequest.loading;
    update();

    // Récupérer l'ID utilisateur depuis les préférences partagées
    String? userId = myServices.sharedPreferences.getString("_id");

    // Vérifier si l'ID utilisateur est valide
    if (userId == null) {
      // Si l'ID est nul, on renvoie un message d'erreur
      statusRequest = StatusRequest.failure;
      Get.rawSnackbar(
        title: "Erreur",
        messageText: const Text("Utilisateur non identifié, veuillez vous reconnecter."),
      );
      update();
      return;
    }

    // Appeler la fonction addCart avec l'ID utilisateur et l'ID du produit
    var response = await cartData.addCart(userId, itemsid);
    print("=============================== Controller $response ");

    // Traiter les données reçues du serveur
    statusRequest = handlingData(response);

    // Si la requête est un succès
    if (StatusRequest.success == statusRequest) {
      // Vérifier la réponse du serveur
      if (response['status'] == "success") {
        // Afficher une notification de succès
        Get.rawSnackbar(
          title: "اشعار",
          messageText: const Text("تم اضافة المنتج الى السلة "),
        );
        // Si nécessaire, tu peux mettre à jour tes données ici
        // data.addAll(response['data']);
      } else {
        // En cas d'échec, changer le statut à "failure"
        statusRequest = StatusRequest.failure;
        Get.rawSnackbar(
          title: "Erreur",
          messageText: Text(response['message'] ?? "Échec de l'ajout au panier."),
        );
      }
    } else {
      // Si la requête a échoué au niveau du traitement des données
      Get.rawSnackbar(
        title: "Erreur",
        messageText: const Text("Erreur lors de la communication avec le serveur."),
      );
    }

    // Mettre à jour l'interface
    update();
  }

  deleteItems(String itemsid) async {
    statusRequest = StatusRequest.loading;
    update();

    // Récupérer l'ID utilisateur depuis les préférences partagées
    String? usersId = myServices.sharedPreferences.getString("_id");

    // Vérifier si l'ID utilisateur est valide
    if (usersId == null || usersId.isEmpty) {
      statusRequest = StatusRequest.failure;
      Get.rawSnackbar(
        title: "خطأ",
        messageText: const Text("ID utilisateur non valide."),
      );
      update();
      return; // Sortir de la fonction si l'ID utilisateur est invalide
    }

    // Appel à la fonction removeCart pour supprimer l'élément du panier
    var response = await cartData.deleteCart(usersId, itemsid);

    print("=============================== Controller $response ");

    // Gestion de l'état de la requête
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response.containsKey('message')) {
        // Si la réponse contient un message, afficher une notification de succès
        Get.rawSnackbar(
          title: "اشعار",
          messageText: const Text("تم ازالة المنتج من السلة "),
        );
      } else {
        // Si aucun message, cela signifie une erreur
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }




  getCountItems(String itemsid) async {
    statusRequest = StatusRequest.loading;

    String? userId = myServices.sharedPreferences.getString("_id");

    if (userId == null) {
      print('Erreur: L\'ID utilisateur est manquant.');
      statusRequest = StatusRequest.failure;
      return 0;
    }

    try {
      var response = await cartData.getCountCart(userId, itemsid);
      print("=============================== Controller $response ");

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {

          int   countitems = 0;
          countitems = (response['data']);
          print("==================================");
          print("Nombre d'éléments: $countitems");
          return countitems;


        } else {
          print('Erreur du backend: ${response['message']}');
          statusRequest = StatusRequest.failure;
          return 0;
        }
      } else {
        print('Erreur: échec du traitement des données.');
        return 0;
      }
    } catch (e) {
      print('Exception: $e');
      statusRequest = StatusRequest.failure;
      return 0;
    }
  }










  List subitems = [
    {"name": "red", "id": 1, "active": '0'},
    {"name": "yallow", "id": 2, "active": '0'},
    {"name": "black", "id": 3, "active": '1'}
  ];

  add(){

    addItems(itemsModel.itemsId!);
    countitems++;
    update();

  }

  remove(){


    if(countitems > 0){
      deleteItems(itemsModel.itemsId!);
      countitems--;
      update();
    }
  }

  @override
  void onInit() {
    intialData();
    super.onInit();
  }
}