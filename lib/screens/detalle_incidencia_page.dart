import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:vigilancia_app/models/incidencia.dart';

class DetalleIncidenciaPage extends StatelessWidget {
  final Incidencia incidencia;

  DetalleIncidenciaPage({required this.incidencia});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Incidencia'),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Título: ${incidencia.titulo}'),
            Text('Fecha: ${incidencia.fecha}'),
            Text('Descripción: ${incidencia.descripcion}'),
            if (incidencia.fotoPath != null)
              Image.file(File(incidencia.fotoPath!)),
            if (incidencia.audioPath != null)
              ElevatedButton(
                child: Text('Reproducir Audio'),
                onPressed: () {
                  final player = AudioPlayer();
                  player.play(DeviceFileSource(incidencia.audioPath!));
                },
              ),
          ],
        ),
      ),
    );
  }
}