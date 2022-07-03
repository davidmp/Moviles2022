import 'dart:async';
import 'package:app_vmupeu/apis/api_beneficiario.dart';
import 'package:app_vmupeu/modelo/msg_model.dart';
import 'package:app_vmupeu/modelo/beneficiario_model.dart';
import 'package:dio/dio.dart';

class BeneficiarioRepository {
  BeneficiarioApi beneficiarioApi;

  BeneficiarioRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    beneficiarioApi = BeneficiarioApi(_dio);
  }

  Future<List<BeneficiarioModel>> getBeneficiario() async {
    return await beneficiarioApi.getBeneficiario();
  }

  Future<MsgModel> deleteBeneficiario(String id) async {
    return await beneficiarioApi.deleteBeneficiario(id);
  }

  Future<MsgModel> updateBeneficiario(String id, BeneficiarioModel beneficiario) async {
    return await beneficiarioApi.updateBeneficiario(id, beneficiario);
  }

  Future<MsgModel> createBeneficiario(BeneficiarioModel beneficiario) async {
    return await beneficiarioApi.createBeneficiario(beneficiario);
  }



}