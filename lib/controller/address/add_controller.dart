import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/core/localization/changelocal.dart';

class AddAddressController extends GetxController{

  StatusRequest statusRequest = StatusRequest.loading;



   Completer<GoogleMapController>? completercontroller ;

  List<Marker> markers = [];
  double? lat;
  double? long;

  addMarkers(LatLng latLng) {
    markers.clear();
    markers.add(Marker(markerId: MarkerId("1"), position: latLng));
    lat = latLng.latitude;
    long = latLng.longitude;
    update();
  }

  Position? position;  // Corrige la variable ici si nécessaire
  CameraPosition? kGooglePlex;


  /*Position? position;  // Corrige la variable ici si nécessaire
  CameraPosition? kGooglePlex;

  getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition();
    kGooglePlex = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      zoom: 14.4746,
    );
    statusRequest = StatusRequest.none;
    update();
  }*/




  goToPageAddDetailsAddress() {
    Get.toNamed(AppRoute.addressadddetails,
        arguments: {"lat": lat.toString(), "long": long.toString()});
  }



  Future<void> getCurrentLocation() async {
    await LocaleController.requestPerLocation(); // Appeler la fonction pour vérifier/demander les permissions

    try {
      // Si les permissions sont accordées, obtenir la position actuelle
      position = await Geolocator.getCurrentPosition();

      // Mettre à jour la position sur la carte ou autre logique
      kGooglePlex = CameraPosition(
        target: LatLng(position!.latitude, position!.longitude),
        zoom: 14.4746,
      );

      statusRequest = StatusRequest.none;

      update(); // Met à jour l'UI en utilisant GetX
    } catch (e) {
      print("Erreur lors de l'obtention de la position : $e");
    }
  }




  @override
  void onInit(){
    getCurrentLocation();
   completercontroller = Completer<GoogleMapController>();
   super.onInit();


  }

}


/* CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );*/

/* static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);*/