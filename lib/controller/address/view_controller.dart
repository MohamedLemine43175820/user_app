
import 'package:get/get.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/functions/handingdatacontroller.dart';
import 'package:user_app/core/services/services.dart';
import 'package:user_app/data/datasource/remote/address_data.dart';
import 'package:user_app/data/model/address_model.dart';

class AddressViewController extends GetxController {
  AddressData addressData = AddressData(Get.find());

 // List<AddressModel> data = [];
  
  List  data = [];

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

 deleteAddress(String addressid) {
    addressData.deleteData(addressid);
    data.removeWhere((element) => element.addressId == addressid);
    update();
  }

  getData() async {
    statusRequest = StatusRequest.loading;
    update(); // Met à jour l'état pour refléter le chargement

    // Appel à la méthode getData pour récupérer les adresses
    var response = await addressData.getData(myServices.sharedPreferences.getString("_id")!);
    print("=============================== Controller $response ");

    // Gérer la réponse du backend
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Vérifier si la réponse est un succès
      if (response['status'] == "success") {
        
        
        List listdata = response['data'];

        // Vérifier si la liste n'est pas vide avant de l'ajouter
        if (listdata.isNotEmpty) {
          

          
          data.addAll(listdata.map((e) => AddressModel.fromJson(e)));
        } else {
          statusRequest = StatusRequest.failure; // Aucune adresse trouvée
        }
      } else {
        statusRequest = StatusRequest.failure; // Si le statut n'est pas "success"
      }
    }
    update(); // Met à jour l'état final
  }



/*

  getData() async {
    statusRequest = StatusRequest.loading;

    var response = await addressData
        .getData(myServices.sharedPreferences.getString("_id")!);

    print("=============================== Controller $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {

        data.addAll(response['data']);

      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

*/




  @override
  void onInit() {
    getData();
    super.onInit();
  }
}