class UsuarioModel {
  String username, password;

  UsuarioModel({this.username = "", this.password});

  factory UsuarioModel.fromJson(Map<String, dynamic> map) {
    return UsuarioModel(
      username: map['username'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
