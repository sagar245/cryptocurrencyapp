import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
 final List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   List currencies;
  final List<MaterialColor> _colors =[Colors.blue,Colors.indigo,Colors.red];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("CryptoApp"),
      ),
      body:  _cryptoWidget(),
    );
  }
  Widget _cryptoWidget(){
   return new Container(
     child: new Column(
       children: <Widget>[
         new Flexible(
           child: new ListView.builder(itemCount: widget.currencies.length,
             itemBuilder: (BuildContext context,int index){
               final Map currency =widget.currencies[index];
               final MaterialColor color=_colors[index % _colors.length];
               return _getListItemUi(currency,color);
             },
           ),
         ),]
     ),
   );
  }
  ListTile _getListItemUi(Map currency,MaterialColor color){
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(currency['name'][0]),
      ),
      title: new Text(currency['name'],
      style: new TextStyle(fontWeight: FontWeight.bold),),
      subtitle: _getSubTitleText(currency['Price_usd'],currency['percent_change_1h']),
      isThreeLine: true,

    );

  }
  Widget _getSubTitleText(String priceUSD,String percentChange){
    TextSpan priceTextWidget=new TextSpan(
      text: "\$$priceUSD\n",style: new TextStyle(color: Colors.black)
    );
    String percentChangeText ="1 hour: $percentChange%";
    TextSpan percentageChangeTextWidget;
    if(double.parse(percentChange)>0){
      percentageChangeTextWidget=new TextSpan(text: percentChangeText,style: new TextStyle(color: Colors.green));
    }
    else{
      percentageChangeTextWidget=new TextSpan(text: percentChangeText,style: new TextStyle(color: Colors.red));
    }
    return new RichText(text: new TextSpan(
      children: [priceTextWidget,percentageChangeTextWidget]
    ));
  }
}
