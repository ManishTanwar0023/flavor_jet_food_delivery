
import 'package:flavor_jet_food_delivery/controllers/cartController.dart';
import 'package:flavor_jet_food_delivery/utils/appColor.dart';
import 'package:flavor_jet_food_delivery/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/product_repository.dart';
import '../model/cart_model.dart';
import '../model/product_model.dart';

class ProductController extends GetxController {
  final ProductRepository productRepository;
  ProductController({required this.productRepository});

  List<ProductModel> _productList = [];
  List<ProductModel> get productList => _productList;
  late CartController _cart;

  bool _isLoaded = false;  // Initialize as false to represent the loading state.
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int _inCartItems = 0;
  int get quantity=>_quantity;
  int get inCartItems => _inCartItems+_quantity;

  Future<void> getProductList() async {
    Response response = await productRepository.getProductList();

    if (response.statusCode == 200) {
      _productList = [];
      _productList.addAll(Product.fromJson(response.body).productData ?? []);  // Handle possible null with a default empty list.
      _isLoaded = true;
      update();
    } else {
      // Handle the error appropriately, e.g., set _isLoaded to false or log the error.
      _isLoaded = false;
      update();
      print('Failed to load products');
    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity =checkQuantity(_quantity+1);
    }else{
      _quantity =checkQuantity(_quantity-1);
    }
    update();
  }

  int checkQuantity(int  quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar("Iteam Count", "You can't reduce more!",
      backgroundColor: Colors.red,
      colorText: Colors.white,
      );
      return 0;
    }else if((_inCartItems+quantity ) >20){
      Get.snackbar("Iteam Count", "You can't add more!",
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return 20;
    }else{
      return quantity;
    }

  }

  void initProduct(ProductModel product,CartController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.ExistInCart(product);
    if(exist){
      _inCartItems=_cart.getQuantity(product);
    }
  }

  void addItem(ProductModel PM){
      _cart.addItem(PM, _quantity);
      _quantity = 0;
      _inCartItems = _cart.getQuantity(PM);
      _cart.items.forEach((key, value) { 
       // print("The id is "+value.id.toString() +" The Quantity is "+value.quantity.toString());
      });
      update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }

}
