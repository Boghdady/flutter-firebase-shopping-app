import 'package:firebase_shop_app/core/providers/cart_provider.dart';
import 'package:firebase_shop_app/core/providers/product_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsWidget extends StatelessWidget {
  final ProductModelProvider product;
  final int index;

  ProductDetailsWidget({this.product, this.index});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SizedBox(height: 15.0),
      Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Text(product.title,
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 42.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF17532))),
      ),
      SizedBox(height: 15.0),
      // -------------------------------- Product Image------------------------------- //
      Hero(
          tag: 'tage$index',
          child: Image.network(product.imageUrl,
              height: 150.0, width: 100.0, fit: BoxFit.contain)),
      SizedBox(height: 20.0),
      // -------------------------------- Product Price------------------------------- //
      Center(
        child: Text(product.price.toString(),
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF17532))),
      ),
      SizedBox(height: 10.0),
      // -------------------------------- Product Name ------------------------------- //
      Center(
        child: Text(product.title,
            style: TextStyle(
                color: Color(0xFF575E67),
                fontFamily: 'Varela',
                fontSize: 24.0)),
      ),
      SizedBox(height: 20.0),
      // -------------------------------- Product Description ------------------------------- //
      Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 50.0,
          child: Text(product.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                  color: Color(0xFFB4B8B9))),
        ),
      ),
      SizedBox(height: 20.0),
      // -------------------------------- Btn Add To Cart------------------------------- //
      Consumer<CartProvider>(
        builder: (BuildContext context, CartProvider cart, Widget ch) {
          return Center(
              child: InkWell(
            child: ch,
            onTap: () {
              cart.addItemToCart(
                  product.id, product.title, product.price, product.imageUrl);
            },
          ));
        },
        child: Container(
            width: MediaQuery.of(context).size.width - 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Color(0xFFF17532)),
            child: Center(
                child: Text(
              'Add to cart',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ))),
      ),
    ]);
  }
}
