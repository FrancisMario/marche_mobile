import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:marche/models/shop_app/shopdata_model.dart';
import 'package:marche/modules/checkout/item_checkout.dart';
import 'package:marche/modules/cubit/cubit.dart';
import 'package:marche/modules/grocery/item_card.dart';
import 'package:marche/shared/styles/icon_broken.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  String? selectedValue = 'Serekunda';
  int activeTab = 0;
  int activeLocation = 0;
  int activeShop = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    print(ShopCubit.get(context).shop);
  }

  @override
  Widget build(BuildContext context) {
    print(activeLocation);
    print(activeShop);
    print("---------------------");
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) => true,
          widgetBuilder: (BuildContext context) => Scaffold(
            appBar: AppBar(
              title: const Text('Groceries'),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, const Item_Checkout());
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.redAccent,
                    ))
              ],
            ),
            body: Form(
              key: _formKey,
              child: Column(
                children: [
                  CarouselSlider(
                    items: [1, 2]
                        .map(
                          (e) => Image.asset(
                            "banner0.jpg",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      height: 100.0,
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
                  // const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Location",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  DropdownButton<dynamic>(
                                    value: ShopCubit.get(context)
                                        .shop!
                                        .locations[activeLocation],
                                    items: ShopCubit.get(context)
                                        .shop!
                                        .locations
                                        .map((LocationDataModel value) {
                                      return DropdownMenuItem<
                                          LocationDataModel>(
                                        value: value,
                                        child: Text(
                                          value.name!,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        activeLocation = ShopCubit.get(context)
                                            .shop!
                                            .locations
                                            .indexOf(value);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "pick a shop",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  DropdownButton<ShopsDataModel>(
                                    value: ShopCubit.get(context)
                                                .shop!
                                                .locations[activeLocation]
                                                .shops
                                                .length >
                                            -1
                                        ? ShopCubit.get(context)
                                            .shop!
                                            .locations[activeLocation]
                                            .shops[activeShop]
                                        : null,
                                    items: ShopCubit.get(context)
                                                .shop!
                                                .locations[activeLocation]
                                                .shops
                                                .length >
                                            -1
                                        ? ShopCubit.get(context)
                                            .shop!
                                            .locations[activeLocation]
                                            .shops
                                            .map((ShopsDataModel value) {
                                            return DropdownMenuItem<
                                                ShopsDataModel>(
                                              value: value,
                                              child: Text(
                                                value.name!,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            );
                                          }).toList()
                                        : null,
                                    onChanged: (value) {
                                      setState(() {
                                        if (ShopCubit.get(context)
                                                .shop!
                                                .locations[activeLocation]
                                                .shops
                                                .indexOf(value!) <
                                            -1) {
                                          activeShop = ShopCubit.get(context)
                                              .shop!
                                              .locations[activeLocation]
                                              .shops
                                              .indexOf(value);
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Center(
                                child: GestureDetector(
                          onTap: () {
                            setState(() {
                              activeTab = 0;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      activeTab == 0 ? Colors.redAccent : null),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "All",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: activeTab == 0
                                          ? Colors.white
                                          : Colors.redAccent),
                                ),
                              )),
                        ))),
                        Expanded(
                            child: Center(
                                child: GestureDetector(
                          onTap: () {
                            setState(() {
                              activeTab = 1;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      activeTab == 1 ? Colors.redAccent : null),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Single",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: activeTab == 1
                                          ? Colors.white
                                          : Colors.redAccent),
                                ),
                              )),
                        ))),
                        Expanded(
                            child: Center(
                                child: GestureDetector(
                          onTap: () {
                            setState(() {
                              activeTab = 2;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      activeTab == 2 ? Colors.redAccent : null),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Bundle",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: activeTab == 2
                                          ? Colors.white
                                          : Colors.redAccent),
                                ),
                              )),
                        ))),
                      ],
                    ),
                  ),
                  if (state is GroceryLoadingState)
                    const LinearProgressIndicator(),
                  if (true)
                    Expanded(
                      child: GridView.builder(
                        itemBuilder: (context, index) => ItemCard(
                            ShopCubit.get(context)
                                .shop!
                                .locations[activeLocation]
                                .shops[activeShop]
                                .items[index]),
                        itemCount: ShopCubit.get(context)
                            .shop!
                            .locations[activeLocation]
                            .shops[activeShop]
                            .items
                            .length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          fallbackBuilder: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildSearchItem() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 150,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: const [
                  Image(
                    image: AssetImage('airtime.png'),
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
