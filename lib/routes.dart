
import 'package:get/get.dart';
import 'package:user_app/core/constant/routes.dart';
import 'package:user_app/core/middleware/mymiddleware.dart';
import 'package:user_app/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:user_app/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:user_app/view/screen/auth/forgetpassword/success_resetpassword.dart';
import 'package:user_app/view/screen/auth/forgetpassword/verifycode.dart';
import 'package:user_app/view/screen/auth/login.dart';
import 'package:user_app/view/screen/auth/signup.dart';
import 'package:user_app/view/screen/auth/success_signup.dart';
import 'package:user_app/view/screen/auth/verifycodesignup.dart';
import 'package:user_app/view/screen/cart.dart';
import 'package:user_app/view/screen/home.dart';
import 'package:user_app/view/screen/home_screen.dart';
import 'package:user_app/view/screen/items.dart';
import 'package:user_app/view/screen/items.dart';
import 'package:user_app/view/screen/language.dart';
import 'package:user_app/view/screen/my_favorite.dart';
import 'package:user_app/view/screen/onboarding.dart';
import 'package:user_app/view/screen/product_details.dart';

List<GetPage<dynamic>>? routes = [
//  GetPage(  name: "/", page: () => const Language(), middlewares: [MyMiddleWare()]),
  GetPage(name: "/", page: () => Cart()),
  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.signUp, page: () => const SignUp()),
  GetPage(name: AppRoute.forgetPassword, page: () => const ForgetPassword()),
  GetPage(name: AppRoute.verfiyCode, page: () => const VerfiyCode()),
  GetPage(name: AppRoute.resetPassword, page: () => const ResetPassword()),
  GetPage(name: AppRoute.successResetpassword, page: () => const SuccessResetPassword()),
  GetPage(name: AppRoute.successSignUp, page: () => const SuccessSignUp()),
  GetPage(name: AppRoute.onBoarding, page: () => const OnBoarding()),
  GetPage(name: AppRoute.verfiyCodeSignUp, page: () => const VerfiyCodeSignUp()),
  // home
  //GetPage(name: AppRoute.homepage, page: () => const HomePage()),
  GetPage(name: AppRoute.homepage, page: () => const HomeScreen()),
  GetPage(name: AppRoute.items, page: () => const Items()),
 GetPage(name: AppRoute.productdetails, page: () => const ProductDetails()),
 GetPage(name: AppRoute.myfavroite, page: () => const MyFavorite()),


];
 