import 'package:flutter/material.dart';
import 'package:wag_proyecto_moviles/cart/cart.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:wag_proyecto_moviles/models/product_item_cart.dart';
import 'package:wag_proyecto_moviles/store/store.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<ProductItemCart> productList = new List<ProductItemCart>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Wag",
            style: TextStyle(
              fontFamily: 'Sofia Pro Bold',
              fontSize: 24,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  _openCartPage();
                }),
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              child: Text('Aqui va un post'),
            ),
            Container(
              child: Text('Aqui va un post'),
            ),
            Container(
              child: Text('Aqui va un post'),
            ),
            Container(
              child: Text('Aqui va un post'),
            ),
            Container(
              child: Text('Aqui va un post'),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              label: 'New',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: primary,
          unselectedItemColor: Colors.grey,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
            if (_selectedIndex == 0) {
              //TODO: open homepage
            } else if (_selectedIndex == 1) {
              //open new page
            } else if (_selectedIndex == 2) {
              _openStorePage();
            } else if (_selectedIndex == 3) {
              //TODO: open profile page
            }
          },
        ),
      ),
    );
  }

  //TODO: create voids to open each page

  void _openHomePage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return HomePage();
      }),
    );
  }

  void _openCartPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Cart(
          productsList: productList,
        );
      }),
    );
  }

  void _openStorePage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Store();
      }),
    );
  }

  // Widget navBar(int _selectedIndex) {
  //   return BottomNavigationBar(
  //     items: <BottomNavigationBarItem>[
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.home),
  //         label: 'Home',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.search),
  //         label: 'Search',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.add_circle),
  //         label: 'New',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.storefront),
  //         label: 'Store',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.person),
  //         label: 'Profile',
  //       ),
  //     ],
  //     currentIndex: _selectedIndex,
  //     //selectedItemColor: primary,
  //     unselectedItemColor: Colors.grey,
  //     onTap: (int index) {
  //       //TODO: preguntar que procede aqui
  //       setState(() {
  //         _selectedIndex = index;
  //       });
  //     },
  //   );
  //}
}
