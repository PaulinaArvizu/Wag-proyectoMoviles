import 'package:flutter/material.dart';
import 'package:wag_proyecto_moviles/cart/cart.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:wag_proyecto_moviles/models/product_item_cart.dart';
import 'package:wag_proyecto_moviles/models/product_repository.dart';
import 'package:wag_proyecto_moviles/profile/profile.dart';
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
        backgroundColor: background,
        // appBar: AppBar(
        //   backgroundColor: primary,
        //   centerTitle: true,
        //   title: Text(
        //     "Wag",
        //     style: TextStyle(
        //       fontFamily: 'Sofia Pro Bold',
        //       fontSize: 24,
        //     ),
        //   ),
        //   actions: <Widget>[
        //     IconButton(
        //       icon: Icon(
        //         Icons.search,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {},
        //     ),
        //     IconButton(
        //         icon: Icon(
        //           Icons.shopping_cart,
        //           color: Colors.white,
        //         ),
        //         onPressed: () {
        //           _openCartPage();
        //         }),
        //   ],
        // ),
        body: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/Logo wag.png",
                    height: 100,
                  ),
                  Text(
                    "WAG",
                    style: TextStyle(
                      fontFamily: 'Roboto Black Italic',
                      fontSize: 46,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              // aqui empiezan los posts
              child: ListView(
                children: <Widget>[
                  Container(
                    //este container es un post
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: <Widget>[
                            SizedBox(width: 15),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage("assets/images/cassie.jpeg"),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Cassie Donk",
                              style: TextStyle(
                                fontFamily: "Proxima Nova Bold",
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          child: Image.asset("assets/images/perrito feliz.jpg"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: Colors.black,
                                size: 25,
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(width: 300),
                            IconButton(
                              icon: Icon(
                                Icons.info_outline,
                                color: Colors.black,
                                size: 25,
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name:",
                                  style: TextStyle(
                                    fontFamily: "Poppins Bold",
                                    color: primary,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Size:",
                                  style: TextStyle(
                                    fontFamily: "Poppins Bold",
                                    color: primary,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Age (aprox.):",
                                  style: TextStyle(
                                    fontFamily: "Poppins Bold",
                                    color: primary,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Perritu",
                                  style: TextStyle(
                                    fontFamily: "Poppins Regular",
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Grande",
                                  style: TextStyle(
                                    fontFamily: "Poppins Regular",
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "3 años",
                                  style: TextStyle(
                                    fontFamily: "Poppins Regular",
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Text(
                            "Mucho texto mucho texto mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto ",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                  Container(
                    //este container es un post
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: <Widget>[
                            SizedBox(width: 15),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage("assets/images/cassie.jpeg"),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Cassie Donk",
                              style: TextStyle(
                                fontFamily: "Proxima Nova Bold",
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          child: Image.asset("assets/images/perrito feliz.jpg"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: Colors.black,
                                size: 25,
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(width: 300),
                            IconButton(
                              icon: Icon(
                                Icons.info_outline,
                                color: Colors.black,
                                size: 25,
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name:",
                                  style: TextStyle(
                                    fontFamily: "Poppins Bold",
                                    color: primary,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Size:",
                                  style: TextStyle(
                                    fontFamily: "Poppins Bold",
                                    color: primary,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Age (aprox.):",
                                  style: TextStyle(
                                    fontFamily: "Poppins Bold",
                                    color: primary,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Perritu",
                                  style: TextStyle(
                                    fontFamily: "Poppins Regular",
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Grande",
                                  style: TextStyle(
                                    fontFamily: "Poppins Regular",
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "3 años",
                                  style: TextStyle(
                                    fontFamily: "Poppins Regular",
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Text(
                            "Mucho texto mucho texto mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto ",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
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
              _openHomePage();
            } else if (_selectedIndex == 1) {
              //open new page
            } else if (_selectedIndex == 2) {
              _openStorePage();
            } else if (_selectedIndex == 3) {
              _openProfilePage();
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
          productsList: ProductRepository.loadProducts().map(
            (product) {
              return new ProductItemCart(
                productTitle: product.productTitle,
                productImage: product.productImage,
                productAmount: 0,
                productPrice: product.productPrice,
              );
            },
          ).toList(),
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

  void _openProfilePage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Profile();
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
