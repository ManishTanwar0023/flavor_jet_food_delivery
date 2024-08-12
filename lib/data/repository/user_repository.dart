import 'package:flavor_jet_food_delivery/data/api/api_client.dart';
import 'package:flavor_jet_food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class UserRepo{
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.REGISTER_INFO);
  }
}