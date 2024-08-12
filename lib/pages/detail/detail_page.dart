import 'package:flavor_jet_food_delivery/controllers/cartController.dart';
import 'package:flavor_jet_food_delivery/controllers/productController.dart';
import 'package:flavor_jet_food_delivery/pages/detail/recommended_detail_page.dart';
import 'package:flavor_jet_food_delivery/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:badges/badges.dart' as badges;

import '../../routes/route_helper.dart';
import '../../utils/appColor.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/appbar_icons.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text.dart';

class DetailPage extends StatelessWidget {
  int pageId;
  final String page;
   DetailPage({required this.pageId,required this.page});

  @override
  Widget build(BuildContext context) {
   var product = Get.find<ProductController>().productList[pageId];
   Get.find<ProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: Dimensions.detail_page_ImageSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(AppConstants.BASE_URL+"/"+product.image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // AppBar Icons
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBarIcons(
                  icon: Icons.arrow_back_ios,
                  onTap: () {
                    if(page == 'cartPage'){
                      Get.toNamed(RouteHelper.getCartPage());
                    }else{
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },
                ),
                GetBuilder<ProductController>(
                  builder: (PC) {
                    bool hasItemsInCart = PC.totalItems >= 1;
                    return badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -14, end: -4),
                      showBadge: hasItemsInCart,
                      ignorePointer: false,
                      badgeContent:hasItemsInCart? Text(PC.totalItems.toString(),
                           style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),):null,
                      badgeAnimation: badges.BadgeAnimation.slide(
                        animationDuration: Duration(seconds: 1),
                        colorChangeAnimationDuration: Duration(seconds: 1),
                        loopAnimation: false,
                        curve: Curves.bounceIn,
                        colorChangeAnimationCurve: Curves.easeInCubic,
                      ),
                      badgeStyle: badges.BadgeStyle(
                        shape: badges.BadgeShape.circle,
                        badgeColor: AppColors.mainColor,
                        padding: EdgeInsets.all(5),
                        elevation: 0,
                      ),
                      child: AppBarIcons(
                        icon: Icons.shopping_cart_outlined,
                        onTap: () {
                         // if(hasItemsInCart)
                          Get.toNamed(RouteHelper.getCartPage());
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Detail Content
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.detail_page_ImageSize - 20,
            child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.width20),
                    topLeft: Radius.circular(Dimensions.width20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                        bigText: product.name!,
                        smallText: "With Chinese Characteristics"
                    ),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimensions.height20,),
                    Expanded(child: SingleChildScrollView(child: ExpandableText(text: product.description!))),
                  ],
                )
            ),
          ),
        ],
      ),
      bottomNavigationBar:GetBuilder<ProductController>(builder: (PC){
        return Container(
          height: Dimensions.height120,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20*2),
                topRight: Radius.circular(Dimensions.radius20*2),
              ),
              color: AppColors.buttonBackgroundColor

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                // width: Dimensions.width120,
                // padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white
                ),
                child: Row(
                children: [
                  IconButton(onPressed: (){
                    PC.setQuantity(false);
                  }, icon: Icon(Icons.remove,color: AppColors.signColor,)),
                  SizedBox(width: Dimensions.width10/2,),
                  BigText(text: PC.inCartItems.toString()),
                  SizedBox(width: Dimensions.width10/2,),
                  IconButton(onPressed: (){
                    PC.setQuantity(true);
                  }, icon: Icon(Icons.add,color: AppColors.signColor,)),
                ],
              ),
              ),
              InkWell(onTap: (){
                PC.addItem(product);
              },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                  ),
                  child: BigText(text: "\u20B9${product.price!} | Add to Cart",color: Colors.white60,),
                ),
              )
            ],
          ),
        );
      },)
    );
  }
}
