import 'package:flavor_jet_food_delivery/pages/Splash/splash_screen.dart';
import 'package:flavor_jet_food_delivery/pages/address/add_address_page.dart';
import 'package:flavor_jet_food_delivery/pages/auth/log_in.dart';
import 'package:flavor_jet_food_delivery/pages/cart/cart_page.dart';
import 'package:flavor_jet_food_delivery/pages/detail/detail_page.dart';
import 'package:flavor_jet_food_delivery/pages/home/main_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../pages/detail/recommended_detail_page.dart';
import '../pages/home/home_page.dart';

class RouteHelper{
  static const String splashScreen= "/S_Screen";
  static const String initial= "/";
  static const String popularFood = "/P_Food";
  static const String recommendedFood = "/R_Food";
  static const String cartPage = "/Cart_P";
  static const String logIn = "/log_in";
  static const String addAddress = "/address";


  static String getPopularFood(int pageId,String page)=> '$popularFood?pageId=$pageId&cpage=$page';
  static String getRecommendedFood(int pageId,String page)=> '$recommendedFood?pageId=$pageId&cpage=$page';
  static String getCartPage()=> '$cartPage';
  static String getSplashScreen()=> '$splashScreen';
  static String getInitial()=> '$initial';
  static String getLogIn()=> '$logIn';
  static String getAddressPage()=> '$addAddress';

  static List<GetPage> routes = [

    // For HomeScreen...
    GetPage(name: initial, page: ()=> HomePage()),

    // For SplashScreen...
    GetPage(name: splashScreen, page: ()=> SplashScreen()),

    // For LoginScreen...
    GetPage(name: logIn, page: ()=> LogInPage(),transition: Transition.fade),

    // For PopularPage...
    GetPage(name: popularFood, page: (){
      var pageId = Get.parameters['pageId'];
      var cartp = Get.parameters['cpage'];
      return DetailPage(pageId: int.parse(pageId!), page: cartp!,);
  }, transition: Transition.fadeIn),

    // For RecommendedPage...
    GetPage(name: recommendedFood, page: (){
      var pageId = Get.parameters['pageId'];
      var cartp = Get.parameters['cpage'];
      return RecommendedDetailPage(pageId: int.parse(pageId!), page: cartp!,);
    }, transition: Transition.fadeIn),

    // For CartPage....
    GetPage(name: cartPage, page: (){
      return CartPage();
    }, transition: Transition.fadeIn),

    // For Address....
    GetPage(name: addAddress, page: (){
      return addAddressPage();
    }, transition: Transition.fadeIn),
  ];
}