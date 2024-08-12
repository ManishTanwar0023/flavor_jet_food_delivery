import 'package:flavor_jet_food_delivery/controllers/productController.dart';
import 'package:flavor_jet_food_delivery/controllers/recommended_productController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:badges/badges.dart' as badges;

import '../../controllers/cartController.dart';
import '../../routes/route_helper.dart';
import '../../utils/appColor.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/appbar_icons.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text.dart';

class RecommendedDetailPage extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedDetailPage({required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product = Get.find<Recommended_ProductController>().recommended_productList[pageId];
    Get.find<ProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimensions.height80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBarIcons(
                  icon: Icons.clear,
                  size: Dimensions.height40,
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
                        style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),): null,
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
            bottom: PreferredSize(preferredSize: Size.fromHeight(Dimensions.height20),
                child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: Dimensions.height5,bottom: Dimensions.height20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20),
                      ),
                      color: Colors.white,
                    ),
                    child: Center(child: BigText(text: product.name!,size: Dimensions.font26,)))
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: Dimensions.height300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(AppConstants.BASE_URL+"/"+product.image!),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal:Dimensions.width20),
                    child: ExpandableText(text: product.description!,)),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<ProductController>(builder: (PC){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20*2.5,
                  right: Dimensions.width20*2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10
              ),
              child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppBarIcons(icon: Icons.remove,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.icon24,
                    onTap: (){
                      PC.setQuantity(false);
                    },
                  ),
                  BigText(text: "\u20B9 ${product.price!} x ${PC.inCartItems}",
                    color: AppColors.mainBlackColor,
                    size: Dimensions.font22,),
                  AppBarIcons(icon: Icons.add,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.icon24,
                    onTap: (){
                      PC.setQuantity(true);
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: Dimensions.height10,),
            Container(
              height: Dimensions.height100,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20*2),
                    topRight: Radius.circular(Dimensions.radius20*2),
                  ),
                  color: AppColors.buttonBackgroundColor

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: Dimensions.height80,
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white
                      ),
                      child: Center(
                        child: IconButton(onPressed: (){}, icon: Icon(Icons.favorite,
                          color: AppColors.mainColor,
                          size: Dimensions.icon28,
                        )),
                      )
                  ),
                  InkWell(onTap: (){
                    PC.addItem(product);
                  },
                    child: Container(
                      height: Dimensions.height80,
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor
                      ),
                      child: BigText(text: "\u20B9 ${product.price!} | Add to Cart",color: Colors.white60,),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      })
    );
  }
}
