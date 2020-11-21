import 'package:wag_proyecto_moviles/models/product_item.dart';
import 'product_item.dart';

class ProductRepository {
  static List<ProductItem> loadProducts() {
    return <ProductItem>[
      ProductItem(
        productTitle: 'Taining Treats',
        productDescription: 'Premios para perros de cualquier edad.',
        productAmount: 0,
        productImage:
            'https://www.petco.com.mx/medias/?context=bWFzdGVyfGltYWdlc3wzNDUzOTZ8aW1hZ2UvanBlZ3xpbWFnZXMvaDA2L2hmZC85MjI3NzQ1MDAxNTAyLmpwZ3w5ZGQyYjUwZGU3YzUxODIzNjFlZTQzNjkyZDk1Yjc4MGU1MGIxYTk1MDZiMjhiMGJjM2EzZWZhN2FmYmFhMTc1',
        productPrice: 100,
      ),
      ProductItem(
        productTitle: 'Taining Treats',
        productDescription: 'Premios para perros de cualquier edad.',
        productAmount: 0,
        productImage:
            'https://images-na.ssl-images-amazon.com/images/I/81zOhh0vRnL._AC_SX522_.jpg',
        productPrice: 100,
      ),
      ProductItem(
        productTitle: 'Taining Treats',
        productDescription: 'Premios para perros de cualquier edad.',
        productAmount: 0,
        productImage:
            'https://http2.mlstatic.com/pet-products-encanto-parches-grande-del-juguete-del-gallo-D_NQ_NP_662116-MLM27025407711_032018-F.jpg',
        productPrice: 100,
      ),
      ProductItem(
        productTitle: 'Taining Treats',
        productDescription: 'Premios para perros de cualquier edad.',
        productAmount: 0,
        productImage:
            'https://www.costco.com.mx/medias/sys_master/products/h68/h4c/10764142084126.jpg',
        productPrice: 100,
      ),
    ];
  }
}
