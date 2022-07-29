import 'package:coffee_masters/dataManager.dart';
import 'package:coffee_masters/dataModel.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final DataManager dataManager;
  const MenuPage({Key? key, required this.dataManager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: ((context, snapshot) {
      if (snapshot.hasData) {
        // has data
        var categories = snapshot.data! as List<Category>;
        return ListView.builder(itemCount: categories.length,itemBuilder: ((context, index) {
          return Text(categories[index].name);
        }));
      } else {
        if (snapshot.hasError) {
          // no data, error
          return const Text("Error");
        } else {
          // no data, loading
          return const CircularProgressIndicator();
        }
      }
    }));
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final Function onAdd;

  const ProductItem({Key? key, required this.product, required this.onAdd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("images/black_coffee.png"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("\$${product.price}"),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ElevatedButton(
                      onPressed: () {
                        onAdd(product);
                      },
                      child: const Text("Add")),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
