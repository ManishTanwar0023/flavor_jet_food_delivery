import 'package:flavor_jet_food_delivery/pages/account/account_page.dart';
import 'package:flavor_jet_food_delivery/pages/auth/sign_up.dart';
import 'package:flavor_jet_food_delivery/pages/cart/cart_history.dart';
import 'package:flavor_jet_food_delivery/pages/home/main_page.dart';
import 'package:flavor_jet_food_delivery/utils/appColor.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

int _selectIndex = 0;

  List pages=[
    MainPage(),
    Container(color: Colors.redAccent,child: Center(child: Text("History Page"),),),
    CartHistory(),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectIndex],
      bottomNavigationBar: SalomonBottomBar(
      currentIndex: _selectIndex,
      onTap: (i) => setState(() => _selectIndex = i),
      items: [
        /// Home
        SalomonBottomBarItem(
          icon: Icon(Icons.home),
          title: Text("Home"),
          selectedColor: AppColors.mainColor,
        ),

        /// Likes
        SalomonBottomBarItem(
          icon: Icon(Icons.favorite_border),
          title: Text("Likes"),
          selectedColor: AppColors.mainColor,
        ),

        /// Search
        SalomonBottomBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          title: Text("Cart"),
          selectedColor: AppColors.mainColor,
        ),

        /// Profile
        SalomonBottomBarItem(
          icon: Icon(Icons.person),
          title: Text("Profile"),
          selectedColor: AppColors.mainColor,
        ),
      ],
    ),
    );
  }
}
