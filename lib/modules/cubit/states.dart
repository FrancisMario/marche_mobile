import 'package:marche/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopInitLoadingState extends ShopStates {}

class ShopInitSuccessState extends ShopStates {}

class ShopInitErrorState extends ShopStates {}

// nawec
class ShopLoadingNawecVend extends ShopStates {}

class ShopSuccessNawecVend extends ShopStates {}

class ShopErrorNawecVend extends ShopStates {}

// airtime
class ShopLoadingAirTime extends ShopStates {}

class ShopSuccessAirTime extends ShopStates {}

class ShopErrorAirTime extends ShopStates {
  String? error;
  ShopErrorAirTime({this.error});
}

class CheckoutInitialState extends ShopStates {}

class CheckoutLoadingState extends ShopStates {}

class CheckoutSuccessState extends ShopStates {}

class CheckoutErrorState extends ShopStates {}

class GroceryInitialState extends ShopStates {}

class GroceryLoadingState extends ShopStates {}

class GrocerySuccessState extends ShopStates {}

class GroceryErrorState extends ShopStates {}

// register\

class ShopRegisterInitialState extends ShopStates {}

class ShopRegisterLoadingState extends ShopStates {}

class ShopRegisterSuccessState extends ShopStates {}

class ShopRegisterErrorState extends ShopStates {}

// login
class ShopLoginInitialState extends ShopStates {}

class ShopLoginLoadingState extends ShopStates {}

class ShopLoginSuccessState extends ShopStates {}

class ShopLoginErrorState extends ShopStates {}

class ShopRegisterChangePasswordVisibilityState extends ShopStates {}
