class BeneficiarioModel {
  String id,
      dni,
      nombre,
      apellidos,
      genero,
      fechaNac,
      telefono,
      correo,
      direccion;

  BeneficiarioModel(
      {this.id = "",
      this.dni,
      this.nombre,
      this.apellidos,
      this.genero,
      this.fechaNac,
      this.telefono,
      this.correo,
      this.direccion});

  factory BeneficiarioModel.fromJson(Map<String, dynamic> map) {
    return BeneficiarioModel(
      id: map['id'],
      dni: map['dni'],
      nombre: map['nombre'],
      apellidos: map['apellidos'],
      genero: map['genero'],
      fechaNac: map['fecha_nac'],
      telefono: map['telefono'],
      correo: map['correo'],
      direccion: map['direccion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dni': dni,
      'nombre': nombre,
      'apellidos': apellidos,
      'genero': genero,
      'fecha_nac': fechaNac,
      'telefono': telefono,
      'correo': correo,
      'direccion': direccion,
    };
  }
}
