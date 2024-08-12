import 'package:flavor_jet_food_delivery/controllers/auth_Controller.dart';
import 'package:flavor_jet_food_delivery/controllers/location_Controller.dart';
import 'package:flavor_jet_food_delivery/controllers/user_Controller.dart';
import 'package:flavor_jet_food_delivery/utils/appColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class addAddressPage extends StatefulWidget {
  const addAddressPage({super.key});

  @override
  State<addAddressPage> createState() => _addAddressPageState();
}

class _addAddressPageState extends State<addAddressPage> {

  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _islogged;
  CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(28.624510, 76.948330),zoom: 17);
  late LatLng _initialPosition = LatLng(28.624510, 76.948330);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _islogged = Get.find<AuthController>().userLoggedIn();
    if(_islogged /*&& Get.find<UserController>().userModel==null*/){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(Get.find<LocationController>().getAddress["latitude"]),
    double.parse(Get.find<LocationController>().getAddress["longitude"])
          ));
      _initialPosition =LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"])
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Page"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<LocationController>(builder: (LocationCont){
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5,right: 5,top: 5),
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2 ,color: Theme.of(context).primaryColor)
              ),
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition:
                    CameraPosition(target: _initialPosition,zoom: 17),
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    indoorViewEnabled: true,
                    mapToolbarEnabled: false,
                    onCameraIdle: (){
                      LocationCont.updatePosition(_cameraPosition,true);
                    },
                    onCameraMove: ((Position)=> _cameraPosition = Position),
                    onMapCreated: (GoogleMapController controller){
                      LocationCont.setMapController(controller);
                    },

                  )
                ],
              ),
            )
          ],
        );
      },),
    );
  }
}
