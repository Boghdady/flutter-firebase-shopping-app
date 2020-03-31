import 'package:firebase_shop_app/utils/view/screen_args/product_details_args.dart';
import 'package:firebase_shop_app/view/screens/add_edit_product_screen.dart';
import 'package:firebase_shop_app/view/screens/cart_screen.dart';
import 'package:firebase_shop_app/view/screens/my_products_screen.dart';
import 'package:firebase_shop_app/view/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import '../../utils/view/constant_routs.dart';
import '../../view/screens/products_overview_screen.dart';
import '../../view/screens/un_defined_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case productsOverviewRoute:
        return MaterialPageRoute(builder: (_) => ProductsOverviewScreen());
      case productDetailsRoute:
        ProductDetailsArgs args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(
                  productId: args.id,
                  index: args.index,
                ));
      case cartScreenRoute:
      case cartScreenRoute:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case myProductsScreenRoute:
        return MaterialPageRoute(builder: (_) => MyProductsScreen());
      case addEditProductScreenRoute:
        final productId = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => AddEditProductScreen(productId: productId));
      default:
        return MaterialPageRoute(
          builder: (context) => UndefinedScreen(
            name: settings.name,
          ),
        );
    }
  }
}
