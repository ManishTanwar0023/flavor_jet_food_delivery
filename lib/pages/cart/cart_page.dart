
import 'package:flavor_jet_food_delivery/base/no_data_page.dart';
import 'package:flavor_jet_food_delivery/controllers/auth_Controller.dart';
import 'package:flavor_jet_food_delivery/controllers/cartController.dart';
import 'package:flavor_jet_food_delivery/controllers/location_Controller.dart';
import 'package:flavor_jet_food_delivery/controllers/productController.dart';
import 'package:flavor_jet_food_delivery/controllers/recommended_productController.dart';
import 'package:flavor_jet_food_delivery/widgets/appbar_icons.dart';
import 'package:flavor_jet_food_delivery/widgets/big_text.dart';
import 'package:flavor_jet_food_delivery/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../utils/appColor.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Positioned(
            left: Dimensions.width20,
              right: Dimensions.width20,
              top: Dimensions.height20*3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBarIcons(icon: Icons.arrow_back_ios,
              iconColor: Colors.white,
              backgroundColor: AppColors.mainColor,
              iconSize: Dimensions.icon24,onTap: (){

                },),
              SizedBox(width: Dimensions.width20*3,),
              AppBarIcons(icon: Icons.home_outlined,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              iconSize: Dimensions.icon24,
              onTap: (){
                Get.toNamed(RouteHelper.getInitial());
              },),
              AppBarIcons(icon: Icons.shopping_cart_outlined,
                iconColor: Colors.white,
                backgroundColor: AppColors.mainColor,
                iconSize: Dimensions.icon24,onTap: (){

                },),
            ],
          )
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?Positioned(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20*5,
                bottom: 0,
                child:Container(
                  // color: AppColors.mainColor,
                  margin: EdgeInsets.only(top: Dimensions.height20),
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(builder: (controller) {
                        var _cartList = controller.getItems;
                        return ListView.builder(
                            itemCount: _cartList.length,
                            itemBuilder: (_,index){
                              return Container(
                                height: Dimensions.height20*5,
                                width: double.maxFinite,
                                // color: Colors.black38,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                    color: Colors.black38,
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(onTap:(){
                                        var popularIdx = Get.find<ProductController>().productList.indexOf(_cartList[index].product!);
                                        if(popularIdx>=0){
                                          Get.toNamed(RouteHelper.getPopularFood(popularIdx,"cartPage"));
                                        }else{
                                          var recommendeIdx = Get.find<Recommended_ProductController>().recommended_productList.indexOf(_cartList[index].product!);
                                          if(recommendeIdx<0){
                                            Get.snackbar("History Product", "Product review is not available for history products!",
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                            );
                                          }else{
                                            Get.toNamed(RouteHelper.getRecommendedFood(recommendeIdx,"cartPage"));
                                          }
                                        }
                                      },
                                        child: Container(
                                          height: Dimensions.height20*5,
                                          width: Dimensions.width20*5,
                                          // margin: EdgeInsets.only(bottom: Dimensions.height10),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(AppConstants.BASE_URL+"/"+controller.getItems[index].image!),),
                                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                                              color: Colors.black26
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.width10,),
                                      Expanded(
                                          child: Container(
                                            height: Dimensions.height20*5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(text: controller.getItems[index].name!,color: Colors.black54,),
                                                SmallText(text: 'Food',color: Colors.black54,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    BigText(text: '\u20B9 ${controller.getItems[index].price.toString()}',color: Colors.redAccent,),
                                                    Container(
                                                      // height: Dimensions.height40,
                                                      // width: Dimensions.width120,
                                                      margin: EdgeInsets.only(right: Dimensions.width10),
                                                      // padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height20),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(Dimensions.radius10),
                                                          color: AppColors.mainColor
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          IconButton(onPressed: (){
                                                            controller.addItem(_cartList[index].product!, -1);
                                                          }, icon: Icon(Icons.remove,color: Colors.white,size: Dimensions.height20,)),
                                                          SizedBox(width: Dimensions.width10/2,),
                                                          BigText(text: _cartList[index].quantity.toString(),color: Colors.white,), // PC.inCartItems.toString()),
                                                          SizedBox(width: Dimensions.width10/2,),
                                                          IconButton(onPressed: (){
                                                            controller.addItem(_cartList[index].product!, 1);
                                                          }, icon: Icon(Icons.add,color: Colors.white,size: Dimensions.height20,)),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            });
                      },)
                  ),
                )
            ):NoDataPage(text: "Your Cart Is Empty!");
          }),
        ],
      ),
        bottomNavigationBar:GetBuilder<CartController>(builder: (CC){
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
            child: CC.getItems.length>0?Padding(
              padding:  EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        SizedBox(width: Dimensions.width10/2,),
                        BigText(text:"\u20B9 ${ CC.totalAmount.toString()}"),
                        SizedBox(width: Dimensions.width10/2,),
                      ],
                    ),
                  ),
                  InkWell(onTap: (){
                    if(Get.find<AuthController>().userLoggedIn()){

                      if(Get.find<LocationController>().addressList.isEmpty){
                         Get.toNamed(RouteHelper.getAddressPage());
                      }
                      // else{
                      //   CC.addToHistory();
                      // }

                    }else{
                      Get.toNamed(RouteHelper.getLogIn());
                    }

                  },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor
                      ),
                      child: BigText(text: "Check out",color: Colors.white60,),
                    ),
                  )
                ],
              ),
            ):Container()
          );
        },)
    );
  }
}





