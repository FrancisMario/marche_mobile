import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:marche/layout/shop_layout/shop_layout_screen.dart';
import 'package:marche/main.dart';
import 'package:marche/models/shop_app/cart_model.dart';
import 'package:marche/modules/checkout/checkout.dart';
import 'package:marche/modules/cubit/cubit.dart';
import 'package:marche/modules/cubit/states.dart';
import 'package:marche/modules/login/shop_login-screen.dart';
import 'package:marche/shared/components/constants.dart';
import 'package:marche/shared/networks/end_points.dart';

import '../../shared/components/components.dart';

class Item_Checkout extends StatefulWidget {
  final dynamic data;
  const Item_Checkout({key, this.data});
  @override
  State<Item_Checkout> createState() => _Item_CheckoutState();
}

class _Item_CheckoutState extends State<Item_Checkout> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _phoneHasError = false;
  String phone = '';
  bool phoneready = false;
  bool nameready = false;
  TextEditingController recipientName = TextEditingController();
  TextEditingController recipientPhone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, states) {
        if (states is ShopLoginSuccessState) {}
      },
      builder: (context, states) {
        ShopCubit.get(context).cart.forEach((e) => print(e.id));
        ShopCubit.get(context).cart.forEach((e) => print(e.quantity));
        return Scaffold(
          appBar: AppBar(
            title: const Text("Checkout"),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 5),
                              Row(
                                children: [
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
                        print(getRecipientData());
                        // setState(() {});
                        // if (ShopCubit.get(context).loginModel == null) {
                        //   navigateTo(
                        //       context,
                        //       const ShopLoginScreen(
                        //         next: Final_Checkout(),
                        //       ));
                        // } else {
                        //   // navigateTo(
                        //   //   context,
                        //   //   Final_Checkout(),
                        //   // );
                        // }
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
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                  ),
                  Flexible(
                      flex: 8,
                      child: Text(
                        title,
                        style: const TextStyle(
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

  getRecipientData() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Reciepient Info"),
            content: SizedBox(
              height: 150,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  designedFormField(
                    controller: recipientName,
                    type: TextInputType.name,
                    label: 'Name',
                    onChange: (val) {
                      print(val);
                      if (val.length >= 7) {
                        print("name ready:" + val);
                        nameready = true;
                        setState(() {});
                      } else {
                        nameready = false;
                      }
                    },
                    validator: (value) {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  designedFormField(
                    controller: recipientPhone,
                    type: TextInputType.number,
                    label: 'Phone Number',
                    onChange: (val) {
                      print(val);
                      if (val.length >= 7) {
                        print("phone ready:" + val);
                        phoneready = true;
                        setState(() {});
                      } else {
                        phoneready = false;
                      }
                    },
                    validator: (value) {},
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: (phoneready && nameready)
                      ? Colors.redAccent
                      : Colors.grey, // Background color
                ),
                child: const Text("Continue"),
                onPressed: () {
                  if (phoneready && nameready) {
                    ShopCubit.get(context).recipientName =
                        recipientName.value.text;
                    ShopCubit.get(context).recipientPhone =
                        recipientPhone.value.text;
                    // vavigate to new spot
                    // Navigator.of(context).pop();
                    navigateTo(context, Final_Checkout());
                  }
                },
              )
            ],
          );
        });
  }

  double? total(BuildContext context) {
    double total = 0;
    ShopCubit.get(context).cart.forEach((element) {
      total += (element.quantity * element.price);
    });
    return total;
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
                        '${URL}img?id=' +
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
              ElevatedButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
