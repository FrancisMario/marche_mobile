import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marche/layout/shop_layout/shop_layout_screen.dart';
import 'package:marche/main.dart';
import 'package:marche/models/shop_app/cart_model.dart';
import 'package:marche/modules/checkout/checkout.dart';
import 'package:marche/modules/cubit/cubit.dart';
import 'package:marche/modules/cubit/states.dart';
import 'package:marche/modules/login/shop_login-screen.dart';
import 'package:marche/shared/components/constants.dart';

import '../../shared/components/components.dart';

class Item_Checkout extends StatefulWidget {
  final dynamic data;
  const Item_Checkout({key, this.data});
  @override
  State<Item_Checkout> createState() => _Item_CheckoutState();
}

class _Item_CheckoutState extends State<Item_Checkout> {
  @override
  Widget build(BuildContext context) {
    // widget.originalcart.elementAt(1);
    // widget.originalcart.

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, states) {
        if (states is ShopLoginSuccessState) {}
      },
      builder: (context, states) {
        ShopCubit.get(context).cart.forEach((e) => print(e.id));
        ShopCubit.get(context).cart.forEach((e) => print(e.quantity));
        return Scaffold(
          appBar: AppBar(
            title: Text("Checkout"),
          ),
          body: Container(
            margin:
                EdgeInsets.only(bottom: MediaQuery.of(context).size.width / 4),
            child: ShopCubit.get(context).cart.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: ShopCubit.get(context).cart.length,
                    itemBuilder: (context, index) {
                      return item(context, index);
                    })
                : const Center(child: Center(child: Text("No Orders in cart"))),
          ),
          bottomSheet: Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 4,
            color: Colors.red[900],
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      height: MediaQuery.of(context).size.width / 4,
                      color: Colors.black12,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: Column(
                            children: [
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  // Text(
                                  //   "Total : D",
                                  //   style: TextStyle(
                                  //       fontSize: , color: Colors.white),
                                  // ),
                                  Text(
                                    "\$ ${total(context)}.00",
                                    style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    )),
                Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        if (total(context) == 0) {
                          showMessage("Error", "Can't checkout an empty cart");
                          return;
                        }
                        // ShopCubit.get(context).type = 'item';
                        setState(() {});
                        if (ShopCubit.get(context).loginModel == null) {
                          navigateTo(
                              context,
                              const ShopLoginScreen(
                                next: Final_Checkout(),
                              ));
                        } else {
                          navigateTo(
                              context,
                               Final_Checkout(),
                              );
                        }
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.width / 4,
                        color: Colors.red,
                        child: const Center(
                          child: Text(
                            "CheckOut",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  showProgressDialog(BuildContext context, String title) async {
    try {
      await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              content: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                  ),
                  Flexible(
                      flex: 8,
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            );
          });
    } catch (e) {
      print(e.toString());
    }
  }

  dexService() {
    return 3;
  }

  double? orderCost() {
    double response = 0;
    [{}].forEach((value) {
      response += 2;
      // (double.parse(value["price"]) * double.parse(value["quantity"]));
    });
    return response;
  }

  double? total(BuildContext context) {
    double total = 0;
    ShopCubit.get(context).cart.forEach((element) {
      total += (element.quantity * element.price);
    });
    return total;
  }

  void incrementItemCount(id) {}

  void decrementItemCount(id) {
    setState(() {});
  }

  Widget item(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 5.2,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  height: MediaQuery.of(context).size.height / 5.2,
                  child: Image(
                    image: NetworkImage(
                        "http://localhost:3000/img?id=" +
                            ShopCubit.get(context).cart[index].image!,
                        headers: {'x-auth-token': "token"}),
                    width: 180,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                )),
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                ShopCubit.get(context).cart[index].name!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.black87,
                                ),
                              ),
                            )),
                        GestureDetector(
                          onTap: () {
                            ShopCubit.get(context)
                                .cart
                                .remove(ShopCubit.get(context).cart[index]);
                            setState(() {});
                          },
                          child: const Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 7),
                              child: Icon(Icons.close),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10.0),
                          child: Text(
                            "\$ " +
                                ShopCubit.get(context)
                                    .cart[index]
                                    .price!
                                    .toString(),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (ShopCubit.get(context).cart[index].quantity >
                                1) {
                              ShopCubit.get(context).cart[index].quantity -= 1;
                            }
                            setState(() {});
                          },
                          child: Container(
                            color: Colors.blueGrey[100],
                            child: const Icon(Icons.remove,
                                size: 35, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            ShopCubit.get(context)
                                .cart[index]
                                .quantity
                                .toString(),
                            style:
                                TextStyle(fontSize: 25, color: Colors.black87),
                          ),
                        ),
                        Container(
                          color: Colors.grey[300],
                          child: GestureDetector(
                              onTap: () {
                                if (ShopCubit.get(context)
                                        .cart[index]
                                        .quantity <
                                    20) {
                                  ShopCubit.get(context).cart[index].quantity +=
                                      1;
                                }
                                setState(() {});
                              },
                              child: const Icon(Icons.add,
                                  size: 35, color: Colors.white)),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      color: Colors.red,
                      width: 100,
                      child: Row(children: const []),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  showMessage(String title, String massage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(massage),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  nawecVendComplete() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              "Order Successful",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            )),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Meter no: 07213432323 ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Token: 3234 5344 5342 4345 ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              navigateTo(
                  context,
                  MyApp(
                    startWidget: ShopLayoutScreen(),
                  ));
            },
            child: Text(
              "Done",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget airtimeComplete() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: Text("Order Successful")),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(children: [
              Text("Phone no: 3247034 "),
            ]),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(children: [
              Text("Carrier: QCELL "),
            ]),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(children: [
              Text("Amount: D 200 "),
            ]),
          ),
          TextButton(
            onPressed: () {
              navigateTo(
                  context,
                  MyApp(
                    startWidget: ShopLayoutScreen(),
                  ));
            },
            child: Text(
              "Done",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget airtimeError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
                child: Icon(
              Icons.error,
              size: 40,
            )),
          ),
          TextButton(
            onPressed: () {
              ShopCubit.get(context).airtime({"type": "airtime"});
            },
            child: Text(
              "Oops an error occured, Please try again.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }

  Widget nawecVendError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
                child: Icon(
              Icons.error,
              size: 40,
            )),
          ),
          TextButton(
            onPressed: () {
              // ShopCubit.get(context).nawecVend({"type": "vend"});
            },
            child: Text(
              "Oops an error occured, Please try again",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
