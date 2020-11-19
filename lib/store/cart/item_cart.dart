import 'package:flutter/material.dart';
import 'package:wag_proyecto_moviles/models/product_item_cart.dart';

class ItemCart extends StatefulWidget {
  final ProductItemCart item;
  final ValueChanged<double> onAmountUpdated;
  ItemCart({
    Key key,
    @required this.onAmountUpdated,
    @required this.item,
  }) : super(key: key);

  @override
  _ItemCartState createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 90 / 120,
                child: SizedBox(
                  child: Image.network(
                    widget.item.productImage,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.productTitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "\$${widget.item.productPrice.toStringAsFixed(2)} MXN",
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.delete),
                        SizedBox(height: 50),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle),
                              onPressed: () {},
                            ),
                            Text(widget.item.productAmount.toString()),
                            IconButton(
                              icon: Icon(Icons.add_circle),
                              onPressed: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addProd() {
    setState(() {
      ++widget.item.productAmount;
    });
    widget.onAmountUpdated(widget.item.productPrice);
  }

  void _remProd() {
    setState(() {
      --widget.item.productAmount;
      if (widget.item.productAmount <= 0) widget.item.productAmount = 0;
    });
    widget.onAmountUpdated(-1 * widget.item.productPrice);
  }
}
