
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/functions/handingdatacontroller.dart';
import 'package:user_app/core/services/services.dart';
import 'package:user_app/data/datasource/remote/cart_data.dart';
import 'package:user_app/data/model/cart_model.dart';

class CartController extends GetxController {
  CartData cartData = CartData(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();


  List<CartModel> data = [];     // list data

  double priceorders = 0.0;     //total price

  int totalcountitems = 0;       // total count


  add(String itemsid) async {
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

  delete(String itemsid) async {
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

















  resetVarCart() {
    totalcountitems = 0;
    priceorders = 0.0;
    data.clear();
  }

  refreshPage() {
    resetVarCart();
    view();
  }







  view() async {
    statusRequest = StatusRequest.loading;
    update();
   // data.clear();

    // Appel à l'API pour récupérer les données du panier
    var response = await cartData.viewCart(myServices.sharedPreferences.getString("_id")!);

    print("=============================== Controller $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Vérifie si le backend a renvoyé un succès
      if (response['status'] == "success") {
        List dataresponse = response['data'];
        Map dataresponsecountprice = response['countprice'];

        // Vide la liste actuelle avant d'ajouter les nouvelles données
        data.clear();

        // Ajoute les nouvelles données à la liste après les avoir converties en objets `CartModel`
        data.addAll(dataresponse.map((e) => CartModel.fromJson(e)));

        // Mets à jour les variables pour le prix total et le nombre total d'articles
       // priceorders = double.parse(dataresponsecountprice['totalprice']); // Prix total
        //totalcountitems =int.parse(dataresponsecountprice['totalcount']); // Nombre total d'articles

        // Récupérer le prix total de manière sécurisée
        if (dataresponsecountprice['totalprice'] != null) {
          priceorders = double.tryParse(dataresponsecountprice['totalprice'].toString()) ?? 0.0;
        } else {
          priceorders = 0.0;
        }

// Récupérer le nombre total d'articles de manière sécurisée
        if (dataresponsecountprice['totalcount'] != null) {
          totalcountitems = int.tryParse(dataresponsecountprice['totalcount'].toString()) ?? 0;
        } else {
          totalcountitems = 0;
        }


        print(totalcountitems); // Devrait afficher le nombre total d'articles
        print(priceorders); // Devrait afficher le prix total
      } else {
        // Si le statut est autre que "success", considère la requête comme un échec
        statusRequest = StatusRequest.failure;
      }
    }

    // Mets à jour l'état de la vue
    update();
  }








  @override
  void onInit() {
    view();
    super.onInit();
  }
}