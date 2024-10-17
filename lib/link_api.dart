class AppLink {



  //static const String server = "http://localhost:4001";

 // static const String server = "http://192.168.147.207:4001";


// ================================= Auth ========================== //



 // static const String signUp = "$server/api/users/signup";
  static const String signUp = "api/users/signup";

  //static const String login = "$server/api/users/login";
  static const String login = "api/users/login";

 // static const String verfiyCodeSignUp = "$server/api/verifycode";
  static const String verfiyCodeSignUp = "api/verifycode";

  static const String resendVerfiyCode = "api/resend-verify-code";

  //verify_code
  // users_email
  //resend-verify-code



// ================================= ForgetPassword ========================== //

//  verfiy code if forget password

  static const String checkEmail = "api/check-email";


  static const String forget_password_verfiy_Code = "api/checkverifycode";
  static const String resetPassword  = "api/reset-password";






// ================================= home ========================== //


  static const String homePage = "api/home";


  // ================================= items  ========================== //


  static const String items = "api/product/products/category/:categoryId";



// ================================= favorite  ========================== //

  static const String favoriteAdd = "api/favorites/toggle";

  static const String favoriteRemove = "api/favorites/remove-favorite";

  static const String getAllfavorite = "api/favorites/:userId";

  static const String removeByIdfavorite = "api/favorites/:id";



  // /api/favorites/
//http://192.168.242.207:4002/api/favorites/toggle

 /* {




  "usersid": "6707407c09aac849e3f822d8",
  "productsid":"6708e642223288b3562710c8"


  }*/

// ================================= Cart  ========================== //

  static const String addToCart = "api/cart/add-to-cart";
  static const String deleteFromCart = "api/cart/delete-from-cart";

  static const String getCountProducts = "api/cart/get-count-products/:usersid/:productsid";

  static const String getCartDataByUserAndProduct = "api/cart/:userid/";



  ///api/cart

//{
//     "status": "success",
//     "message": "Le produit a été ajouté aux favoris avec succès"
// }







// static const String imageststatic = "https://waelabohamza.com/ecommerce/upload";
   //========================== Image ============================ 
   // static const String imagestCategories = "$imageststatic/categories";
   //   static const String imagestItems = "$imageststatic/items";
// =============================================================

    // ================================= home ========================== //

    //static const String home = "$server/api/home";




  // ================================= categories ========================== //


   
  //static const String createCategory = "$server/api/categories";
   // post

   //static const String getAllCategories = "$server/api/categories";
   // get  all

//  static const String getCategoryById = "$server/api/categories/:id";
  // get by id 

 // static const String  updateCategory = "$server/api/categories/:id";
  // put 

 // static const String  deleteCategory = "$server/api/categories/:id";
  // delete 





}