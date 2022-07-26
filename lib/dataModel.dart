class Product {
  int id;
  String name;
  double price;
  String image;
  String get imageUrl =>
      "https://firtman.github.io/coffeemasters/api/images/$image";

  Product(this.id, this.name, this.price, this.image);
}

class Category {
  String name;
  List<Product> products;

  Category(this.name, this.products);
}

class ItemInCart {
  Product product;
  int quantity;

  ItemInCart(this.product, this.quantity);
}
