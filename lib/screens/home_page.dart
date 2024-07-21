import 'package:flutter/material.dart';
import 'package:vigilancia_app/screens/registro_incidencia_page.dart';
import 'package:vigilancia_app/screens/lista_incidencias_page.dart';
import 'package:vigilancia_app/screens/acerca_de_page.dart';
import 'package:vigilancia_app/services/database_helper.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicación de Vigilancia'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Registrar Incidencia'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistroIncidenciaPage()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Ver Incidencias'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaIncidenciasPage()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Acerca de'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AcercaDePage()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Borrar todos los registros'),
              onPressed: () => _borrarTodosLosRegistros(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _borrarTodosLosRegistros(BuildContext context) async {
    bool confirmar = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Borrar todos los registros'),
          content: Text('¿Estás seguro de que quieres borrar todos los registros? Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('Borrar'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmar) {
      await DatabaseHelper().deleteAllIncidencias();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Todos los registros han sido borrados')),
      );
    }
  }
}