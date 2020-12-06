import 'package:firebase_shop_app/core/providers/product_model_provider.dart';
import 'package:firebase_shop_app/core/providers/products_provider.dart';
import 'package:firebase_shop_app/utils/view/constant_routs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Products"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
              child: ListView.separated(
            itemBuilder: (ctx, index) {
              return productItem(productsData.products[index], context);
            },
            itemCount: productsData.products.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 0.8,
              );
            },
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
                // color: Theme.of(context).accentColor,
                onPressed: () {
                  // Go to add product
                  Navigator.of(context)
                      .pushNamed(addEditProductScreenRoute, arguments: 'add');
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Draw productItem
  Widget productItem(ProductModelProvider product, BuildContext context) {
    return ListTile(
      title: Text(product.title, style: Theme.of(context).textTheme.title),
      subtitle: Text(
        product.description,
        maxLines: 1,
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey[500],
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
        radius: 24,
      ),
      trailing: Text(
        product.price.toString(),
      ),
      onTap: () {
        // Go to edit product
        Navigator.of(context)
            .pushNamed(addEditProductScreenRoute, arguments: product.id);
      },
    );
  }
}
