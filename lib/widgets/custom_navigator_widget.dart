import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/providers/ui_provider.dart';


class CustomNavigatorWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);
    
    final currentIndex = uiProvider.selectedMenuOpt;
    return BottomNavigationBar(
      // elevation: 8.0,
      onTap: (int i){
        uiProvider.selectedMenuOpt = i; 
      },
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Mapa'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Direcciones'
        ),
      ],

    );
  }
}