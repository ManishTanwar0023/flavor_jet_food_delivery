import 'dart:async';

import 'package:flavor_jet_food_delivery/pages/auth/log_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/productController.dart';
import '../../controllers/recommended_productController.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;
  Future<void> _loadResources() async {
    await Get.find<ProductController>().getProductList();
    await Get.find<Recommended_ProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
    controller = AnimationController(vsync: this,duration: Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
        const Duration(seconds: 4),
            ()=>Get.offNamed(RouteHelper.getInitial()));
    // ()=>Get.to(()=>LogInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
          child: Center(child: Image(image: AssetImage('assets/images/logo.png'),
            width: Dimensions.width250,)))
        ],
      ),
    );
  }
}
