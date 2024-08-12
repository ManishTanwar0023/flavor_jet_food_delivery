import 'dart:convert';

import 'package:flavor_jet_food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/cart_model.dart';

class CartRepository{
  final SharedPreferences SP;
  CartRepository({required this.SP});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    cart = [];
    var time = DateTime.now().toString();
    // SP.remove(AppConstants.CART_HISTORY_LIST);
    // SP.remove(AppConstants.CART_LIST);
    // Convert  Object to String because SharedPreference only Accepts String....
    // cartList.forEach((element) => cart.add(jsonEncode(element)));
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    SP.setStringList(AppConstants.CART_LIST, cart);
    getCartList();

  }

  List<CartModel> getCartList(){

    List<String> carts = [];

    if(SP.containsKey(AppConstants.CART_LIST)){
      carts = SP.getStringList(AppConstants.CART_LIST)!;
    }

    List<CartModel> cartList = [];
    carts.forEach((element)=>cartList.add(CartModel.fromJson(jsonDecode(element))));

    // carts.forEach((element) {
    //   cartList.add(CartModel.fromJson(jsonDecode(element)));
    // });

    return cartList;
  }

  List<CartModel> getCartHistoryList(){
    if(SP.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory = [];
      cartHistory = SP.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element)=>cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList(){
    if(SP.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory = SP.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for(int i=0; i<cart.length; i++){
      cartHistory.add(cart[i]);
    }
    removeCart();
    SP.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  }

  void removeCart(){
    cart = [];
    SP.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory(){
    removeCart();
    cartHistory=[];
    SP.remove(AppConstants.CART_HISTORY_LIST);
  }

}