class CartModel {
  late bool loaded;
  List<Product> products = [];
  List<Product> cart = [];

  // total
  double total() {
    double response = 0;
    products.forEach((element) {
      response += double.parse(element.price) * double.parse(element.quantity);
    });

    void editQuantity(int value, String id) {
      products.forEach((element) {
        if (element.id == id) {
          element.quantity(value);
        }
      });
    }

    return response;
  }

  void addItem(Product val, bool cartItem) {
    if (cartItem) {
      cart.add(val);
    } else {
      print("adding item");
      products.add(val);
    }
    loaded = true;
  }

  void removeItem(Product val, bool cartItem) {
    if (cartItem) {
      cart.remove(val);
    } else {
      print("removing item");
      products.remove(val);
    }
    if (products.length < 0) loaded = false;
  }
}

class Product {
  late dynamic _quantity = 1;

  dynamic get quantity => _quantity;

  set quantity(dynamic quantity) {
    _quantity += quantity;
  }

  late dynamic id;
  dynamic price;
  String? image;
  String? name;
  dynamic? active;
  dynamic? type;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    price = json['price'];
    type = json['type'];
    active = json['active'];
    image = json['img'];
    name = json['name'];
    description = json['description'];
  }
}
