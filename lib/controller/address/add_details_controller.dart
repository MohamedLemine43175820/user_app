
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/core/functions/handingdatacontroller.dart';
import 'package:user_app/core/services/services.dart';
import 'package:user_app/data/datasource/remote/address_data.dart';

class AddAddressDetailsController extends GetxController {
 StatusRequest statusRequest = StatusRequest.none;

  AddressData addressData = AddressData(Get.find());

 MyServices myServices = Get.find();

TextEditingController? name;
  TextEditingController? city;
  TextEditingController? street;


 addAddress() async {
   statusRequest = StatusRequest.loading;
   update();

   try {
     // Récupérer l'ID de l'utilisateur
     String userId = myServices.sharedPreferences.getString("_id")!;

     // Appeler la méthode addData
     var response = await addressData.addData(
         userId,
         name!.text,
         city!.text,
         street!.text,
         lat!,
         long!
     );

     print("=============================== Controller $response ");

     // Gérer la réponse
     statusRequest = handlingData(response);

     if (statusRequest == StatusRequest.success) {
       // Vérifier le statut de la réponse du backend
       if (response['status'] == "success") {
         Get.offAllNamed(AppRoute.homepage);
       } else {
         statusRequest = StatusRequest.failure;
         Get.snackbar("Erreur", response['message'] ?? "Erreur lors de l'ajout de l'adresse.");
       }
     } else {
       // Gérer les autres statuts (échec, etc.)
       Get.snackbar("Erreur", "Une erreur s'est produite lors de la requête.");
     }
   } catch (e) {
     // Gérer les exceptions
     statusRequest = StatusRequest.failure;
     Get.snackbar("Erreur", "Une exception s'est produite : $e");
   } finally {
     // Mettre à jour l'état dans tous les cas
     update();
   }
 }





  String? lat;
  String? long;

  void intialData() {

    name = TextEditingController();
    city = TextEditingController();
    street = TextEditingController();
    // Vérifier si les arguments existent et sont de type String
    if (Get.arguments != null && Get.arguments['lat'] is String && Get.arguments['long'] is String) {
      lat = Get.arguments['lat'];
      long = Get.arguments['long'];
    } else {
      print("Les arguments lat et long ne sont pas valides ou sont manquants.");
    }

    print("Latitude: $lat");
    print("Longitude: $long");
  }


  @override
  void onInit() {
    intialData();
    super.onInit();
  }
}













/*

 String? lat;
  String? long;

  intialData() {
  //  name = TextEditingController();
  //  city = TextEditingController();
  //  street = TextEditingController();

    lat = Get.arguments['lat'];
    long = Get.arguments['long'];

    print(lat);
    print(long);
  }
 */