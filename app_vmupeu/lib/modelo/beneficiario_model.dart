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
      id: map['_id'],
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

  factory BeneficiarioModel.fromJson2(Map<String, dynamic> map) {
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

  Map<String, dynamic> toMap() {
    var map = Map<String,
        dynamic>();
    map["dni"] = dni;
    map["nombre"] = nombre;
    map["apellidos"] = apellidos;
    map["genero"] = genero;
    map["fecha_nac"] = fechaNac;
    map["telefono"] = telefono;
    map["correo"] = correo;
    map["direccion"] = direccion;
    /*if (id != null) {
      map["id"] = id;
    }*/
    return map;
  }

  BeneficiarioModel.fromObject(dynamic o)
  {
    this.id = o["id"].toString();
    this.dni = o["dni"];
    this.nombre = o["nombre"];
    this.apellidos = o["apellidos"];
    this.genero = o["genero"];
    this.fechaNac = o["fecha_nac"];
    this.telefono = o["telefono"];
    this.correo = o["correo"];
    this.direccion = o["direccion"];
    //this.edad =
   // int.tryParse(o["edad"].toString());
  }

  @override
  String toString() {
    return 'ModeloPersona{id: $id,dni: $dni, nombre: $nombre, telefono: $telefono, genero: $genero, fecha_nac: $fechaNac, genero: $genero, correo:$correo }';
}

}
