import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/pages/direcciones_page.dart';
import 'package:qr_app/pages/history_page.dart';
import 'package:qr_app/providers/ui_provider.dart';
import 'package:qr_app/widgets/custom_navigator_widget.dart';
import 'package:qr_app/widgets/scan_button_widget.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){

            },
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigatorWidget(),
      floatingActionButton: ScanButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //obtener el selected menu opt

    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;
    switch(currentIndex){
      case 0:
        return HistoryPage();
      
      case 1:
        return DireccionesPage();

      default:
        return HistoryPage();
    } 
  }
}