class AirTimeModel {
  dynamic phone;
  dynamic amount;
  dynamic carrier;
  AirTimeModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    amount = json['amount'];
    carrier = json['carrier'];
  }
}
