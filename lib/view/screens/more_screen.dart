import 'package:firebase_shop_app/utils/view/constant_routs.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('My Account', style: Theme.of(context).textTheme.title),
            trailing: Icon(Icons.arrow_forward_ios),
            leading: Icon(Icons.account_circle),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title:
                Text('My Products', style: Theme.of(context).textTheme.title),
            trailing: Icon(Icons.arrow_forward_ios),
            leading: Icon(Icons.shopping_cart),
            onTap: () {
              Navigator.pushNamed(context, myProductsScreenRoute);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Settings', style: Theme.of(context).textTheme.title),
            trailing: Icon(Icons.arrow_forward_ios),
            leading: Icon(Icons.settings),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text('About Us', style: Theme.of(context).textTheme.title),
            trailing: Icon(Icons.arrow_forward_ios),
            leading: Icon(Icons.info),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text('Exist', style: Theme.of(context).textTheme.title),
            trailing: Icon(Icons.arrow_forward_ios),
            leading: Icon(Icons.exit_to_app),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
