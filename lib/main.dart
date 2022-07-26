import 'package:flutter/material.dart';

import 'dataManager.dart';
import 'pages/menuPage.dart';
import 'pages/offersPage.dart';
import 'pages/orderPage.dart';

void main() {
  runApp(const MyApp());
}

class HelloWorld extends StatelessWidget {
  const HelloWorld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Hello World');
  }
}

class Greet extends StatefulWidget {
  const Greet({Key? key}) : super(key: key);

  @override
  State<Greet> createState() => _GreetState();
}

class _GreetState extends State<Greet> {
  var name = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Hello $name", style: const TextStyle(fontSize: 64)),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: TextField(
              onChanged: (value) => setState(() {
                    name = value;
                  })),
        )
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Masters',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var dataManager = DataManager();
  var selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    Widget currentWidgetPage = const Text("Hello World");

    switch (selectedIndex) {
      case 0:
        // currentWidgetPage = const Text("Menu Page");
        currentWidgetPage = MenuPage(
          dataManager: dataManager,
        );
        break;
      case 1:
        currentWidgetPage = OffersPage();
        break;
      case 2:
        // currentWidgetPage = const Text("Orders Page");
        currentWidgetPage = OrderPage(
          dataManager: dataManager,
        );
        break;
    }

    return Scaffold(
        appBar: AppBar(
          title: Image.asset('images/logo.png'),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (newIndex) {
              setState(() {
                selectedIndex = newIndex;
              });
            },
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Colors.amber.shade400,
            unselectedItemColor: Colors.brown.shade50,
            items: const [
              BottomNavigationBarItem(label: "Menu", icon: Icon(Icons.coffee)),
              BottomNavigationBarItem(
                  label: "Offers", icon: Icon(Icons.local_offer)),
              BottomNavigationBarItem(
                  label: "Order",
                  icon: Icon(Icons.shopping_cart_checkout_rounded)),
            ]),
        body: currentWidgetPage);
  }
}
