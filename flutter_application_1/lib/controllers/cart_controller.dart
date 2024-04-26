import 'package:flutter_application_1/model/cart_model.dart';
import 'package:flutter_application_1/model/product_model.dart';

class CartController {
  final CartModel cartModel;

  CartController({required this.cartModel});

  List<Product> viewCart() {
    final products = cartModel.products;

    return products;
  }

  void clearCart() {
    cartModel.clearCart();
    print('Cart cleared.');
  }
}
