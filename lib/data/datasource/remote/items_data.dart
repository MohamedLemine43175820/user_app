import 'package:dartz/dartz.dart';
import 'package:user_app/core/class/crud.dart';
import 'package:user_app/core/class/status_request.dart';
import 'package:user_app/link_api.dart';

class ItemsData {
  final Crud crud;
  ItemsData(this.crud);

  Future<Either<StatusRequest, dynamic>> getData(String categoryId, {String? userId}) async {
    // Construire l'URL avec categoryId et userId comme paramètre de requête s'il est fourni
    String url = '${AppLink.items.replaceFirst(':categoryId', categoryId)}';

    // Ajouter userId à l'URL si non null
    if (userId != null) {
      url += '?userId=$userId';
    }

    // Effectuer la requête GET avec l'URL construite
    var response = await crud.getData(url);

    // Retourner la réponse avec Either
    return response.fold(
          (l) => Left(l), // En cas d'erreur
          (r) => Right(r), // Réponse réussie
    );
  }
}
