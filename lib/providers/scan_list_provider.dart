import 'package:flutter/material.dart';
import 'package:qr_app/models/scan_model.dart';
import 'package:qr_app/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{

  List<ScanModel> scans = [];

  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async{
    final nuevoScan = new ScanModel(valor: valor);

    final id = await DBProvider.db.nuevoScan(nuevoScan);

    //Asigna el id del nuevo registro de la bd a la instancia creada de la bd
    nuevoScan.id = id;

    if (this.tipoSeleccionado == nuevoScan.tipo) {
      this.scans.add(nuevoScan);
      notifyListeners();
    }

    return nuevoScan;

  }
  
  cargarScans()async{
    final scans = await DBProvider.db.getAllScans();

    this.scans = [...scans];

    notifyListeners();

  }

  cargarScansTipo(String tipo)async{
    final scans = await DBProvider.db.getAllScansPorTipo(tipo);

    this.scans = [...scans];

    this.tipoSeleccionado = tipo;

    notifyListeners();

  }
  
  borrarTodos()async{
    await DBProvider.db.deleteAll();
    this.scans=[];
    notifyListeners();
  }

  borrarScanpoID(int id) async{
    await DBProvider.db.deleteScan(id);
    this.cargarScansTipo(this.tipoSeleccionado);

  }

}