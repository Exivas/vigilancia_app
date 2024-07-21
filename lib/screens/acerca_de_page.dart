import 'package:flutter/material.dart';

class AcercaDePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/oficial_foto.jpg'),
            ),
            SizedBox(height: 20),
            Text('Nombre: Erick Alexander'),
            Text('Apellido: Corcino Cordero'),
            Text('Matrícula: 2020-9468'),
            SizedBox(height: 20),
            Text(
              '"Esta app trata de mejorar la seguridad de tu telefono"',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}