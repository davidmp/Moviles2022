
import 'dart:async';
import 'package:app_vmupeu/modelo/beneficiario_model.dart';
import 'package:app_vmupeu/util/NetworConnection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BeneficiarioFireRepository{
  CollectionReference db=FirebaseFirestore.instance.collection("beneficiario");

  Future<List<BeneficiarioModel>> getBeneficiario() async {
    if(await isConected()) {
      var data=await db.get();
      var persona=data.docs.map((e){
        final model = BeneficiarioModel.fromJson2(e.data());
        model.id=e.id;
        return model;
      }
      ).toList();
      return persona;
    } else {
      print('No hay internet');
    }
  }

  Future<void> createBeneficiario(BeneficiarioModel beneficiario) async {
    if(await isConected()) {
      return await db.add(beneficiario.toMap())
          .then((value) =>print("El id es : ${value.id}"))
          .catchError((onError)=>print("Error $onError"));
    } else {
      print('No internet');
    }
  }

  Future<void> deleteBeneficiario(String id) async {
    if(await isConected()) {
      return await db
          .doc(id)
          .delete()
          .then((value) => print("Beneficairio Deleted "))
          .catchError((error) => print("Failed to delete Beneficairio: $error"));
    } else {
      print('No hay conexion a internet FireBase!!');
    }
  }

  Future<void> updateBeneficiario(String id, BeneficiarioModel beneficiario) async {
    if(await isConected()) {
      print("Verrr: ${id}");
      return await db.doc(id)
          .update(beneficiario.toMap())
          .then((value) => print("Beneficiario Updated"))
          .catchError((error) => print("Failed to update user: $error"));
    } else {
      print('No hay conexion a internet FireBase!!');
    }
  }

}