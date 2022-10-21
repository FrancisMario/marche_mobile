class NawecModel {
  dynamic meterno;
  dynamic amount;
  NawecModel.fromJson(Map<String, dynamic> json) {
    meterno = json['meterno'];
    amount = json['amount'];
  }
}
