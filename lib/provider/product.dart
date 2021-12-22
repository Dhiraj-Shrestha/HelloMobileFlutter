import 'package:flutter/foundation.dart';
import 'package:hello_mobiles/models/ProductsModel.dart';

class ProductData extends ChangeNotifier {
  List<ProductModel> _product = [];
  int _totalAmount = 0;
  int _totalItems = 0;
  int _totalDiscount = 0;
  int _totalSp = 0;

  // make it true if product found i n cart
  bool flag = false;
  int index = 0;
  void addProduct(
      {String id,
      String name,
      int price,
      int quantity,
      String image,
      int sellingPrice}) {
    // chek if productlist list contain any product inside it

    // apply prime number cocept
    if (_product.length == 0) {
      _totalItems++;
      _product.add(ProductModel(
          id: id,
          name: name,
          price: price,
          quantity: quantity,
          image: image,
          sellingPrice: sellingPrice));
      _product[0].amount = quantity * price;
      _product[0].sp = quantity * sellingPrice;
      _product[0].productDiscount = quantity * (price - sellingPrice);
      _totalAmount = _totalAmount + _product[0].amount;
      _totalSp = _totalSp + _product[0].sp;
      _totalDiscount = _totalDiscount + _product[0].productDiscount;
    } else {
      for (var product in _product) {
        if (product.id == id) {
          flag = true;
          break;
        }
        index++;
      }
      if (flag == true) {
        _product[index].quantity = _product[index].quantity + quantity;
        _product[index].amount = _product[index].quantity * price;
        _product[index].sp = _product[index].quantity * sellingPrice;
        _product[index].productDiscount =
            _product[index].quantity * (price - sellingPrice);
        // _product[index].discount =
        //     _product[index].quantity * (price - sellingPrice);
        _totalAmount = _totalAmount + (quantity * price);
        _totalSp = _totalSp + (quantity * sellingPrice);
        _totalDiscount = _totalDiscount + (quantity * (price - sellingPrice));
        index = 0;
        flag = false;
      } else {
        _totalItems++;
        _product.add(ProductModel(
          id: id,
          name: name,
          price: price,
          quantity: quantity,
          image: image,
          sellingPrice: sellingPrice,
        ));
        _product[index].amount = quantity * price;
        _product[index].sp = quantity * sellingPrice;
        _product[index].productDiscount = quantity * (price - sellingPrice);
        // _product[index].discount = quantity * discount;
        _totalAmount = _totalAmount + _product[index].amount;
        _totalSp = _totalSp + _product[index].sp;
        _totalDiscount = _totalDiscount + _product[index].productDiscount;
        // (price - sellingPrice);
        index = 0;
        flag = false;
      }
    }
    notifyListeners();
  }

  /// [removeFromCart] removes items from the cart, back to the shop
  void removeProduct(String id) {
    // _product.remove(item);
    for (var product in _product) {
      if (product.id == id) {
        flag = true;
        break;
      }
      index++;
    }
    if (flag == true) {
      _totalItems--;
      _totalAmount = _totalAmount - _product[index].amount;
      _totalSp = _totalSp - _product[index].sp;
      _totalDiscount = _totalDiscount - _product[index].productDiscount;
      _product.remove(_product[index]);
    }
    index = 0;
    flag = false;

    notifyListeners();
  }

  int get totalItems {
    return _totalItems;
  }

  int get totalAmount {
    return _totalAmount;
  }

  int get totalSp {
    return _totalSp;
  }

  int get totalDiscount {
    return _totalDiscount;
  }

  List<ProductModel> get product {
    return _product;
  }
}
