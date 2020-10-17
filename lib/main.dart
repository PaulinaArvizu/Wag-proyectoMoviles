import 'package:flutter/material.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wag_proyecto_moviles/inicio/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          backgroundColor: primary,
          primaryColor: primary,
          accentColor: primary,
          fontFamily: "Poppins Regular",
        ),
        home: LogIn()
        // Product(
        //   product: ProductItem(
        //     productTitle: "Signature Chocolate Chip Lactation Cookies",
        //     productDescription:
        //         "We combined the richness of creamy all-natural peanut butter with the goodness of oats into a baked soft and chewy cookie which creates the perfect balance of salty and sweet.",
        //     // "We combined the richness of creamy all-natural peanut butter with the goodness of oats into a baked soft and chewy cookie which creates the perfect balance of salty and sweet.We combined the richness of creamy all-natural peanut butter with the goodness of oats into a baked soft and chewy cookie which creates the perfect balance of salty and sweet.We combined the richness of creamy all-natural peanut butter with the goodness of oats into a baked soft and chewy cookie which creates the perfect balance of salty and sweet.We combined the richness of creamy all-natural peanut butter with the goodness of oats into a baked soft and chewy cookie which creates the perfect balance of salty and sweet.We combined the richness of creamy all-natural peanut butter with the goodness of oats into a baked soft and chewy cookie which creates the perfect balance of salty and sweet.We combined the richness of creamy all-natural peanut butter with the goodness of oats into a baked soft and chewy cookie which creates the perfect balance of salty and sweet.We combined the richness of creamy all-natural peanut butter with the goodness of oats into a baked soft and chewy cookie which creates the perfect balance of salty and sweet.We combined the richness of creamy all-natural peanut butter with the goodness of oats into a baked soft and chewy cookie which creates the perfect balance of salty and sweet.We combined the richness of creamy all-natural peanut butter with the goodness of oats into a baked soft and chewy cookie which creates the perfect balance of salty and sweet.We combined the richness of creamy all-natural peanut butter with the goodness of oats into a baked soft and chewy cookie which creates the perfect balance of salty and sweet.",
        //     productImage:
        //         // "https://images-na.ssl-images-amazon.com/images/I/81zOhh0vRnL._AC_SX522_.jpg",
        //         // "https://http2.mlstatic.com/pet-products-encanto-parches-grande-del-juguete-del-gallo-D_NQ_NP_662116-MLM27025407711_032018-F.jpg",
        //         "https://www.costco.com.mx/medias/sys_master/products/h68/h4c/10764142084126.jpg",
        //     productAmount: 0,
        //     productPrice: 2.55,
        //   ),
        // ),
        );
  }
}
