class Incidencia {
  int? id;
  String titulo;
  DateTime fecha;
  String descripcion;
  String? fotoPath;
  String? audioPath;

  Incidencia({
    this.id,
    required this.titulo,
    required this.fecha,
    required this.descripcion,
    this.fotoPath,
    this.audioPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'fecha': fecha.toIso8601String(),
      'descripcion': descripcion,
      'fotoPath': fotoPath,
      'audioPath': audioPath,
    };
  }

  static Incidencia fromMap(Map<String, dynamic> map) {
    return Incidencia(
      id: map['id'],
      titulo: map['titulo'],
      fecha: DateTime.parse(map['fecha']),
      descripcion: map['descripcion'],
      fotoPath: map['fotoPath'],
      audioPath: map['audioPath'],
    );
  }
}