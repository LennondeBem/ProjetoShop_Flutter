import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/widgets/drawer.dart';


class ProductFormPage extends StatefulWidget {
  

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {


 bool isLoading = false;
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
  void didChangeDependencies() {
    if(_formData.isEmpty){
      final arg = ModalRoute.of(context)?.settings.arguments;
      if(arg != null){
        final product = arg as Product;
        _formData['id'] = product.id;
         _formData['name'] = product.name;
          _formData['price'] = product.price;
           _formData['description'] = product.description;
            _formData['imageUrl'] = product.imageUrl;

            _imageController.text = _formData['imageUrl']; 


      }
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageController.removeListener(()=>setState((){}));
    super.dispose();
  }
 
   Future<void> submitedForm() async {
    final isValid =_formKey.currentState?.validate() ?? false;
    if(!isValid){
      return print('Formulário inválido');
    }
    _formKey.currentState?.save();
    setState(() {
                isLoading = true;
              });
     
     try{
       await Provider.of<ProductList>(context, listen: false).saveProduct(_formData);
         setState(() {
              isLoading = false;
              });
      Navigator.of(context).pop();    
     }
     catch (error){
       print(error.toString());
         showDialog(context: context,
         builder: (context) => AlertDialog(
           title: Text('Erro inesperado'),
           content: Text('Desculpe-nos pelo transtorno, comunique este erro aos nossos desenvolvedores!'),
           actions: [
             TextButton(
               onPressed: (){
                //  setState(() {
                //    isLoading = false;
                //  });  Alternativa para setar o Loading pra falso, fora do 'finally'!
                 Navigator.of(context).pop();
               },
              child: Text('Comunicar erro!'))
           ],
         )
         );
     } finally{
      setState(() {
                   isLoading = false;
                 });
     }
     
        
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
      body: isLoading? Center(child: CircularProgressIndicator()): Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key:  _formKey,
          child: ListView(
        children: [
          TextFormField(
            initialValue: _formData['name']?.toString(),
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
            initialValue: _formData['price']?.toString(),
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
             initialValue: _formData['description']?.toString(),
            decoration: InputDecoration(labelText: 'Descrição'),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            validator: (description){
              if(description.trim().isEmpty){
                return 'Coloque uma Descrição';
              }if(description.trim().length <= 3){
                return 'Tamanho curto';
              }
              return null;
            },
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