
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/address/add_details_controller.dart';
import 'package:user_app/core/class/handling_data_view.dart';
import 'package:user_app/core/shared/custom_button.dart';
import 'package:user_app/view/widget/auth/customtextformauth.dart';

class AddressAddDetails extends StatelessWidget {
  const AddressAddDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddAddressDetailsController controller =
    Get.put(AddAddressDetailsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('add details address'),
      ),
      body: Container(
          padding: EdgeInsets.all(15),
          child: GetBuilder<AddAddressDetailsController>(
            builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: ListView(children: [
                  CustomTextFormAuth(
                      hinttext: "city",
                      labeltext: "city",
                      iconData: Icons.location_city,
                      mycontroller: controller.city,
                      valid: (val) {},
                      isNumber: false),
                  CustomTextFormAuth(
                      hinttext: "street",
                      labeltext: "street",
                      iconData: Icons.streetview,
                      mycontroller: controller.street,
                      valid: (val) {},
                      isNumber: false),
                  CustomTextFormAuth(
                      hinttext: "name",
                      labeltext: "name",
                      iconData: Icons.near_me,
                      mycontroller: controller.name,
                      valid: (val) {},
                      isNumber: false),
                  CustomButton(
                    text: "Add",
                    onPressed: () {
                      controller.addAddress() ;
                    },
                  )
                ])),
          )),
    );
  }
}