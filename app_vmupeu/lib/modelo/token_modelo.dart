class TokenModel {
  String access_token;

  TokenModel({this.access_token = ""});

  factory TokenModel.fromJson(Map<String, dynamic> map) {
    return TokenModel(
      access_token: map['access_token'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'access_token': access_token,
    };
  }
}
