import 'package:flutter/material.dart';
import 'package:shop/models/orders_item.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/views/cart_page.dart';
import 'package:shop/views/orders_page.dart';
import 'package:shop/views/product_overview_page.dart';
import 'utils/app_routes.dart';
import 'views/product_detail_page.dart';
import 'package:provider/provider.dart';
import 'models/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ProductList()),
            ChangeNotifierProvider(create: (_) => Cart()),
            ChangeNotifierProvider(create: (_) => OrderItem()),
            
          ],
          child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Minha loja',
          theme: ThemeData(
      
      primarySwatch: Colors.pink,
      accentColor: Colors.deepOrange,
      
      visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routes: {
          AppRoutes.HOME : (ctx) => ProductOverviewPage(),
          AppRoutes.PRODUCT_DETAIL : (ctx) => ProductDetail(),
          AppRoutes.CART : (ctx) => CartPage(),
          AppRoutes.ORDERS : (ctx) => OrderPage(),
          },
        ),
    );
  }
}
