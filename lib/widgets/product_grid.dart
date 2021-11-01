import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/widgets/product_grid_item.dart';

class ProductGrid extends StatelessWidget {

  bool  _showFavoriteOnly;

  ProductGrid(this._showFavoriteOnly);
  
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ProductList>(context);
    final loadedProducts =  _showFavoriteOnly ? provider.favoriteItems : provider.items;

    return  GridView.builder(
      padding: EdgeInsets.all(5),
      itemCount: loadedProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2 ,
        childAspectRatio: 3/2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: ProductGridItem()));
  }
}
