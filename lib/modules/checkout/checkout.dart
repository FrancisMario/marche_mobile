import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:marche/layout/shop_layout/shop_layout_screen.dart';
import 'package:marche/main.dart';
import 'package:marche/models/shop_app/cart_model.dart';
import 'package:marche/modules/cubit/cubit.dart';
import 'package:marche/modules/cubit/states.dart';
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
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          ShopCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Payment'),
              actions: [],
            ),
            body: Column(
              children: [
                Expanded(
                  child: Conditional.single(
                    context: context,
                    conditionBuilder: (BuildContext context) =>
                        ShopCubit.get(context).isProcessing == false,
                    widgetBuilder: (BuildContext context) {
                      return Center(
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
                                      barrierDismissible: false,
                                      builder: (c) => const AlertDialog(
                                            title: Text("Payment"),
                                            content: Text(
                                                "You are being redirected to the payment section"),
                                          ));

                                  // create order and request payment
                                  switch (ShopCubit.get(context).type) {
                                    case 'item':
                                      // create item order based on items found in (ShopCubit.get(context).cartModel.cart)
                                      ShopCubit.get(context).createItemOrder();
                                      break;
                                    default:
                                      ShopCubit.get(context)
                                          .createServiceOrder();
                                      break;
                                  }

                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    // setState(() {});
                                    // Navigator.of(context).pop();
                                    // navigateAndFinish(
                                    //     context, ShopLayoutScreen());
                                  });
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
                      );
                    },
                    fallbackBuilder: (BuildContext context) =>
                        processingLoader(text: 'Please wait, Processing ...'),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
