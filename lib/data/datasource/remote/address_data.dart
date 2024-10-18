

import 'package:user_app/core/class/crud.dart';
import 'package:user_app/link_api.dart';

class AddressData {
  Crud crud;
  AddressData(this.crud);
  
  Future<dynamic> getData(String id) async {
    // Remplacer :id par l'ID de l'utilisateur dans l'URL
    final String url = AppLink.getUserAddressesById.replaceFirst(':id', id);

    // Utiliser la méthode GET pour récupérer les adresses de l'utilisateur
    var response = await crud.getData(url);

    return response.fold((l) => l, (r) => r);
  }



  Future<dynamic> addData(String usersid, String name, String city, String street, String lat, String long) async {
    var response = await crud.postData(AppLink.addressAdd, {
      "address_usersid": usersid,  // Clé mise à jour pour correspondre au backend
      "address_name": name,         // Clé mise à jour
      "address_city": city,         // Clé mise à jour
      "address_street": street,     // Clé mise à jour
      "address_lat": lat,           // Clé mise à jour
      "address_long": long,         // Clé mise à jour
    });

    // Gérer la réponse avec un retour approprié
    return response.fold(
            (l) {
          // Gérer l'erreur ici
          print("Erreur: $l"); // Ou une autre gestion d'erreur
          return l; // Retourner l'erreur
        },
            (r) {
          // Gérer la réponse réussie ici
          return r; // Retourner les données
        }
    );
  }


  deleteData(String addressId) async {
    // Construire l'URL avec l'ID de l'adresse
    String url = '${AppLink.addressDelete.replaceAll(':id', addressId)}';

    // Effectuer la requête DELETE
    var response = await crud.deleteData(url);
    return response.fold((l) => l, (r) => r);
  }

}