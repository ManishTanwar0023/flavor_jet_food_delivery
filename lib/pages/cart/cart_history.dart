

import 'dart:convert';

import 'package:flavor_jet_food_delivery/base/no_data_page.dart';
import 'package:flavor_jet_food_delivery/controllers/cartController.dart';
import 'package:flavor_jet_food_delivery/routes/route_helper.dart';
import 'package:flavor_jet_food_delivery/utils/appColor.dart';
import 'package:flavor_jet_food_delivery/widgets/big_text.dart';
import 'package:flavor_jet_food_delivery/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/cart_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {

    var getCartHistoryList = Get.find<CartController>().
    getCartHistoryList().reversed.toList();
    Map<String , int> cartItemsPerOrder = Map();

    for(int i=0; i<getCartHistoryList.length; i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }
    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;

    Widget  timeWidget(int index){
      var outPutDate = DateTime.now().toString();
      if(index<getCartHistoryList.length){
       DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
       var inPutDate = DateTime.parse(parseDate.toString());
       var outPutFormat = DateFormat("MM/dd/yyyy  hh:mm a");
       outPutDate = outPutFormat.format(inPutDate);
     }
     return BigText(text: outPutDate,);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: Dimensions.height100,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                children: [
                  BigText(text: "Cart History",color: Colors.white,),
                  Icon(Icons.shopping_cart_outlined,color: Colors.white,size: Dimensions.icon26,)
                ],
              ),
            ),
          ),
          GetBuilder<CartController>(builder: (_cartCont){
           return _cartCont.getCartHistoryList().isNotEmpty?
           Expanded(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20
                ),
                child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      children: [
                        for(int i=0; i<itemsPerOrder.length; i++)
                          Container(
                            height: Dimensions.height120,
                            margin: EdgeInsets.only(bottom: Dimensions.height20),
                            child: Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                timeWidget(listCounter),
                                SizedBox(height: Dimensions.height10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                        direction: Axis.horizontal,
                                        children: List.generate(itemsPerOrder[i], (index) {
                                          if(listCounter<getCartHistoryList.length){
                                            listCounter++;
                                          }
                                          return index<=2?
                                          Container(
                                              height: Dimensions.height50,
                                              width: Dimensions.width50,
                                              margin: EdgeInsets.only(right: Dimensions.width5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(AppConstants.BASE_URL+"/"+getCartHistoryList[listCounter-1].image!),),
                                              )
                                          ):
                                          Padding(
                                            padding: EdgeInsets.only(top: Dimensions.height30),
                                            child: Text("..."),
                                          );
                                        })
                                    ),
                                    Container(
                                      height: Dimensions.height80,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SmallText(text: "Total",color: AppColors.titleColor,),
                                          BigText(text: "Items: ${itemsPerOrder[i].toString()}",color: AppColors.titleColor,),
                                          InkWell(onTap: (){
                                            var orderTime = cartOrderTimeToList();
                                            Map<int, CartModel> moreOrder ={};
                                            for(int j=0; j<getCartHistoryList.length; j++){
                                              if(getCartHistoryList[j].time == orderTime[i]){
                                                //  print("The Cart or Product Id is: "+getCartHistoryList[j].id.toString());
                                                moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                    CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                );
                                              }
                                            }

                                            Get.find<CartController>().setItems = moreOrder;
                                            Get.find<CartController>().addToCartList();
                                            Get.toNamed(RouteHelper.getCartPage());
                                          },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.height10/2),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                                border: Border.all(width: 1,color: AppColors.mainColor),
                                              ),
                                              child: SmallText(text: "One More",color: AppColors.mainColor,),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],)
                              ],
                            ),
                          )
                      ],
                    )),
              ),
            ):
           SizedBox(
             height: MediaQuery.of(context).size.height/1.5,
               child:const Center(child:NoDataPage(text: "You Didn't Buy anything so far!",imgPath: "assets/images/empty_box.png",))
               );
          })
        ],
      ),
    );
  }
}
