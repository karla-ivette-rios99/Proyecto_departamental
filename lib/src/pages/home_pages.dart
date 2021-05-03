import 'package:proyecto_departament/src/providers/menu_provider.dart';
import 'package:proyecto_departament/src/utils/icon_string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePageTemp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componente Temporal'), 
        backgroundColor:Colors.pink
      ),
      body: _lista(context),
    );
  }

  Widget _lista(BuildContext context) {
    return FutureBuilder(
      future: menuProvider.cargarData(),
      builder: (context, snapshot) {
        print(snapshot.data);
        return ListView(children: _listaItems(snapshot.data, context));
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];
    data.forEach((opt) {
      final witgetvalue = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(
          Icons.keyboard_arrow_right_outlined,
          color: Colors.pink,
        ),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  _buildPopupDialog(context, opt['texto']));
        },
      );
      opciones..add(witgetvalue)..add(Divider());

      //lista.add(tempWidget);
      //lista.add(Divider());
    });
    return opciones;
  }

  Widget _buildPopupDialog(BuildContext context, String opt) {
    return new AlertDialog(
      title: const Text('Me diste click'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hola soy la opcion " + opt),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
