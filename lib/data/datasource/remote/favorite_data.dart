import 'package:user_app/core/class/crud.dart';
import 'package:user_app/link_api.dart';

class FavoriteData {
  Crud crud;

  FavoriteData(this.crud);

  Future<dynamic> addFavorite(String usersid, String productsid) async {
    try {
      // Création du corps de la requête avec les IDs
      var body = {
        'usersid': usersid,
        'productsid': productsid,
      };

      // Envoi de la requête POST avec le corps
      var response = await crud.postData(AppLink.favoriteAdd, body);

      // Gestion de la réponse
      return response.fold(
            (l) {
          // Gestion de l'erreur
          print('Erreur : $l');
          return l; // Retourne l'erreur
        },
            (r) {
          // Traitement de la réponse réussie
          if (r['status'] == 'success') {
            print('Succès : ${r['message']}');
          } else {
            print('Échec : ${r['message']}');
          }
          return r; // Retourne la réponse
        },
      );
    } catch (e) {
      print('Exception : $e');
      return {'status': 'error', 'message': 'Erreur interne dans l\'application'};
    }
  }


  removeFavorite(String usersid, String productsid) async {
    // Création du corps de la requête avec les IDs
    var body = {
      'usersid': usersid,
      'productsid': productsid,
    };

    // Envoi de la requête POST avec le corps
    var response = await crud.postData(AppLink.favoriteRemove, body);

    // Gérer la réponse
    return response.fold(
          (l) {
        // Gestion de l'erreur
        print('Erreur : $l');
        return l; // Retourne l'erreur
      },
          (r) {
        // Traitement de la réponse réussie
        print('Réponse : $r');
        return r; // Retourne la réponse
      },
    );
  }




}
