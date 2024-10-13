
import 'package:get/get.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/core/functions/handingdatacontroller.dart';
import 'package:user_app/core/services/services.dart';
import 'package:user_app/data/datasource/remote/home_data.dart';

abstract class  HomeController extends GetxController {
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

  @override
  void onInit() {
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
}
