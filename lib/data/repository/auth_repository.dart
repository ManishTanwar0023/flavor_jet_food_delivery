import 'package:flavor_jet_food_delivery/data/api/api_client.dart';
import 'package:flavor_jet_food_delivery/model/signup_model.dart';
import 'package:flavor_jet_food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepository({
    required this.apiClient,
    required this.sharedPreferences
  });

  Future<Response> registration(SignupModel signupModel) async {
    return await apiClient.postData(AppConstants.REGISTRATION_URL, signupModel.toJson());
  }

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URL, {"email": email, "password": password});
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN)?? "None";
  }

  bool userLoggedIn(){
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try{
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
      await sharedPreferences.setString(AppConstants.PHONE, number);
    }catch(e){
      throw e;
    }
  }

  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }

}