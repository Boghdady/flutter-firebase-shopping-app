import 'package:firebase_shop_app/core/providers/cart_provider.dart';
import 'package:firebase_shop_app/core/providers/product_model_provider.dart';
import 'package:firebase_shop_app/utils/view/constant_routs.dart';
import 'package:firebase_shop_app/utils/view/screen_args/product_details_args.dart';
import 'package:firebase_shop_app/view/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  final index;

  ProductGridItem(this.index);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductModelProvider>(context, listen: false);

    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                productDetailsRoute,
                arguments: ProductDetailsArgs(id: product.id, index: index),
              );
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      // -------------------------------- Favorite icon -------------------------------- //
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Consumer<ProductModelProvider>(
                              builder: (BuildContext context,
                                  ProductModelProvider value, _) {
                                return IconButton(
                                  icon: value.isFavorite
                                      ? Icon(Icons.favorite,
                                          color: Color(0xFFEF7532))
                                      : Icon(Icons.favorite_border,
                                          color: Colors.grey[600]),
                                  color: Theme.of(context).accentColor,
                                  onPressed: value.changeFavoriteStatus,
                                );
                              },
                            )
                          ])),
                  // -------------------------------- Product Image -------------------------------- //
                  Hero(
                    tag: 'tage$index',
                    child: Container(
                      height: 75.0,
                      width: 130.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  SizedBox(height: 7.0),
                  // -------------------------------- Product price and title -------------------------------- //
                  Text(product.price.toString(),
                      style: TextStyle(
                          color: Color(0xFFCC8053),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Text(product.title,
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                  // -------------------------------- footer section (add to cart)------------------------------- //
                  Consumer<CartProvider>(
                      builder: (BuildContext context, CartProvider cart, _) {
                    if (cart.checkProductAddedToCart(product.id)) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                              child: Icon(Icons.remove_circle_outline,
                                  color: Color(0xFFD17E50), size: 18.0),
                              onTap: () {
                                cart.decreaseNumberOfProductsInCartItem(
                                    product.id);
                                if (cart.numberOfProductsInSingleItem(
                                        product.id) ==
                                    0) {
                                  cart.removeItemFromCart(product.id);
                                }
                              }),
                          Text(
                              cart
                                  .numberOfProductsInSingleItem(product.id)
                                  .toString(),
                              style: TextStyle(
                                  fontFamily: 'Varela',
                                  color: Color(0xFFD17E50),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0)),
                          InkWell(
                            child: Icon(Icons.add_circle_outline,
                                color: Color(0xFFD17E50), size: 18.0),
                            onTap: () {
                              cart.increaseNumberOfProductsInCartItem(
                                  product.id);
                            },
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(Icons.shopping_basket,
                              color: Color(0xFFD17E50), size: 16.0),
                          InkWell(
                            child: Text('Add to cart',
                                style: TextStyle(
                                    fontFamily: 'Varela',
                                    color: Color(0xFFD17E50),
                                    fontSize: 14.0)),
                            onTap: () {
                              cart.addItemToCart(product.id, product.title,
                                  product.price, product.imageUrl);
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Added it to cart!'),
                                  duration: Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'UNDO',
                                    onPressed: () {
                                      cart.removeItemFromCart(product.id);
                                    },
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      );
                    }
                  })
                ]))));
  }
}
