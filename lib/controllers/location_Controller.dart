import 'package:flavor_jet_food_delivery/data/repository/locaton_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/address_model.dart';

class LocationController extends GetxController implements GetxService{
LocationRepo locationRepo;

LocationController({required this.locationRepo});

bool _loading= false;
late Position _position;
late Position _pickPosition;
Placemark _placemark = Placemark();
Placemark _pickPlacemark = Placemark();
List<AddressModel> _addressList = [];
List<AddressModel> get addressList => _addressList;
late List<AddressModel> _allAddressList;
List<String>_addressTypeList = ["home","office","others"];
int _addressTypeIndex = 0;
late Map<String,dynamic> _getAddress;
Map get getAddress => _getAddress;

late GoogleMapController _mapController;
bool _updateAddressData = true;
bool _changeAddress = true;

bool get loading => _loading;
Position get position => _position;
Position get pickPosition => _pickPosition;

void setMapController(GoogleMapController mapController){
  _mapController = mapController;
}

  Future<void> updatePosition(CameraPosition position, bool fromAddress) async {
  if(_updateAddressData){
    _loading = true;
    update();
    try{
      if(fromAddress){
        _position = Position(
            longitude: position.target.longitude,
            latitude: position.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1
        );
      }else{
        _pickPosition = Position(
            longitude: position.target.longitude,
            latitude: position.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1);
      }

      if(_changeAddress){
        String _address = await getAddressFromGeocode(
          LatLng(position.target.latitude, position.target.longitude)
        );
      }
    }catch(e){
      print(e);
    }
  }
  }

Future<String> getAddressFromGeocode(LatLng latLng) async {
  String _address = "Unknown Location Found";
  Response response = await locationRepo.getAddressFromGeocode(latLng);
  print('Response: ${response.body}');

  if (response.statusCode == 200) {
    var responseBody = response.body;
    if (responseBody["status"] == 'OK') {
      _address = responseBody["results"][0]["formatted_address"];
      print("Address from API: $_address");
    } else {
      print("Error from Google API: ${responseBody["status"]}");
    }
  } else {
    print("Error fetching data from API: ${response.statusCode}");
  }
  return _address;
}


}