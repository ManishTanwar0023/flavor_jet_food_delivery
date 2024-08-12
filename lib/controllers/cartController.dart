import 'package:flavor_jet_food_delivery/data/repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/cart_model.dart';
import '../model/product_model.dart';

class CartController extends GetxController{
  final CartRepository cartRepo;
  CartController({required this.cartRepo});
  Map<int,CartModel> _items ={};

  Map<int,CartModel> get items=>_items;

  //Only show for Storage and SharedPreferences
  List<CartModel> storageItems = [];

  void addItem(ProductModel PM,int quantity){
    var totalQuantity = 0;
    if(_items.containsKey(PM.id!)){
      _items.update(PM.id!, (value) {
        totalQuantity=value.quantity!+quantity;
        return CartModel(
            id: PM.id,
            name: PM.name,
            price: PM.price,
            image: PM.image,
            isExist: true,
            quantity: value.quantity!+quantity,
            time: DateTime.now().toString(),
            product: PM
        );
      });

      if(totalQuantity<=0){
        _items.remove(PM.id);
      }

    }else{
     if(quantity>0){
       _items.putIfAbsent(PM.id!, () {
         return CartModel(
             id: PM.id,
             name: PM.name,
             price: PM.price,
             image: PM.image,
             isExist: true,
             quantity: quantity,
             time: DateTime.now().toString(),
             product: PM
         );
       });
     }else{
       Get.snackbar("Iteam Count", "You should at least add an item in the cart!",
         backgroundColor: Colors.red,
         colorText: Colors.white,
       );
     }
     }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool ExistInCart(ProductModel model){
    if(_items.containsKey(model.id)){
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel model){
    var quantity = 0;
    if(_items.containsKey(model.id)){
      _items.forEach((key, value) {
        if(key == model.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems{
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount{
    var total =0;
    _items.forEach((key, value) {
      total += value.quantity!*value.price!;
    });
    return total;
  }

  List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items){
    storageItems=items;
    for(int i = 0; i<storageItems.length; i++){
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear(){
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems){
    _items ={};
    _items = setItems;
  }

  void addToCartList(){
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory(){
    cartRepo.clearCartHistory();
    update();
  }

}