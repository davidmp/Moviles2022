import 'package:app_vmupeu/modelo/msg_model.dart';
import 'package:app_vmupeu/modelo/beneficiario_model.dart';
import 'package:app_vmupeu/modelo/token_modelo.dart';
import 'package:app_vmupeu/modelo/usuario_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

part 'api_beneficiario.g.dart';

@RestApi(baseUrl: "http://192.168.1.143:6060")
abstract class BeneficiarioApi {
  factory BeneficiarioApi(Dio dio, {String baseUrl}) = _BeneficiarioApi;

  static BeneficiarioApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return BeneficiarioApi(dio);
  }

  @GET("/api/beneficiario")
  Future<List<BeneficiarioModel>> getBeneficiario();

  @POST("/api/auth")
  Future<TokenModel> login(@Body() UsuarioModel usuario);

  @GET("/api/beneficiario/{id}")
  Future<List<BeneficiarioModel>> getBeneficiarioId(
      @Header("Authorization") String token, @Path("id") String id);

  @DELETE("/api/beneficiario/{id}")
  Future<MsgModel> deleteBeneficiario(@Path("id") String id);

  @PATCH("/api/beneficiariout/{id}")
  Future<MsgModel> updateBeneficiario(
      @Path("id") String id, @Body() BeneficiarioModel beneficiario);

  @POST("/api/beneficiario/crear")
  Future<MsgModel> createBeneficiario(@Body() BeneficiarioModel beneficiario);
}
