import 'dart:convert';

import 'package:coffee_masters/dataModel.dart';
import 'package:http/http.dart' as http;

class DataManager {
  List<Category>? _menu;
  List<ItemInCart> cart = [];

  fetchMenu() async {
    const url = "https://firtman.github.io/coffeemasters/api/menu.json";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var body = response.body as dynamic;
      var decodeData = JsonDecoder(body) as List<dynamic>;
      for (var json in decodeData) {
        _menu?.add(Category.fromJson(json));
      }
    }
  }

  Future<List<Category>> getMenu() async {
    if (_menu == null) {
      await fetchMenu();
    }
    return _menu!;
  }

  cartAdd(Product p) {
    bool found = false;
    for (var i in cart) {
      if (i.product.id == p.id) {
        i.quantity++;
        found = true;
      }
      if (!found) {
        cart.add(ItemInCart(p, 1));
      }
    }
  }

  cartRemove(Product p) {
    cart.removeWhere((i) => i.product.id == p.id);
  }

  cartClear() {
    cart.clear();
  }

  double cartTotal() {
    double total = 0;
    for (var i in cart) {
      total += (i.product.price * i.quantity);
    }
    return total;
  }
}
