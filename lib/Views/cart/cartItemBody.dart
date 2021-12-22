import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hello_mobiles/Widgets/richText.dart';
import 'package:hello_mobiles/Widgets/snackBarSimple.dart';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:hello_mobiles/provider/product.dart';

class ItemCardBody extends StatefulWidget {
  final id;
  final context;
  final itemName;
  final price;
  final image;
  final quantity;

  const ItemCardBody(
      {Key key,
      this.id,
      this.context,
      this.itemName,
      this.price,
      this.image,
      this.quantity})
      : super(key: key);
  @override
  _ItemCardBodyState createState() => _ItemCardBodyState();
}

class _ItemCardBodyState extends State<ItemCardBody> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<ProductData>(context).removeProduct(widget.id);
        showSimpleSnackBar(
          context: context,
          title: "${widget.itemName} deleted from cart",
        );
      },
      background: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Color(0xFFFFE6E6).withOpacity(0.6),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Spacer(),
            Icon(
              FontAwesome.trash,
              color: appColor,
            ),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(1.0),
        child: Material(
          borderRadius: BorderRadius.circular(12.0),
          elevation: 2.0,
          child: Container(
            padding: EdgeInsets.only(left: 7.0, right: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Image.network(
                    widget.image,
                    height: 200.0,
                    width: 140.0,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 8.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 80.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                  text: widget.itemName,
                                ),
                              ),
                            ),
                            richText(
                                simpleText: 'Rs',
                                colorText: widget.price.toString()),
                          ],
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'x' + widget.quantity.toString(),
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
