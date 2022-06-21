class MsgModel {
  String mensaje;

  MsgModel({this.mensaje = ""});

  factory MsgModel.fromJson(Map<String, dynamic> map) {
    return MsgModel(
      mensaje: map['mensaje'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'mensaje': mensaje,
    };
  }
}
