
import 'package:flavor_jet_food_delivery/controllers/auth_Controller.dart';
import 'package:flavor_jet_food_delivery/controllers/location_Controller.dart';
import 'package:flavor_jet_food_delivery/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/cartController.dart';
import '../controllers/productController.dart';
import '../controllers/recommended_productController.dart';
import '../controllers/user_Controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/cart_repository.dart';
import '../data/repository/locaton_repository.dart';
import '../data/repository/product_repository.dart';
import '../data/repository/rcommended_product_repository.dart';
import '../data/repository/user_repository.dart';
import '../utils/app_constants.dart';

Future<void> init() async{

  final sharedPreferences = await SharedPreferences.getInstance();

  // SharedPreferences
   Get.lazyPut(()=> sharedPreferences);
  // Api Client
  Get.lazyPut(()=> ApiClient(appBaseUrl: AppConstants.BASE_URL,sharedPreferences:Get.find()));
  // Repository
  Get.lazyPut(()=> ProductRepository(apiClient: Get.find()));
  Get.lazyPut(()=> RecommendedProductRepository(apiClient: Get.find()));
  Get.lazyPut(()=> CartRepository(SP: Get.find()));
  Get.lazyPut(()=> AuthRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(()=> UserRepo(apiClient: Get.find()));
  Get.lazyPut(()=> LocationRepo(apiClient: Get.find(),sharedPreferences: Get.find()));
  // Controller
  Get.lazyPut(()=> ProductController(productRepository: Get.find()));
  Get.lazyPut(()=> Recommended_ProductController(recommendedproductRepository: Get.find()));
  Get.lazyPut(()=> CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  
}