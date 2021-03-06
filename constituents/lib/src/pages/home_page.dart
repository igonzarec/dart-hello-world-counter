import 'package:constituents/src/providers/menu_provider.dart';

import 'package:flutter/material.dart';

import 'package:constituents/src/utils/icono_string_util.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Constituents'),
      ),
      body: _list(),
    );
  }

  Widget _list() {
    //print(menuProvider.opciones);

    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _listaItems(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];

    data.forEach(
      (opt) {
        final widgetTemp = ListTile(
          title: Text(opt['texto']),
          leading: getIcon(opt['icon']),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
          onTap: () {
            Navigator.pushNamed(context, opt['ruta']);

            //para navegar a otra página
            //final route = MaterialPageRoute(builder: (context) {
            //  return AlertPage();
            //});
            //Navigator.push(context, route);
          },
        );
        opciones..add(widgetTemp)..add(Divider());
      },
    );
    return opciones;
  }
}
