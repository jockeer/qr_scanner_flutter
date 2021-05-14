import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/providers/scan_list_provider.dart';
import 'package:qr_app/utils/utils.dart';

class ScanListWidget extends StatelessWidget {
  
  final String tipo;

  const ScanListWidget({ @required this.tipo});

  @override
  Widget build(BuildContext context) {
    
    final scanListProvider = Provider.of<ScanListProvider>(context);
   
    return ListView.builder(
      itemCount: scanListProvider.scans.length,
      itemBuilder: (BuildContext context, index){
        return Dismissible(
          direction: DismissDirection.startToEnd,
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (DismissDirection direction){
            Provider.of<ScanListProvider>(context, listen: false).borrarScanpoID(scanListProvider.scans[index].id);
            // print(direction);
          },
        
          child: ListTile(
            leading: Icon(
              this.tipo == 'http'
              ?Icons.cloud
              :Icons.map,
               
              color: Theme.of(context).primaryColor,
            ),
            title: Text(scanListProvider.scans[index].valor),
            subtitle: Text(scanListProvider.scans[index].id.toString()),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              launchURL(context, scanListProvider.scans[index]);
            },
          ),
        );
      },
    );
  }
}