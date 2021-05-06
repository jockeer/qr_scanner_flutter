import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/providers/ui_provider.dart';
import 'package:qr_app/routes/routets.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      
      providers: [
        ChangeNotifierProvider(create: ( context )=> UiProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Scanner',
        initialRoute: 'home',
        routes: getApplicationRoutes(),
        theme: ThemeData(
          primaryColor: Colors.indigo[800],
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple
          )
        ),
      ),
    );
  }
}