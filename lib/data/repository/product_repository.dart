
import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class  ProductRepository extends GetxService{
  final ApiClient apiClient;

  ProductRepository({required this.apiClient});

  Future<Response> getProductList() async {
    return await apiClient.getData(AppConstants.PRODUCT_URL);
  }
}