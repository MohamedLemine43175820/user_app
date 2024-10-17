
class CartModel {
  double? totalitemsprice;   // total price as double
  int? countitems;           // total count as int
  String? cartId;
  String? cartUsersid;
  String? cartItemsid;
  String? itemsId;
  String? itemsName;
  String? itemsNameAr;
  String? itemsDesc;
  String? itemsDescAr;
  String? itemsImage;
  int? itemsCount;           // item count as int
  bool? itemsActive;
  double? itemsPrice;        // item price as double
  double? itemsDiscount;     // item discount as double
  String? itemsCat;

  CartModel({
    this.totalitemsprice,
    this.countitems,
    this.cartId,
    this.cartUsersid,
    this.cartItemsid,
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
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    // Conversion sécurisée des types pour éviter les erreurs
    totalitemsprice = (json['totalprice'] is String)
        ? double.tryParse(json['totalprice']) ?? 0.0
        : (json['totalprice'] as num?)?.toDouble();

    countitems = (json['totalcount'] is String)
        ? int.tryParse(json['totalcount']) ?? 0
        : json['totalcount'] as int?;

    cartId = json['cart_id'];
    cartUsersid = json['cart_usersid'];
    cartItemsid = json['cart_productsid'];
    itemsId = json['product_id'];
    itemsName = json['products_name'];
    itemsNameAr = json['products_name_ar'];
    itemsDesc = json['products_desc'];
    itemsDescAr = json['products_desc_ar'];
    itemsImage = json['products_image'];

    itemsCount = (json['products_count'] is String)
        ? int.tryParse(json['products_count']) ?? 0
        : json['products_count'] as int?;

    itemsActive = json['products_active'] as bool?;

    itemsPrice = (json['products_price'] is String)
        ? double.tryParse(json['products_price']) ?? 0.0
        : (json['products_price'] as num?)?.toDouble();

    itemsDiscount = (json['products_discount'] is String)
        ? double.tryParse(json['products_discount']) ?? 0.0
        : (json['products_discount'] as num?)?.toDouble();

    itemsCat = json['products_cat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalprice'] = this.totalitemsprice;
    data['totalcount'] = this.countitems;
    data['cart_id'] = this.cartId;
    data['cart_usersid'] = this.cartUsersid;
    data['cart_productsid'] = this.cartItemsid;
    data['product_id'] = this.itemsId;
    data['products_name'] = this.itemsName;
    data['products_name_ar'] = this.itemsNameAr;
    data['products_desc'] = this.itemsDesc;
    data['products_desc_ar'] = this.itemsDescAr;
    data['products_image'] = this.itemsImage;
    data['products_count'] = this.itemsCount;
    data['products_active'] = this.itemsActive;
    data['products_price'] = this.itemsPrice;
    data['products_discount'] = this.itemsDiscount;
    data['products_cat'] = this.itemsCat;
    return data;
  }
}




























/*

class CartModel {
  String? totalitemsprice;            //total price
  String? countitems;           // total count
  String? cartId;
  String? cartUsersid;
  String? cartItemsid;
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
  //String? itemsDate;
  String? itemsCat;

  CartModel(
      {this.totalitemsprice,
        this.countitems,
       this.cartId,
       this.cartUsersid,
        this.cartItemsid,
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
       // this.itemsDate,
        this.itemsCat});

  CartModel.fromJson(Map<String, dynamic> json) {
    totalitemsprice = json['totalprice'];                       // pas encore
    countitems = json['totalcount'];                      // pas encore
   cartId = json['cart_id'];                                 // cart id
    cartUsersid = json['cart_usersid'];
    cartItemsid = json['cart_productsid'];
    itemsId = json['product_id'];                               // pas encore
    itemsName = json['products_name'];
    itemsNameAr = json['products_name_ar'];
    itemsDesc = json['products_desc'];
    itemsDescAr = json['products_desc_ar'];
    itemsImage = json['products_image'];
    itemsCount = json['products_count'];
    itemsActive = json['products_active'];
    itemsPrice = json['products_price'];
    itemsDiscount = json['products_discount'];
   // itemsDate = json['items_date'];
    itemsCat = json['products_cat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalprice'] = this.totalitemsprice;      // pas encore
    data['totalcount'] = this.countitems;        // pas encore
    data['cart_id'] = this.cartId;
    data['cart_usersid'] = this.cartUsersid;
    data['cart_productsid'] = this.cartItemsid;
    data['product_id'] = this.itemsId;      // pas encore
    data['products_name'] = this.itemsName;
    data['products_name_ar'] = this.itemsNameAr;
    data['products_desc'] = this.itemsDesc;
    data['products_desc_ar'] = this.itemsDescAr;
    data['products_image'] = this.itemsImage;
    data['products_count'] = this.itemsCount;
    data['products_active'] = this.itemsActive;
    data['products_price'] = this.itemsPrice;
    data['products_discount'] = this.itemsDiscount;
   // data['items_date'] = this.itemsDate;
    data['products_cat'] = this.itemsCat;
    return data;
  }
}


 */