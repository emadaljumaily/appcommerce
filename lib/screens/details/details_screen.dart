import 'package:appcommerce/models/Data.dart';
import 'package:appcommerce/provider/products.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";
  Future<List<Dataa>> get_list_products(context){
    return Provider.of<Services>(context,listen: false).getPosts();
  }
  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =ModalRoute.of(context).settings.arguments as ProductDetailsArguments ;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      /*appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: agrs.product.rating),
      ),*/
      body: Body(product: agrs.product),

    );
  }
}

class ProductDetailsArguments {
  final Dataa product;
  final int index;

  ProductDetailsArguments({ this.product,this.index});
}
