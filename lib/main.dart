import 'package:flavor_jet_food_delivery/controllers/cartController.dart';
import 'package:flavor_jet_food_delivery/pages/Splash/splash_screen.dart';
import 'package:flavor_jet_food_delivery/pages/auth/log_in.dart';
import 'package:flavor_jet_food_delivery/pages/auth/sign_up.dart';
import 'package:flavor_jet_food_delivery/pages/cart/cart_page.dart';
import 'package:flavor_jet_food_delivery/pages/home/main_page.dart';
import 'package:flavor_jet_food_delivery/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'controllers/productController.dart';
import 'controllers/recommended_productController.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<ProductController>(builder: (_){
      return GetBuilder<Recommended_ProductController>(builder: (_){
        return GetMaterialApp(
          title: 'Flutter Demo',
           initialRoute: RouteHelper.getSplashScreen(),
            getPages: RouteHelper.routes,
          debugShowCheckedModeBanner: false,
            // home:  LogInPage(),
        );
      });
    });
  }
}