import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:marche/layout/shop_layout/shop_layout_screen.dart';
import 'package:marche/main.dart';
import 'package:marche/models/shop_app/cart_model.dart';
import 'package:marche/modules/cubit/cubit.dart';
import 'package:marche/modules/cubit/states.dart';
import 'package:marche/modules/login/shop_login-screen.dart';
import '../../shared/components/components.dart';

class Final_Checkout extends StatefulWidget {
  final dynamic data;
  const Final_Checkout({key, this.data});
  @override
  State<Final_Checkout> createState() => _Final_CheckoutState();
}

class _Final_CheckoutState extends State<Final_Checkout> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          print((ShopCubit.get(context).loginModel == null));
          // print(ShopCubit.get(context).loginModel!.data!.email.toString());
          return Conditional.single(
              context: context,
              conditionBuilder: (BuildContext context) =>
                  ShopCubit.get(context).loginModel != null,
              widgetBuilder: (BuildContext context) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "Payment Method",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black38,
                            ),
                          )),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "You are being redirected to a payment page.",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Order will be processed once payment has been recieved.",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (c) => AlertDialog(
                                      title: const Text("Please Wait..."),
                                      content: SizedBox(
                                          height: 100,
                                          child: processingLoader(
                                              text: "Please wait"))));

                              // create order and request payment
                                  ShopCubit.get(context).getPaymentLink(context);
                              // switch (ShopCubit) {
                              //   case 'item':
                              //     // create item order based on items found in (ShopCubit.get(context).cartModel.cart)
                              //     break;
                              //   default:
                              //     ShopCubit.get(context).createServiceOrder();
                              //     break;
                              // }
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.width / 4,
                              color: Colors.red,
                              child: const Center(
                                child: Text(
                                  "Proceed",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              fallbackBuilder: (BuildContext context) => const ShopLoginScreen(
                    next: null,
                  ));
        },
      ),
    );
  }
}
