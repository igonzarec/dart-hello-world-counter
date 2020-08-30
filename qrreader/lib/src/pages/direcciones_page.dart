import 'package:flutter/material.dart';
import 'package:qrreader/src/bloc/scans_bloc.dart';
import 'package:qrreader/src/models/scan_model.dart';

import 'package:qrreader/src/utils/utils.dart' as utils;
import 'package:qrreader/src/bloc/scans_bloc.dart';

class DireccionesPage extends StatelessWidget {
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    scansBloc.obtenerScans();

    return StreamBuilder<List<ScanModel>>(
        stream: scansBloc.scansStreamHttp,
        builder:
            (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final scans = snapshot.data;

          if (scans.length == 0) {
            return Center(
              child: Text('No hay informacion'),
            );
          }

          return ListView.builder(
              itemCount: scans.length,
              itemBuilder: (context, i) => Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red[300],
                    ),
                    onDismissed: (direction) =>
                        scansBloc.borrarScan(scans[i].id),
                    child: ListTile(
                      leading: Icon(
                        Icons.cloud_queue,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(scans[i].valor),
                      subtitle: Text('ID: ${scans[i].id}'),
                      trailing:
                          Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                      onTap: () => scansBloc.abrirScan(context, scans[i]),
                    ),
                  ));
        });
  }
}
