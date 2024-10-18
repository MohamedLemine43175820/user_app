
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/product_details_controller.dart';
import 'package:user_app/core/class/handling_data_view.dart';
import 'package:user_app/core/constant/color.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/view/widget/product_details/price_and_count.dart';
import 'package:user_app/view/widget/product_details/sub_items_list.dart';
import 'package:user_app/view/widget/product_details/top_page_product_details.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductDetailsControllerImp controller =
    Get.put(ProductDetailsControllerImp());
    return Scaffold(
        bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 40,
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: AppColor.secondColor,
                onPressed: () {

                 // controller.cartController.refreshPage();
                  
                  Get.toNamed(AppRoute.cart);
                },
                child: const Text(
                  "Go To Cart",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))),
        body: GetBuilder<ProductDetailsControllerImp>(
          builder: (controller)=> HandlingDataView(
              statusRequest:controller.statusRequest,
              widget: ListView(children: [
          const TopProductPageDetails(),
          const SizedBox(
            height: 100,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${controller.itemsModel.itemsName}",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: AppColor.fourthColor,
                  )),
              const SizedBox(height: 10),
              PriceAndCountItems(
                  onAdd: () {
                  //  controller.cartController.add(controller.itemsModel.itemsId!);
                        controller.add();
                  },
                  onRemove: () {
                   // controller.cartController.delete(controller.itemsModel.itemsId!);
                    controller.remove();

                  },
                  price: "${controller.itemsModel.itemsPriceDiscount}",
                  count: "${controller.countitems}"
                //  count: "2"

              ),
              const SizedBox(height: 10),
              Text("${controller.itemsModel.itemsDesc}",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: AppColor.grey2)),
              const SizedBox(height: 10),
              /* Text("Color",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: AppColor.fourthColor,
                  )),
              const SizedBox(height: 10),
              const SubitemsList()*/
            ]),
          )
        ]))));
  }
}