import 'dart:async';
import 'package:app_vmupeu/apis/api_beneficiario.dart';
import 'package:app_vmupeu/local/dao/BeneficiarioDao.dart';
import 'package:app_vmupeu/modelo/msg_model.dart';
import 'package:app_vmupeu/modelo/beneficiario_model.dart';
import 'package:app_vmupeu/util/NetworConnection.dart';
import 'package:dio/dio.dart';

class BeneficiarioRepository {
  BeneficiarioApi beneficiarioApi;
  BeneficiarioDao beneficiarioDao;
  bool resut;

  BeneficiarioRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    beneficiarioApi = BeneficiarioApi(_dio);
    beneficiarioDao=BeneficiarioDao();
  }

  Future<List<BeneficiarioModel>> getBeneficiario() async {
    if(await isConected()){
      //return await beneficiarioDao.getAllBeneficiario();
      return await beneficiarioApi.getBeneficiario();
    }else{
      return await beneficiarioDao.getAllBeneficiario();
    }
  }

  Future<MsgModel> deleteBeneficiario(String id) async {
    if(await isConected()){
      //return await beneficiarioDao.deleteBeneficiario(int.parse(id));
      return await beneficiarioApi.deleteBeneficiario(id);
    }else{
      return await beneficiarioDao.deleteBeneficiario(int.parse(id));
    }
  }

  Future<MsgModel> updateBeneficiario(String id, BeneficiarioModel beneficiario) async {
    if(await isConected()){
      return await beneficiarioApi.updateBeneficiario(id, beneficiario);
    }else{
      return await beneficiarioDao.updateBeneficiario(beneficiario);
    }
  }

  Future<MsgModel> createBeneficiario(BeneficiarioModel beneficiario) async {
    if(await isConected()){
      //return await beneficiarioDao.insertBeneficiario(beneficiario);
      return await beneficiarioApi.createBeneficiario(beneficiario);
    }else{
      return await beneficiarioDao.insertBeneficiario(beneficiario);
    }
  }



}