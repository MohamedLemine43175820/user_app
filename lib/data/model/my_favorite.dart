class MyFavoriteModel {
  String? favoriteId;
  String? favoriteUsersid;
  String? favoriteItemsid;
  String? itemsId;
  String? itemsName;
  String? itemsNameAr;
  String? itemsDesc;
  String? itemsDescAr;
  String? itemsImage;
  String? itemsCount;
  String? itemsActive;
  String? itemsPrice;
  String? itemsDiscount;
  String? itemsCat;
  String? usersId;

  MyFavoriteModel({
    this.favoriteId,
    this.favoriteUsersid,
    this.favoriteItemsid,
    this.itemsId,
    this.itemsName,
    this.itemsNameAr,
    this.itemsDesc,
    this.itemsDescAr,
    this.itemsImage,
    this.itemsCount,
    this.itemsActive,
    this.itemsPrice,
    this.itemsDiscount,
    this.itemsCat,
    this.usersId,
  });

  MyFavoriteModel.fromJson(Map<String, dynamic> json) {
    favoriteId = json['_id']?.toString(); // Conversion en String si nécessaire
    favoriteUsersid = json['favorite_usersid']?.toString();
    favoriteItemsid = json['favorite_productsid']?.toString();
    itemsId = json['product_id']?.toString();
    itemsName = json['products_name']?.toString();
    itemsNameAr = json['products_name_ar']?.toString();
    itemsDesc = json['products_desc']?.toString();
    itemsDescAr = json['products_desc_ar']?.toString();
    itemsImage = json['products_image']?.toString();
    itemsCount = json['products_count']?.toString();
    itemsActive = json['products_active']?.toString();
    itemsPrice = json['products_price']?.toString();
    itemsDiscount = json['products_discount']?.toString();
    itemsCat = json['products_cat']?.toString();
    usersId = json['user_id']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = favoriteId;
    data['favorite_usersid'] = favoriteUsersid;
    data['favorite_productsid'] = favoriteItemsid;
    data['product_id'] = itemsId;
    data['products_name'] = itemsName;
    data['products_name_ar'] = itemsNameAr;
    data['products_desc'] = itemsDesc;
    data['products_desc_ar'] = itemsDescAr;
    data['products_image'] = itemsImage;
    data['products_count'] = itemsCount;
    data['products_active'] = itemsActive;
    data['products_price'] = itemsPrice;
    data['products_discount'] = itemsDiscount;
    data['products_cat'] = itemsCat;
    data['user_id'] = usersId;
    return data;
  }
}
