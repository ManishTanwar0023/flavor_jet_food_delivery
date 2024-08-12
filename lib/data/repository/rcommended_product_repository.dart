
import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class  RecommendedProductRepository extends GetxService{
  final ApiClient apiClient;

  RecommendedProductRepository({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URL);
  }
}