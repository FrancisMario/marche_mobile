import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marche/models/shop_app/airtime_model.dart';
import 'package:marche/models/shop_app/nawec_model.dart';
import 'package:marche/models/shop_app/shopdata_model.dart';
import 'package:marche/modules/cubit/states.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../models/shop_app/cart_model.dart';
import '../../models/shop_app/creditcard_model.dart';
import '../../models/shop_app/home_model.dart';
import '../../models/shop_app/login_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/networks/end_points.dart';
import '../../shared/networks/local/cache_helper.dart';
import '../../shared/networks/remote/dio_helper.dart';
import '../products/products_screen.dart';
import '../settings/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  List<Widget> bottomScreens = [
    ProductsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Grocery',
  ];

  ShopLoginModel? userDataModel;
  ShopModel? shop;
  List<ItemDataModel> cart = [];
  // get locations, shops and items
  void initApp() {
    emit(ShopInitLoadingState());
    DioHelper.getData(
      url: 'api/init',
      token: token,
    ).then((value) {
      print("user data value => " + value.data.toString());
      shop = ShopModel.fromJson(value.data['data']);
      emit(ShopInitSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopInitErrorState());
    });
  }

  void userData(data) {
    isProcessing = true;
    emit(ShopLoadingNawecVend());
    print('vending');
    DioHelper.postData(url: NAWEC_VEND, token: token, data: data).then((value) {
      // cartModel = CartModel.fromJson(value.data);
      emit(ShopSuccessNawecVend());
      isProcessing = false;
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorNawecVend());
      isProcessing = false;
    });
  }

  bool isProcessing = false;
  void nawecVend(data) {
    isProcessing = true;
    emit(ShopLoadingNawecVend());
    print('vending');
    DioHelper.postData(url: NAWEC_VEND, token: token, data: data).then((value) {
      // cartModel = CartModel.fromJson(value.data);
      emit(ShopSuccessNawecVend());
      isProcessing = false;
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorNawecVend());
      isProcessing = false;
    });
  }

  void airtime(data) {
    isProcessing = true;
    emit(ShopLoadingAirTime());
    print("airtiming!");
    DioHelper.postData(url: AIRTIME, token: token, data: data).then((value) {
      emit(ShopSuccessAirTime());
      isProcessing = false;
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorAirTime());
      isProcessing = false;
    });
  }

  // Modals

  void showInfoModal(BuildContext context, data, DialogType type) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: type,
      body: Center(
        child: Text(
          data['content'] as String,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      title: data['title'],
      desc: data['desc'],
    ).show();
  }

  CartModel cartModel = CartModel();

  void createItemOrder() {
    DioHelper.postData(
      url: 'admin/orders',
      token: token,
      data: {
        "itemid": cartModel.cart.map((e) => e.id),
        'type': 'item',
        "amount": cartModel.total()
      },
    ).then((value) {
      value.data
          .forEach((e) => {cartModel.addItem(Product.fromJson(e), false)});
      // Navigate to order status page
      emit(CheckoutSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }

      emit(CheckoutErrorState());
    });
  }

  void createServiceOrder() {
    if (activeAirtime == null && activeNawec == null) {
      throw 'parameter "String type" is required.';
    }
    var data = {};
    switch (type) {
      case 'airtime':
        data = {
          "itemId": [],
          "phone": activeAirtime?.phone,
          "amount": activeAirtime?.amount,
          "carrier": activeAirtime?.carrier,
          'type': type,
        };
        break;
      case 'nawec':
        data = {
          "meterno": activeAirtime?.phone,
          "amount": activeAirtime?.amount,
          'type': type,
        };
        break;
    }
    DioHelper.postData(
      url: 'admin/orders',
      token: token,
      data: data,
    ).then((value) {
      value.data
          .forEach((e) => {cartModel.addItem(Product.fromJson(e), false)});
      type = null; // reset type
      activeAirtime = null;
      activeNawec = null;
      emit(CheckoutSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }

      emit(CheckoutErrorState());
    });
  }

  String? type = null;

  AirTimeModel? activeAirtime;
  NawecModel? activeNawec;

  String? token;

  ShopLoginModel? loginModel;

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(url: REGISTER, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    }).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopRegisterErrorState());
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    print(email);
    print(password);
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      if (kDebugMode) {
        print("value => " + value.toString());
      }
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState());
    }).catchError((error) {
      print(error);
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopLoginErrorState());
    });
  }

  void vendorRegister({
    required String name,
    required String phone,
    required String location,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(url: "/vendor", data: {
      'name': name,
      'phone': phone,
      'location': location,
    }).then((value) {
      if (kDebugMode) {
        print("value => " + value.toString());
        print(value.data);
      }
      emit(ShopLoginSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopLoginErrorState());
    });
  }
}
