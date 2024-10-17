import 'dart:convert';

import 'package:dartz/dartz.dart';  // Package pour Either
import 'package:dio/dio.dart';
import 'package:user_app/core/class/status_request.dart';



class Crud {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.17.207:4002/',          // Remplace par ton adresse IP backend
        receiveDataWhenStatusError: true,
      ),
    );
  }

  // Fonction POST
  Future<Either<StatusRequest, Map>> postData(
      String url,
      Map<String, dynamic> data

      ) async {
    try {

      Response response = await dio.post(
          url,
          data: data

      );

      if (response.statusCode == 200 || response.statusCode == 201) {

        //Map responseBody = jsonDecode(response.data);
        Map responseBody = response.data;  // Pas besoin de jsonDecode
        print(responseBody);

        return Right(responseBody); //    En cas de succès

      } else {
        return Left(StatusRequest.serverfailure);               // En cas de problème serveur
      }
    } catch (e) {
      print('Error: $e');
      return Left(StatusRequest.serverException);    // Erreur
    }
  }

  // Fonction GET
  Future<Either<StatusRequest, Map>> getData(String url ) async {
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      print('Error: $e');
      return Left(StatusRequest.offlinefailure);
    }
  }


  // Fonction PUT
  Future<Either<StatusRequest, Map>> putData(String url, Map<String, dynamic> data) async {
    try {
      Response response = await dio.put(url, data: data);
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      print('Error: $e');
      return Left(StatusRequest.offlinefailure);
    }
  }

  // Fonction PATCH
  Future<Either<StatusRequest, Map>> patchData(String url, Map<String, dynamic> data) async {
    try {
      Response response = await dio.patch(url, data: data);
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      print('Error: $e');
      return Left(StatusRequest.offlinefailure);
    }
  }

  // Fonction DELETE
  Future<Either<StatusRequest, Map>> deleteData(String url) async {
    try {
      Response response = await dio.delete(url);
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      print('Error: $e');
      return Left(StatusRequest.offlinefailure);
    }
  }
}
 