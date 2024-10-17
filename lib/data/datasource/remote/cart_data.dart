import 'package:user_app/core/class/crud.dart';
import 'package:user_app/link_api.dart';

class CartData {
  Crud crud;

  CartData(this.crud);

  Future<dynamic> addCart(String usersid, String productsid) async {
    try {
      // Vérification des entrées pour s'assurer qu'elles ne sont pas nulles ou vides
      if (usersid.isEmpty || productsid.isEmpty) {
        return {
          'status': 'error',
          'message': 'L\'ID utilisateur ou l\'ID du produit est manquant.'
        };
      }

      // Création du corps de la requête avec les IDs
      var body = {
        'usersid': usersid,
        'productsid': productsid,
      };

      // Envoi de la requête POST avec le corps
      var response = await crud.postData(AppLink.addToCart, body);

      // Gestion de la réponse
      return response.fold(
            (l) {
          // Gestion de l'erreur (par exemple : problème réseau)
          print('Erreur : $l');
          return {
            'status': 'error',
            'message': 'Erreur de connexion ou serveur indisponible'
          };
        },
            (r) {
          // Traitement de la réponse réussie
          if (r['status'] == 'success') {
            print('Succès : ${r['message']}');
          } else {
            print('Échec : ${r['message']}');
          }
          return r; // Retourne la réponse du serveur
        },
      );
    } catch (e) {
      // Gestion d'une exception dans l'application elle-même
      print('Exception : $e');
      return {
        'status': 'error',
        'message': 'Erreur interne dans l\'application'
      };
    }
  }


  deleteCart(String usersid, String productsid) async {
    // Création du corps de la requête avec les IDs
    var body = {
      'usersid': usersid,
      'productsid': productsid,
    };

    // Envoi de la requête POST avec le corps
    var response = await crud.postData(AppLink.deleteFromCart, body);

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





  getCountCart(String usersid, String itemsid) async {
    // Construire l'URL en remplaçant les paramètres dans l'endpoint
    String url = AppLink.getCountProducts
        .replaceAll(':usersid', usersid)
        .replaceAll(':productsid', itemsid);

    // Effectuer la requête POST avec l'URL correcte
    var response = await crud.postData(url, {});

    // Gérer la réponse et retourner les résultats
    return response.fold((l) => l, (r) => r);
  }



  viewCart(String userId) async {
    // Remplace ':userid' par l'ID utilisateur réel dans l'URL
    String endpoint = AppLink.getCartDataByUserAndProduct.replaceFirst(':userid', userId);

    // Effectue une requête GET à l'endpoint modifié
    var response = await crud.getData(endpoint);

    // Gère la réponse
    return response.fold(
          (l) {
        // Ici, l est une erreur (par exemple : problème de connexion)
        print("Erreur lors de la récupération du panier : $l");
        return l;
      },
          (r) {
        // Ici, r est la réponse réussie du serveur
        return r;
      },
    );
  }









/**
  viewCart(String userId) async {
    // Remplace le paramètre dynamique par la valeur réelle de userId
    String endpoint = AppLink.getCartDataByUserAndProduct.replaceFirst(':userId', userId);

    // Effectue une requête GET au lieu de POST
    var response = await crud.getData(endpoint);

    return response.fold((l) => l, (r) => r);
  }
*/











}




