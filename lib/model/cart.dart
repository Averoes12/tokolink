import 'package:flutter_cart/flutter_cart.dart';

class Cart {
  var message;

  /// Creating the instance of flutter cart package.
  var cart = FlutterCart();

  /// sample function
  void addToCart(dynamic _product, int qty) => {
    message = cart.addToCart(
        productId: _product.idProduct,
        unitPrice: int.parse( _product.price),
        quantity:qty,
        productDetailsObject: _product),
  };

  /// This function is used to decrement the item quantity from cart
  void removeItemFromCart(int index) => {
    cart.decrementItemFromCart(index),
  };
  /// This function is used to increment the item quantity into cart
  void addItemToCart(int index) {
    cart.incrementItemToCart(index);
  }
  void remove() {
    cart = FlutterCart();
  }
  void total(){
      return cart.getCartItemCount();
  }
}