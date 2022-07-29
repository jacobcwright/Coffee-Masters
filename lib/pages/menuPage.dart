import 'package:coffee_masters/dataManager.dart';
import 'package:coffee_masters/dataModel.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final DataManager dataManager;

  const MenuPage({Key? key, required this.dataManager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<Category>>(
        future: dataManager.getMenu(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  // EACH CATEGORY STARTS HERE
                  var category = snapshot.data![index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 32.0, bottom: 8.0, left: 8.0),
                        child: Text(
                          category.name,
                          style: TextStyle(color: Colors.brown.shade400),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: category.products.length,
                        itemBuilder: (context, index) {
                          return ProductItem(
                            product: category.products[index],
                            onAdd: (p) {
                              dataManager.cartAdd(p);
                            },
                          );
                        },
                      )
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
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
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            Image.network(product.imageUrl),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("\$${product.price.toStringAsFixed(2)} ea"),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        onAdd(product);
                      },
                      child: const Text("Add"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
