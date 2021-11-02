import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/drawer.dart';


class ProductFormPage extends StatefulWidget {
  

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
 
 final _priceFocus = FocusNode();
 final _descriptionFocus = FocusNode();
 final _imageUrlFocus = FocusNode();
 final _imageController = TextEditingController(); 

 final _formKey = GlobalKey<FormState>();

 final _formData = Map<String,Object>();
 
 
  
  @override
  void initState() {
    _imageController.addListener(()=>setState((){}));
    super.initState();
  }

  @override
  void dispose() {
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageController.removeListener(()=>setState((){}));
    super.dispose();
  }
 
  void submitedForm(){
    final isValid =_formKey.currentState?.validate() ?? false;

    if(!isValid){
      return print('Formulário inválido');
    }

    _formKey.currentState?.save();
    final newProduct = Product(
      name: _formData['name'], 
      id: Random().nextDouble().toString(), 
      description: _formData['description'], 
      price: _formData['price'] as double, 
      imageUrl: _formData['urlImage']);

    print(newProduct.name);
    print(newProduct.id);
    print(newProduct.description);
    print(newProduct.price);
    print(newProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save), 
            onPressed:(){
              submitedForm();
              })
        ],
        title: Text("Formulário")
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key:  _formKey,
          child: ListView(
        children: [
          TextFormField(
            validator: (name){
              if(name.trim().isEmpty){
                return 'Coloque um nome';
              }if(name.trim().length <= 3){
                return 'Tamanho curto';
              }
              return null;
            },
            decoration: InputDecoration(labelText: 'Nome'),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_priceFocus);
            },
            onSaved: (name) => _formData['name'] = name ?? '',
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Preço'),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            focusNode: _priceFocus,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_descriptionFocus);
            },
            onSaved: (price) => _formData['price'] = double.parse(price ?? '0'),
          ),
           TextFormField(
            decoration: InputDecoration(labelText: 'Descrição'),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            focusNode: _descriptionFocus,
            onSaved: (description) => _formData['description'] = description ?? '',
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                  validator: (url){
                    if(!url.contains('https://')){
                      return 'Url Inválida';
                    }
                    return null;
                  } ,
                  decoration: InputDecoration(labelText: 'Url da imagem'),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.url,
                  focusNode: _imageUrlFocus,
                  controller: _imageController,
                  onSaved: (urlImage) => _formData['urlImage'] = urlImage ?? '',
                  onFieldSubmitted: (_)=> submitedForm(),
                ),
                              ),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(width: 2)
                ),
                child: _imageController.text.isEmpty? Center(child: Text('Informe URL')):
                 FittedBox(
                   child: Image.network(_imageController.text),
                   fit: BoxFit.cover,
                   ),
               
              )
            ],
          )
        ],
          )
          ),
      ) ,
    );
  }
}