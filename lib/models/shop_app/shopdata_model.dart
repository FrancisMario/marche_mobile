class ShopModel {
  List<LocationDataModel> locations = [];

  ShopModel.fromJson(List json) {
    print("-----------------------");
    print(json);
    json.forEach((v) {
      print("==================");
      print(v);
      locations.add(LocationDataModel.fromJson(v));
    });
  }
}

class LocationDataModel {
  List<ShopsDataModel> shops = [];
  String? name;
  String? id;

  LocationDataModel.fromJson(Map<String, dynamic> json) {
    print("------------!!!!!!!!!!!!------------");
    json['shops'].forEach((v) {
      shops.add(ShopsDataModel.fromJson(v));
    });
    name = json['name'];
    id = json['_id'];
  }
}

class ShopsDataModel {
  String? id;
  String? name;
  String? owner;
  List<ItemDataModel> items = [];

  ShopsDataModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    owner = json['owner'];
    json['items'].forEach((v) {
      items.add(ItemDataModel.fromJson(v));
    });
  }
}

class ItemDataModel {
  String? id;
  dynamic? price;
  String? image;
  String? name;
  String? description;
  int quantity = 1;

  ItemDataModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    price = json['price'];
    image = json['img'];
    name = json['name'];
    description = json['description'];
  }
}
