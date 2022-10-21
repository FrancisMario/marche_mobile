// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
// import 'package:material_dialogs/material_dialogs.dart';
// import 'package:material_dialogs/widgets/buttons/icon_button.dart';
// import 'package:marche/models/shop_app/creditcard_model.dart';
// import 'package:marche/modules/airtime/buyairtime.dart';
// import 'package:marche/modules/credit/addcard.dart';
// import 'package:marche/modules/credit/card.dart';
// import 'package:marche/modules/cubit/states.dart';
// import 'package:marche/modules/login/cubit/states.dart';
// import 'package:marche/shared/components/constants.dart';
// import 'package:marche/shared/networks/end_points.dart';
// import 'package:marche/shared/networks/remote/dio_helper.dart';

// import '../../models/shop_app/history_model.dart';
// import '../../models/shop_app/home_model.dart';
// import '../../shared/components/components.dart';
// import '../checkout/checkout.dart';
// import '../cubit/cubit.dart';
// import '../cubit/states.dart';
// import '../login/shop_login-screen.dart';
// import '../product_details/product_details_screen.dart';

// class PaymentMethods extends StatefulWidget {
//   final Map<String, dynamic> data;

//   const PaymentMethods({Key? key, required this.data}) : super(key: key);

//   @override
//   State<PaymentMethods> createState() {
//     return _PaymentMethodsState();
//   }
// }

// class _PaymentMethodsState extends State<PaymentMethods> {
//   bool tri = true;
//   int num = 0;
//   String? activeCard = null;
//   String? name = null;

//   updateState(id) {
//     setState(() {
//       activeCard = id;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   updateState2(name) {
//     setState(() {
//       name = name;
//     });
//   }

//   nameCheck() async {
//     if (!widget.data['type'] == "vend") {
//       return;
//     }
//     DioHelper.postData(
//             url: NAWEC_VEND,
//             token: token,
//             data: {"type": "namecheck", "meterno": widget.data['meter_number']})
//         .then((value) {
//       name = value.data['data']['name'];
//     }).catchError((error) {
//       Navigator.of(context).pop();
//     });
//   }

//   Future confirmOrder() {
//     // run name check and confirm order
//     nameCheck();
//     return Dialogs.materialDialog(
//       color: Colors.white,
//       customView: widget.data['type'] == 'vend'
//           ? name == null
//               ? const Padding(
//                   padding: EdgeInsets.all(30.0),
//                   child: Center(child: CircularProgressIndicator()),
//                 )
//               : Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text("Order Review"),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text("Meter No: " +
//                           widget.data['meter_number'].toString()),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text("Name: " + name.toString()),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text("Amount: D " + widget.data['amount']),
//                     ),
//                   ],
//                 )
//           : Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text("Order Review"),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child:
//                       Text("Phone Number: " + widget.data['phone'].toString()),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text("Network: " + widget.data['carrier'].toString()),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text("Amount: D " + widget.data['amount']),
//                 ),
//               ],
//             ),
//       dialogWidth: kIsWeb ? 0.3 : null,
//       context: context,
//       actions: [
//         IconsButton(
//           onPressed: () {
//             var props = widget.data;
//             props['card'] = activeCard;

//             widget.data['type'] == 'vend'
//                 ? name != null
//                     ? navigateAndFinish(context, Final_Checkout(data: props))
//                     : null
//                 : navigateAndFinish(context, Final_Checkout(data: props));
//           },
//           text: 'Confirm',
//           iconData: Icons.done,
//           color: widget.data['type'] == 'vend'
//               ? name != null
//                   ? Colors.blue
//                   : Colors.grey
//               : Colors.blue,
//           textStyle: TextStyle(color: Colors.white),
//           iconColor: Colors.white,
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => ShopCubit()..getCreditCards(),
//       child: BlocConsumer<ShopCubit, ShopStates>(
//         builder: (context, state) {
//           return Conditional.single(
//             context: context,
//             conditionBuilder: (BuildContext context) =>
//                 // ShopCubit.get(context).creditCardsModel != null ,
//                 state is ShopSuccessCreditCardState,
//             widgetBuilder: (BuildContext context) => Scaffold(
//               appBar: AppBar(title: const Text('My Cards')),
//               body: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Container(
//                         child: ListView.builder(
//                           scrollDirection: Axis.vertical,
//                           shrinkWrap: true,
//                           itemCount: ShopCubit.get(context)
//                               .creditCardsModel
//                               ?.data
//                               .cards
//                               .length,
//                           itemBuilder: (context, i) {
//                             return CCardWidget(
//                               model: ShopCubit.get(context)
//                                   .creditCardsModel
//                                   ?.data
//                                   .cards[i],
//                               activecard: activeCard,
//                               callback: updateState,
//                             );
//                           },
//                         ),
//                       ),
//                       GestureDetector(
//                           onTap: () {
//                             // confirm and place order
//                             confirmOrder();
//                           },
//                           child: Container(
//                               width: 200,
//                               height: 50,
//                               color:
//                                   activeCard != null ? Colors.red : Colors.grey,
//                               child: Center(
//                                   child: Text(
//                                 'Check Out',
//                                 style: TextStyle(
//                                     fontSize: 30,
//                                     fontWeight: FontWeight.w400,
//                                     color: activeCard != null
//                                         ? Colors.white
//                                         : Colors.white),
//                               ))))
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             fallbackBuilder: (BuildContext context) =>
//                 const Center(child: CircularProgressIndicator()),
//           );
//         },
//         listener: (context, state) {
//           if (state is ShopLoginSuccessState) {}
//         },
//       ),
//     );
//   }
// }
