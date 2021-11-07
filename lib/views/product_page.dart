import 'package:flutter/material.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/product_item.dart';

class ProductPage extends StatelessWidget {

  Future<void> _pullToRefresh(BuildContext context){
    return Provider.of<ProductList>(context, listen: false).loadProducts();
  }

  
  @override
  Widget build(BuildContext context) {

   var products = Provider.of<ProductList>(context);
   
   var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
   
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
      body: RefreshIndicator(
        onRefresh: ()=> _pullToRefresh(context),
              child: Padding(
          padding:  EdgeInsets.all(width*0.01),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (ctx, i)=> Column(
              children: [
                ProductItem(product: products.items[i], ),
                Divider(),
              ],
            ),
            ),
        ),
      ),
    );
  }
}