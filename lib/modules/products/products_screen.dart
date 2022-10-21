import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:marche/modules/airtime/buyairtime.dart';
import 'package:marche/modules/cashpower/cashpower.dart';
import 'package:marche/modules/cubit/states.dart';
import 'package:marche/modules/grocery/grocery.dart';
import 'package:marche/modules/grocery/item_card.dart';
import '../../models/shop_app/home_model.dart';
import '../../shared/components/components.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../login/shop_login-screen.dart';
import '../product_details/product_details_screen.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);
  bool tri = true;
  int num = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) => true,
          widgetBuilder: (BuildContext context) => servicesBuilder(context),
          fallbackBuilder: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context, state) {
        if (state is ShopLoginSuccessState) {}
      },
    );
  }

  Widget servicesBuilder(BuildContext context) {
    const services = [
      {
        "img": "grocery.jpg",
        "title": "Groceries",
        "description": "Buy groceries for across the gambia.",
        "onclick": GroceryScreen(),
      },
      {
        "img": "airtime.png",
        "title": "Buy Airtime",
        "description": "Buy airtime for any phone number.",
        "onclick": BuyAirTime(),
      },
      {
        "img": "cashpower.png",
        "title": "Cash Power",
        "description": "Buy cash power for any meter no.",
        "onclick": BuyCashPower(),
      },
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: [1, 2, 3, 4]
                .map(
                  (e) => Image.asset(
                    "banner0.jpg",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Services',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildListService(
                img: services[index]['img'],
                title: services[index]['title'],
                onclick: services[index]['onclick'],
                context: context,
                description: services[index]['description']),
            itemCount: services.length,
          ),
        ],
      ),
    );
  }

  Widget buildListService(
          {dynamic? img,
          dynamic? title,
          dynamic? description,
          dynamic? onclick,
          BuildContext? context}) =>
      GestureDetector(
        onTap: () => {navigateTo(context, onclick)},
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 5.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                img!,
                height: 100,
                width: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title!,
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      child: Text(
                        description!,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
