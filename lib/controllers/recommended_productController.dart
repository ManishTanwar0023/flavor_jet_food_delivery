import 'package:get/get.dart';

import '../data/repository/rcommended_product_repository.dart';
import '../model/product_model.dart';

class Recommended_ProductController extends GetxController{
  final RecommendedProductRepository recommendedproductRepository;
  Recommended_ProductController({required this.recommendedproductRepository,});

  List<ProductModel> _recommended_productList =[];
  List<ProductModel> get recommended_productList => _recommended_productList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async{
    Response response= await recommendedproductRepository.getRecommendedProductList();

    if(response.statusCode == 200 ){
      _recommended_productList = [];
      _recommended_productList.addAll(Product.fromJson(response.body).productData ?? []);
      _isLoaded = true;
      update();
    }else{
      // Handle the error appropriately, e.g., set _isLoaded to false or log the error.
      _isLoaded = false;
      update();
      print('Failed to load products');
    }

  }
}