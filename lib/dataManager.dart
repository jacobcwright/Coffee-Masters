import 'package:coffee_masters/dataModel.dart';

class DataManager {
  List<Category>? _menu;
  List<ItemInCart> cart = [];

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
