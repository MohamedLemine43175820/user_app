class ItemsModel {
  String? itemsId;
  String? itemsName;
  String? itemsNameAr;      // Ajouté pour le nom en arabe
  String? itemsDesc;
  String? itemsDescAr;      // Ajouté pour la description en arabe
  String? itemsImage;
  int? itemsCount;
  bool? itemsActive;
  double? itemsPrice;
  double? itemsDiscount;
  String? categoriesId;
  String? categoriesName;
  String? categoriesNameAr;
  String? categoriesImage;
  bool? favorite ;

  ItemsModel({
    this.itemsId,
    this.itemsName,
    this.itemsNameAr,       // Ajouté ici
    this.itemsDesc,
    this.itemsDescAr,       // Ajouté ici
    this.itemsImage,
    this.itemsCount,
    this.itemsActive,
    this.itemsPrice,
    this.itemsDiscount,
    this.categoriesId,
    this.categoriesName,
    this.categoriesNameAr,
    this.categoriesImage,
    this.favorite  });

  ItemsModel.fromJson(Map<String, dynamic> json) {
    itemsId = json['_id'];
    itemsName = json['products_name'];
    itemsNameAr = json['products_name_ar'];       // Ajouté ici
    itemsDesc = json['products_desc'];
    itemsDescAr = json['products_desc_ar'];       // Ajouté ici
    itemsImage = json['products_image'];
    itemsCount = json['products_count']?.toInt();
    itemsActive = json['products_active'] == true;
    itemsPrice = json['products_price']?.toDouble();
    itemsDiscount = json['products_discount']?.toDouble();
    categoriesId = json['categories_id'];
    categoriesName = json['categories_name'];
    categoriesNameAr = json['categories_name_ar'];
    categoriesImage = json['categories_image'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': itemsId,
      'products_name': itemsName,
      'products_name_ar': itemsNameAr,          // Ajouté ici
      'products_desc': itemsDesc,
      'products_desc_ar': itemsDescAr,          // Ajouté ici
      'products_image': itemsImage,
      'products_count': itemsCount,
      'products_active': itemsActive,
      'products_price': itemsPrice,
      'products_discount': itemsDiscount,
      'categories_id': categoriesId,
      'categories_name': categoriesName,
      'categories_name_ar': categoriesNameAr,
      'categories_image': categoriesImage,
      'favorite': favorite,
    };
  }
}
