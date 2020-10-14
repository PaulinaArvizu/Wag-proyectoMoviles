import 'package:wag_proyecto_moviles/models/product_item.dart';
import 'product_item.dart';

class ProductRepository {
  static List<dynamic> loadProducts() {
    return <ProductItem>[
      ProductItem(
        productTitle: 'Taining Treats',
        productDescription: 'Premios para perros de cualquier edad.',
        productAmount: 0,
        productImage:
            'https://www.petco.com.mx/medias/?context=bWFzdGVyfGltYWdlc3wzNDUzOTZ8aW1hZ2UvanBlZ3xpbWFnZXMvaDA2L2hmZC85MjI3NzQ1MDAxNTAyLmpwZ3w5ZGQyYjUwZGU3YzUxODIzNjFlZTQzNjkyZDk1Yjc4MGU1MGIxYTk1MDZiMjhiMGJjM2EzZWZhN2FmYmFhMTc1',
        productSize: ProductSize.M,
        productPrice: 100,
      ),
    ];
  }
}
