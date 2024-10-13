/*
import 'package:get/get.dart';

class TestController extends GetxController {
  TestData testData = TestData(Get.find());

  List data = [];     // list pour stock data

  late StatusRequest statusRequest;

  getData() async {
    statusRequest = StatusRequest.loading;
    var response = await testData.getData();
    print("=============================== Controller $response ") ;
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {      // statusRequest  status return
      data.addAll(response['data']);
    }
    update();     // pour state refleche ui 
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}


 */