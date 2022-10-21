import 'package:marche/shared/networks/local/cache_helper.dart';

class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;
  ShopLoginModel.fromJson(json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
    CacheHelper.saveData(key: 'token', value: data!.token);
  }
}

class UserData {
  String? id;
  String? name;
  String? email;
  String? phone;
  int? point;
  int? credit;
  String? token;

  // named constructor
  UserData.fromJson(json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    point = json['point'];
    credit = json['credit'];
    token = json['token'];
  }
}
