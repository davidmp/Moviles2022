import 'package:app_vmupeu/local/db/db_creation.dart';
import 'package:app_vmupeu/modelo/msg_model.dart';
import 'package:app_vmupeu/modelo/beneficiario_model.dart';
class BeneficiarioDao extends BaseRepository{

  Future<List<BeneficiarioModel>> getAllBeneficiario() async {
    final db = await database;
    var result = await db.rawQuery('SELECT * FROM beneficiario');
    List<BeneficiarioModel> listBeneficiario = result.isNotEmpty ? result.map((c) =>
        BeneficiarioModel.fromObject(c)).toList() : [];
    return listBeneficiario;
  }

  Future<MsgModel> insertBeneficiario(BeneficiarioModel beneficiario) async{
    final db = await database;
    var result = await db.rawInsert('INSERT INTO beneficiario(dni, nombre, apellidos, genero,fecha_nac,telefono, correo, direccion ) VALUES(?,?,?,?,?,?,?,?)',
        [beneficiario.dni, beneficiario.nombre, beneficiario.apellidos, beneficiario.genero,beneficiario.fechaNac, beneficiario.telefono, beneficiario.correo, beneficiario.direccion]);
    Map<String, dynamic> resultado = {'mensaje':"Se creo correctamente"};
    if(result==1){
      return Future.value(MsgModel.fromJson(resultado));
    }
    resultado["mensaje"]="No se pudo Registrar";
    return Future.value(MsgModel.fromJson(resultado));
  }


  Future<MsgModel> updateBeneficiario(BeneficiarioModel beneficiario) async {
    final db = await database;
    int result = await db.update('beneficiario', beneficiario.toMap(), where: 'id = ${beneficiario.id}');
    Map<String, dynamic> resultado = {'mensaje':"updated!!"};
    if(result==1){
      return Future.value(MsgModel.fromJson(resultado));
    }
    resultado["mensaje"]="No se pudo modificar los datos";
    return Future.value(MsgModel.fromJson(resultado));
  }

  Future<MsgModel> deleteBeneficiario(int id) async {
    final db = await database;
    var res=await db.delete('beneficiario', where: 'id = $id');
    Map<String, dynamic> resultado = {'mensaje':"Deleted!!", 'id': id};
    if(res==1){
      return Future.value(MsgModel.fromJson(resultado));
    }
    resultado["mensaje"]="Error al eliminar";
    return Future.value(MsgModel.fromJson(resultado));
  }
  Future<int> deleteAll() async {
    final db = await database;
    return await db.delete('beneficiario');
  }

}