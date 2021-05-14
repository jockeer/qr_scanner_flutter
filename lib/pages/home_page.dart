import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_app/pages/direcciones_page.dart';
import 'package:qr_app/pages/history_page.dart';

import 'package:qr_app/providers/scan_list_provider.dart';
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
              Provider.of<ScanListProvider>(context, listen: false).borrarTodos();
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

    //temporal leer BD
    // final tempScan = ScanModel(valor: 'http://google.com');
    // DBProvider.db.nuevoScan(tempScan);
    // DBProvider.db.getScanById(4).then((scan) => print(scan.valor));
    // DBProvider.db.getAllScans().then((scan) => print(scan[0].valor));
    //DBProvider.db.deleteAll();

    //USAR EL SCAN LIST PROVIDER

    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch(currentIndex){
      case 0:
        scanListProvider.cargarScansTipo('geo');
        return MapasPage();
      
      case 1:
        scanListProvider.cargarScansTipo('http');
        return DireccionesPage();

      default:
        return MapasPage();
    } 
  }
}
