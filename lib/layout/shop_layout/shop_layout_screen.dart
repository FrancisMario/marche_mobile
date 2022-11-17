import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:marche/modules/aboutus/aboutus.dart';
import 'package:marche/modules/checkout/item_checkout.dart';
import 'package:marche/modules/credit/payment.dart';
import 'package:marche/modules/grocery/grocery.dart';
import 'package:marche/modules/vendor/vendor.dart';
import '../../modules/cart/cart_screen.dart';
import '../../modules/cubit/cubit.dart';
import '../../modules/cubit/states.dart';
import '../../modules/products/products_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../shared/components/components.dart';

class ShopLayoutScreen extends StatefulWidget {
  dynamic callback = () => {};
  ShopLayoutScreen({Key? key, this.callback}) : super(key: key);

  @override
  State<ShopLayoutScreen> createState() => _ShopLayoutScreenState();
}

class _ShopLayoutScreenState extends State<ShopLayoutScreen> {
  List<Map> drawerItems = [
    {
      "name": "Home",
      "icon": Icons.home,
      "onclick": (context) {
        navigateAndFinish(context, ShopLayoutScreen());
      }
    },
    {
      "name": "Profile",
      "icon": Icons.account_circle,
      "onclick": (context) {
        navigateTo(context, SettingsScreen());
      }
    },
    {
      "name": "Become a vendor",
      "icon": Icons.shop,
      "onclick": (context) {
        navigateTo(context, VendoRegistration());
      }
    },
    {
      "name": "About us",
      "icon": Icons.inbox,
      "onclick": (context) {
        navigateTo(context, AboutUs());
      }
    },
    {
      "name": "Terms and conditions",
      "icon": Icons.language,
      "onclick": (context) {
        
      }
    },
  ];

  List<Widget> drawerWidgets = [];

  @override
  void initState() {
    super.initState();
    drawerWidgets.add(
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.redAccent,
        ),
        child: Text('Menu', style: TextStyle(color: Colors.white)),
      ),
    );
    drawerItems.forEach((e) {
      drawerWidgets.add(ListTile(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 2,
              ),
              child: Icon(
                e['icon'],
                color: Colors.redAccent,
                size: 30,
              ),
            ),
            SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(e['name'], style: TextStyle(color: Colors.black38)),
            ),
          ],
        ),
        onTap: () {
          e['onclick'](context);
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            semanticLabel: "Top Left App Drawer",
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: drawerWidgets,
            ),
          ),
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, const Item_Checkout());
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.redAccent,
                  )),
              IconButton(
                  onPressed: () {
                    navigateTo(context, SettingsScreen());
                  },
                  icon: const Icon(
                    //Icons.shopping_cart
                    Icons.account_circle_rounded,
                    color: Colors.redAccent,
                  )),
            ],
          ),
          body: ProductsScreen(),
        );
      },
    );
  }
}
