import 'package:flutter/material.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/product_item.dart';

class ProductPage extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {

   var products = Provider.of<ProductList>(context, listen: false);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
             onPressed: (){
               Navigator.of(context).pushNamed(AppRoutes.FORM);
             })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (ctx, i)=> Column(
            children: [
              ProductItem(product: products.items[i]),
              Divider(),
            ],
          ),
          ),
      ),
    );
  }
}