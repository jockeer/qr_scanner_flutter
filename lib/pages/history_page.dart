import 'package:flutter/material.dart';
import 'package:qr_app/widgets/scan_list_widget.dart';



class MapasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return ScanListWidget(tipo: 'geo',);
   
  }
}