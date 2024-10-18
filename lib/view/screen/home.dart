
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/home_controller.dart';
import 'package:user_app/core/class/handling_data_view.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/data/model/items_model.dart';
import 'package:user_app/link_api.dart';
import 'package:user_app/view/widget/home/custom_app_bar.dart';
import 'package:user_app/view/widget/home/custom_card_home.dart';
import 'package:user_app/view/widget/home/custom_title_home.dart';
import 'package:user_app/view/widget/home/list_categories_home.dart';
import 'package:user_app/view/widget/home/list_items_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return GetBuilder<HomeControllerImp>(
        builder: (controller) =>  Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  children: [
                    CustomAppBar(
                      mycontroller: controller.search!,
                        titleappbar: "Find Product",
                        onPressedIcon: () {},
                        onPressedSearch: () {

                        controller.onSearchItems();
                        },
                      onChanged: (val) {
                        controller.checkSearch(val);
                      },

                      onPressedIconFavorite: (){
                       Get.toNamed(AppRoute.myfavroite) ;
                      },

                    ),
            HandlingDataView(
              statusRequest: controller.statusRequest,
              widget:!controller.isSearch ?  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CustomCardHome(
                      title: "A summer surprise", body: "Cashback 20%"),
                  CustomTitleHome(title: "Categories"),
                  ListCategoriesHome(),
                  CustomTitleHome(title: "Product for you"),
                  ListItemsHome(),
                  CustomTitleHome(title: "Offer"),
                  ListItemsHome(),
                ],
              ): ListItemsSearch(listdatamodel:controller.listdata ,) )

                  ],
                )
            )


    );
  }
}


class ListItemsSearch extends GetView<HomeControllerImp> {
  final List<ItemsModel> listdatamodel;

  const ListItemsSearch({Key? key, required this.listdatamodel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Vérification si la liste est vide
    if (listdatamodel.isEmpty) {
      return Center(child: Text('Aucun produit trouvé.'));
    }

    return ListView.builder(
      itemCount: listdatamodel.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        // Vérification de la nullité avant d'accéder aux propriétés
        final item = listdatamodel[index];

        return InkWell(
          onTap: () {
            controller.goToPageProductDetails(item);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Image.network(
                        item.itemsImage ?? '', // Utiliser une chaîne vide si null
                        errorBuilder: (context, error, stackTrace) {
                          return Center(child: Text('Image non disponible'));
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ListTile(
                        title: Text(item.itemsName ?? 'Nom du produit non disponible'), // Gérer le cas où itemsName est null
                        subtitle: Text(item.categoriesName ?? 'Catégorie non disponible'), // Gérer le cas où categoriesName est null
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}







