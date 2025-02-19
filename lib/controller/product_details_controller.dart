
import 'package:get/get.dart';
import 'package:user_app/data/model/items_model.dart';

abstract class ProductDetailsController extends GetxController {}

class ProductDetailsControllerImp extends ProductDetailsController {
  late ItemsModel itemsModel;

  intialData() {
    itemsModel = Get.arguments['itemsmodel'];
  }

  List subitems = [
    {"name": "red", "id": 1, "active": '0'},
    {"name": "yallow", "id": 2, "active": '0'},
    {"name": "black", "id": 3, "active": '1'}
  ];

  @override
  void onInit() {
    intialData();
    super.onInit();
  }
}