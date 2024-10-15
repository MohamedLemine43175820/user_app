import 'package:dartz/dartz.dart';
import 'package:user_app/core/class/crud.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/link_api.dart';

class MyFavoriteData {
  Crud crud;

  MyFavoriteData(this.crud);

  getData(String userId) async {
    // Remplace le paramètre dynamique par la valeur réelle de userId
    String endpoint = AppLink.getAllfavorite.replaceFirst(':userId', userId);

    // Effectue une requête GET au lieu de POST
    var response = await crud.getData(endpoint);

    return response.fold((l) => l, (r) => r);
  }

  Future<Either<StatusRequest, Map>> deleteData(String id) async {
    try {
      // Remplace :id par la valeur réelle de l'ID
      var response = await crud.deleteData("${AppLink.removeByIdfavorite.replaceFirst(':id', id)}");
      return response.fold((l) => Left(l), (r) => Right(r));
    } catch (e) {
      // Gérer d'autres erreurs éventuelles ici
      print("Erreur lors de la suppression : $e");
      return Left(StatusRequest.offlinefailure);
    }
  }




}
