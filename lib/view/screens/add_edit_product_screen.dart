import 'package:firebase_shop_app/core/providers/product_model_provider.dart';
import 'package:firebase_shop_app/core/providers/products_provider.dart';
import 'package:firebase_shop_app/utils/view/ui_spacing_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEditProductScreen extends StatefulWidget {
  final productId;
  AddEditProductScreen({this.productId});
  @override
  _AddEditProductScreenState createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  // Because i need the url value before the form submitted to preview the image
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String title, description, imageUrl;
  double price;
  ProductModelProvider _product;
  var _isLoaded = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _submitForm() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoaded = true;
    });
//    print('${title} , $price , $description , $imageUrl');
    final editedProduct = ProductModelProvider(
      title: title,
      price: price,
      description: description,
      imageUrl: imageUrl,
      id: widget.productId != 'add'
          ? widget.productId
          : DateTime.now().toString(),
      isFavorite: widget.productId != 'add' ? _product.isFavorite : false,
    );
    if (widget.productId != 'add') {
      // UPDATE PRODUCT
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(widget.productId, editedProduct);
      setState(() {
        _isLoaded = false;
      });
      Navigator.of(context).pop();
    } else {
      // ADD PRODUCT
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(editedProduct)
          .then((_) {
        setState(() {
          _isLoaded = false;
        });
        Navigator.of(context).pop();
      });
    }

//    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.productId != 'add') {
      _product = Provider.of<ProductsProvider>(context, listen: false)
          .findProductById(widget.productId);
      // Because i user controller for image TEXTFIELDFORM
      _imageUrlController.text = _product.imageUrl;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Edit Product'),
      ),
      body: _isLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue:
                            widget.productId != 'add' ? _product.title : '',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          hintText: 'Title',
                          hintStyle: Theme.of(context).textTheme.body2,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2.0,
                            ),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        onSaved: (value) {
                          title = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter title';
                          }
                          return null; // null mean no error
                        },
                      ),
                      UISpacingHelper.verticalSpaceSmall,
                      TextFormField(
                        initialValue: widget.productId != 'add'
                            ? _product.price.toString()
                            : '',
                        focusNode: _priceFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          hintText: 'Price',
                          hintStyle: Theme.of(context).textTheme.body2,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2.0,
                            ),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        onSaved: (value) {
                          price = double.parse(value);
                        },
                      ),
                      UISpacingHelper.verticalSpaceSmall,
                      TextFormField(
                        initialValue: widget.productId != 'add'
                            ? _product.description
                            : '',
                        focusNode: _descriptionFocusNode,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          hintText: 'description',
                          hintStyle: Theme.of(context).textTheme.body2,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2.0,
                            ),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                        onSaved: (value) {
                          description = value;
                        },
                      ),
                      UISpacingHelper.verticalSpaceSmall,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            child: _imageUrlController.text.isEmpty
                                ? Text('Enter a URL')
                                : FittedBox(
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                hintText: 'Image Url',
                                hintStyle: Theme.of(context).textTheme.body2,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 2.0,
                                  ),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ),
                              onFieldSubmitted: (_) {
                                _submitForm();
                              },
                              onSaved: (value) {
                                imageUrl = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      UISpacingHelper.verticalSpaceMedium,
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: RaisedButton(
                          color: Colors.orange,
                          onPressed: _submitForm,
                          child: Text(
                            widget.productId != 'add' ? 'Save' : 'Add',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      UISpacingHelper.verticalSpaceMedium,
                      _btnDelete(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _btnDelete() {
    if (widget.productId != 'add') {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: RaisedButton(
          color: Colors.red,
          onPressed: () {
            Provider.of<ProductsProvider>(context, listen: false)
                .deleteProduct(widget.productId);
            Navigator.of(context).pop();
          },
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
