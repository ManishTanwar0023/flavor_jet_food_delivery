import 'package:flavor_jet_food_delivery/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String msg,
    {bool isError=true,String title="Error"}){
  Get.snackbar(
      title,
      msg,
      titleText: BigText(text: title,color: Colors.white,),
    messageText: Text(msg,style: TextStyle(color: Colors.white),),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.redAccent
  );
}