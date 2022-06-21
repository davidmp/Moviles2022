part of 'api_persona.dart';

class _BeneficiarioApi implements BeneficiarioApi {
  _BeneficiarioApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= "http://192.168.1.143:6060";
  }

  final Dio _dio;
  String baseUrl;

  @override
  getBeneficiario() async {
    final prefs = await SharedPreferences.getInstance();
    var tokenx = prefs.getString("token");
    print("VERListar: ${tokenx}");
    //ArgumentError.checkNotNull(tokenx, "token");
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/api/persona',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              /*"Authorization":tokenx*/
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            BeneficiarioModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return Future.value(value);
  }

  @override
  getBeneficiarioId(token, id) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request(
        '/api/persona/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{"Authorization": token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    //final value = ModeloPersona.fromJson(_result.data);
    //return Future.value(value);
    var value = _result.data
        .map((dynamic i) =>
            BeneficiarioModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return Future.value(value);
  }

  @override
  login(user) async {
    ArgumentError.checkNotNull(user, "user");
    print("ver: ${user.toJson()}");
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(user.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/api/auth',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = TokenModel.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  deleteBeneficiario(id) async {
    final prefs = await SharedPreferences.getInstance();
    var tokenx = prefs.getString("token");
    ArgumentError.checkNotNull(id, '0');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/api/persona/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{"Authorization": tokenx},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MsgModel.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  updateBeneficiario(id, persona) async {
    ArgumentError.checkNotNull(id, '0');
    ArgumentError.checkNotNull(persona, 'persona');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(persona.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/api/personaut/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PATCH',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MsgModel.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  createBeneficiario(persona) async {
    ArgumentError.checkNotNull(persona, 'persona');
    final prefs = await SharedPreferences.getInstance();
    var tokenx = prefs.getString("token");
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(persona.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/api/persona/crear',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{"Authorization": tokenx},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MsgModel.fromJson(_result.data);
    return Future.value(value);
  }
}
