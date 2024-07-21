import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'dart:io';
import 'package:vigilancia_app/services/database_helper.dart';
import 'package:vigilancia_app/models/incidencia.dart';

class RegistroIncidenciaPage extends StatefulWidget {
  @override
  _RegistroIncidenciaPageState createState() => _RegistroIncidenciaPageState();
}

class _RegistroIncidenciaPageState extends State<RegistroIncidenciaPage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  File? _image;
  String? _audioPath;
  final _picker = ImagePicker();
  final _audioRecorder = Record();
  bool _isRecording = false;

  Future<void> _tomarFoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _grabarAudio() async {
    if (await _audioRecorder.hasPermission()) {
      await _audioRecorder.start();
      setState(() {
        _isRecording = true;
      });
    }
  }

  Future<void> _detenerGrabacion() async {
    _audioPath = await _audioRecorder.stop();
    setState(() {
      _isRecording = false;
    });
  }

  void _guardarIncidencia() async {
    if (_formKey.currentState!.validate()) {
      final incidencia = Incidencia(
        titulo: _tituloController.text,
        fecha: DateTime.now(),
        descripcion: _descripcionController.text,
        fotoPath: _image?.path,
        audioPath: _audioPath,
      );

      await DatabaseHelper().insertIncidencia(incidencia);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Incidencia'),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un título';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.camera_alt),
                label: Text('Tomar Foto'),
                onPressed: _tomarFoto,
              ),
              if (_image != null) ...[
                SizedBox(height: 16),
                Image.file(_image!, height: 200),
              ],
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                label: Text(_isRecording ? 'Detener Grabación' : 'Grabar Audio'),
                onPressed: _isRecording ? _detenerGrabacion : _grabarAudio,
              ),
              if (_audioPath != null) ...[
                SizedBox(height: 8),
                Text('Audio grabado: $_audioPath'),
              ],
              SizedBox(height: 24),
              ElevatedButton(
                child: Text('Guardar Incidencia'),
                onPressed: _guardarIncidencia,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }
}