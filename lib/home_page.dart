import 'package:flutter/material.dart';
import 'package:wag_proyecto_moviles/cart/cart.dart';
import 'package:wag_proyecto_moviles/models/product_item_cart.dart';

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
          title: Text('Material App Bar'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: _openCartPage,
            )
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
              icon: Icon(Icons.search),
              label: 'Search',
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
          selectedItemColor:
              Colors.amber[800], //TODO: SelectedItemColor: primary
          unselectedItemColor: Colors.grey,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
            if (_selectedIndex == 1) {
              //TODO: open search page?
            } else if (_selectedIndex == 2) {
              //TODO: open new page
            } else if (_selectedIndex == 3) {
              //TODO: open store page
            } else if (_selectedIndex == 4) {
              //TODO: open profile page
            }
          },
        ),
      ),
    );
  }

  //TODO: freate voids to open each page
  void _openCartPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Cart(
          productsList: productList,
        );
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
