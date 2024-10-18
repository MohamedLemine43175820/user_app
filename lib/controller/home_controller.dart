
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/core/functions/handingdatacontroller.dart';
import 'package:user_app/core/services/services.dart';
import 'package:user_app/data/datasource/remote/home_data.dart';
import 'package:user_app/data/model/items_model.dart';

abstract class  HomeController extends SearchMixController {
  initialData()  ;
  getdata() ;
  goToItems(List categories, int selectedCat , String categoryid);

}

class HomeControllerImp extends HomeController {
  MyServices myServices = Get.find();




  String? username;
  String? id;
  String? lang ;

  HomeData homedata = HomeData(Get.find());

  // List data = [];

  List categories = [];

  List items = [];

  late StatusRequest statusRequest;

  @override
  initialData() {
    lang = myServices.sharedPreferences.getString('lang');
    username = myServices.sharedPreferences.getString("username");
    id = myServices.sharedPreferences.getString("id");
  }







  /*searchData() async {
    statusRequest = StatusRequest.loading;
    update();  // Mettez à jour l'interface pour montrer le chargement

    // Appel à l'API avec le terme de recherche
    var response = await homedata.searchData(search!.text);
    print("=============================== Controller $response ");

    // Gestion des données
    statusRequest = handlingData(response);

    // Si la requête est un succès
    if (StatusRequest.success == statusRequest) {

      // Vérification si la réponse contient le statut 'success'
      if (response['status'] == "success") {

        // Vérifier la clé 'data' et s'assurer que c'est une liste
        if (response.containsKey('data') && response['data'] is List) {

          // Efface les anciennes données
          listdata.clear();

          // Ajout des nouvelles données au modèle ItemsModel
          List responsedata = response['data'];
          listdata.addAll(responsedata.map((e) => ItemsModel.fromJson(e)));

        } else {
          // Gestion du cas où 'data' n'existe pas ou n'est pas une liste
          print("Erreur : Données invalides dans la réponse");
          statusRequest = StatusRequest.failure;
        }

      } else {
        // Si le statut n'est pas 'success', échec de la requête
        print("Erreur : Statut de la réponse non réussi");
        statusRequest = StatusRequest.failure;
      }

    } else {
      // Si la requête échoue (problème réseau ou autre)
      print("Erreur : Échec de la requête");
    }

    // Mettre à jour l'interface utilisateur pour refléter les changements
    update();
  }*/













  @override
  void onInit() {
    search = TextEditingController();
    getdata();
    initialData();
    super.onInit();
  }


  @override
  getdata() async {
    // Initialiser le statut à 'loading'

    statusRequest = StatusRequest.loading;

    // Récupérer les données via l'API
    var response = await homedata.getData();

    print("=============================== Controller $response ");

    // Gérer le statut de la réponse
    statusRequest = handlingData(response);

    // Si le statut est 'success'
    if (statusRequest == StatusRequest.success) {
      // Vérifier si la réponse contient 'status' et s'il est 'success'
      if (response['status'] == "success") {
        // Ajouter les catégories récupérées à la liste
        categories.clear();
        categories.addAll(response['categories']);
        items.clear();
        items.addAll(response['products']);

      } else {
        // Si le 'status' n'est pas 'success', définir le statut à 'failure'
        statusRequest = StatusRequest.failure;
      }
    }

    // Mettre à jour l'interface utilisateur
    update();
  }

  @override
  goToItems(categories, selectedCat ,   categoryid) {
    Get.toNamed(AppRoute.items,
        arguments: {
          "categories": categories,
          "selectedcat": selectedCat ,
          "catid": categoryid});

  }

  goToPageProductDetails(itemsModel) {
    Get.toNamed("productdetails", arguments: {"itemsmodel": itemsModel});
  }


}


  class SearchMixController extends GetxController{

    HomeData homedata = HomeData(Get.find());

    TextEditingController? search;

    bool isSearch = false  ;
    List<ItemsModel> listdata = [];

    late StatusRequest statusRequest;

    checkSearch(val){

      if(val == ""){

        statusRequest  = StatusRequest.none;


        isSearch = false ;
      }
      update();
    }

    onSearchItems(){

      isSearch = true;
      searchData();
      update();
    }




    searchData() async {
      statusRequest = StatusRequest.loading; // Indiquer que la requête est en cours
      var response = await homedata.searchData(search!.text);
      print("=============================== Controller $response ");

      // Gérer la réponse en fonction du statut
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          listdata.clear();
          List responsedata = response['data'];

          // Vérifier si des produits ont été trouvés
          if (responsedata.isEmpty) {
            // Mettre à jour l'état pour indiquer qu'aucun produit n'a été trouvé
            statusRequest = StatusRequest.noProducts; // Un nouveau statut que tu devras définir
            print("Aucun produit trouvé");
          } else {
            listdata.addAll(responsedata.map((e) => ItemsModel.fromJson(e)));
          }
        } else {
          statusRequest = StatusRequest.failure;
        }
      }

      update(); // Met à jour l'interface utilisateur
    }





  }





