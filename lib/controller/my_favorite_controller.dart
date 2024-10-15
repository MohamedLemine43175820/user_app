
import 'package:get/get.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/functions/handingdatacontroller.dart';
import 'package:user_app/core/services/services.dart';
import 'package:user_app/data/datasource/remote/my_favorite_data.dart';
import 'package:user_app/data/model/my_favorite.dart';

class MyFavoriteController extends GetxController {
  MyFavoriteData favoriteData = MyFavoriteData(Get.find());

  List<MyFavoriteModel> data = [];

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();


  getData() async {
    // Effacer les données précédentes
    data.clear();

    // Indiquer que la requête est en cours de chargement
    statusRequest = StatusRequest.loading;
    update();

    // Appel de la fonction getData avec l'ID de l'utilisateur récupéré à partir des préférences partagées
    var response = await favoriteData.getData(myServices.sharedPreferences.getString("_id")!);

    print("=============================== Controller $response ");

    // Gérer la réponse et mettre à jour le statut en fonction du résultat
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Vérifier si la réponse du backend est un succès
      if (response['status'] == "success") {
        // Si la réponse est un succès, extraire les données
        List responsedata = response['data'];
        // Ajouter les données dans la liste `data` après les avoir converties en objets `MyFavoriteModel`
        data.addAll(responsedata.map((e) => MyFavoriteModel.fromJson(e)));
        print("=======================================Données récupérées :");
        print(data);
      } else {
        // Si le statut n'est pas "success", mettre à jour le statut en échec
        statusRequest = StatusRequest.failure;
      }
    }

    // Mettre à jour l'UI en appelant update()
    update();
  }


  Future<void> deleteFromFavorite(String favoriteId) async {
   // statusRequest = StatusRequest.loading; // Statut de chargement avant l'envoi de la requête
   // update();

    // Envoyer la requête de suppression
    var response = await favoriteData.deleteData(favoriteId);

    response.fold(
          (failure) {
        // Gérer les erreurs en cas d'échec
        statusRequest = StatusRequest.error;

        if (failure == StatusRequest.offlinefailure) {
          // Gérer le cas d'échec de connexion
          print("Erreur de connexion. Vérifiez votre Internet.");
        } else {
          // Gérer d'autres types d'échecs
          print("Erreur lors de la suppression : $failure");
        }
        update(); // Mettre à jour l'UI pour afficher une erreur
      },
          (success) {
        // Si la suppression est réussie, supprimer l'élément localement
        data.removeWhere((element) => element.favoriteId == favoriteId);
        statusRequest = StatusRequest.success; // Mettre à jour le statut
        update(); // Mettre à jour l'UI après la suppression
        print("L'élément a été supprimé avec succès.");
      },
    );
  }





  /*

  deleteFromFavorite(String favroiteid) {
    // data.clear();
    // statusRequest = StatusRequest.loading;
    var response = favoriteData.deleteData(favroiteid);
    data.removeWhere((element) => element.favoriteId == favroiteid);
    update();
  }*/


  @override
  void onInit() {
    getData();
    super.onInit();
  }
}