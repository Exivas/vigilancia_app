import 'package:flutter/material.dart';
import 'package:vigilancia_app/services/database_helper.dart';
import 'package:vigilancia_app/models/incidencia.dart';
import 'package:vigilancia_app/screens/detalle_incidencia_page.dart';

class ListaIncidenciasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Incidencias'),
        backgroundColor: Colors.blue[900],
      ),
      body: FutureBuilder<List<Incidencia>>(
        future: DatabaseHelper().getIncidencias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay incidencias registradas"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].titulo),
                  subtitle: Text(snapshot.data![index].fecha.toString()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleIncidenciaPage(incidencia: snapshot.data![index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}