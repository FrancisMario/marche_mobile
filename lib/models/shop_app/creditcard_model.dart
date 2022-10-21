class CreditCardModel {
  late bool status;
  late CreditCardDataModel data;
  CreditCardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CreditCardDataModel.fromJson(json['data']);
  }
}

class CreditCardDataModel {
  List<CardsModel> cards = [];
  CreditCardDataModel() {}
  CreditCardDataModel.fromJson(Map<String, dynamic> json) {
    json['cards'].forEach((element) {
      cards.add(CardsModel.fromJson(element));
    });
  }
}

class CardsModel {
  late String id;
  dynamic number;
  dynamic cvv2;
  dynamic date;
  dynamic pin;
  CardsModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    number = json['number'];
    cvv2 = json['ccv2'];
    date = json['date'];
    pin = json['pin'];
  }
}
