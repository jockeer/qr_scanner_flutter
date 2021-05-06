import 'package:flutter/material.dart';
import 'package:qr_app/pages/home_page.dart';
import 'package:qr_app/pages/mapa_page.dart';


Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    'home': (BuildContext context) => HomePage(),
    'mapa': (BuildContext context) => MapaPage()
  };
}