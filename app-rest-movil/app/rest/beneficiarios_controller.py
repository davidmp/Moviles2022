from flask.wrappers import Response
from flask import request, jsonify
import json
from app import app,mongo 
import datetime
from flask_jwt import jwt_required
from bson.objectid import ObjectId
import uuid

@app.route("/api/beneficiario")
def listarBeneficiario():
    #data = list(mongo.db.persona.find({}, {"_id": False}))
    #data = list(mongo.db.persona.find_and_replace({},{"_id": "id"}))
    data = list(mongo.db.beneficiario.find({}))
    #data=list(map(lambda person:{'id' if key=="_id" else key: val for key, val in person.items()}, data)) # Activar Android Nativo
    #print(online_users)
    print("Holasss")
    return Response(
        response=json.dumps(data,default=str),
        status=200,
        mimetype="application/json"
    )    

@app.route("/api/beneficiario/<string:id>")
@jwt_required()
def listarBeneficiarioId(id):
    data = list(mongo.db.beneficiario.find({"_id": ObjectId(id)}))
    #print(online_users)
    print("Holasss")
    return Response(
    response=json.dumps(data,default=str),
    status=200,
    mimetype="application/json"
    )


@app.route("/api/beneficiario/crear",methods=["POST"])
@jwt_required()
def crearBeneficiario():
    try:
        #u = uuid.uuid1()
        _json=request.json
        data_format=datetime.datetime.strptime(_json["fecha_nac"],'%Y-%m-%d')
        _json["fecha_nac"]=data_format
        #del _json["id"] #Activar para android Nativo
        print(_json)
        _json["_id"]=uuid.uuid1()
        dbResponse=mongo.db.beneficiario.insert_one(_json)
        
        print(dbResponse.inserted_id)
        return Response(
            response=json.dumps(
                {
                    "mensaje":"Se creo correctamente"
                }, default=str
            ),
            status=200,
            mimetype="application/json"
        )
    except Exception as e:
        print(e)
        return Response(
            response=json.dumps(
                {
                    "mensaje":"Error al crear registro"
                }, default=str
            ),
            status=200,
            mimetype="application/json"
        )
    
@app.route("/api/beneficiariou/<string:id>", methods=["PATCH"])
@jwt_required()
def actualizarBeneficiario(id):
    print(id)
    _json=request.json
    print("VER:",_json["nombre"])

    try:
        dbResponse = mongo.db.beneficiario.update_one(
        {"_id": ObjectId(id)},
        {"$set": {"nombre": _json["nombre"]}}
        )
        if dbResponse.modified_count == 1:
            return Response(
            response=json.dumps({"mensaje": "updated!!"}, default=str),
            status=200,
            mimetype="application/json"
            )
        return Response(
        response=json.dumps({"mensaje": "Nothing to Update!!"}, default=str),
        status=200,
        mimetype="application/json"
        )
    except Exception as e:
        print(e)
        return Response(
        response=json.dumps({"mensaje": "OOPS!! can't update"}, default=str),
        status=500,
        mimetype="application/json")

@app.route("/api/beneficiariout/<string:id>", methods=["PATCH"])
def actualizarBeneficairioDos(id):
    print(id)    
    _json=request.json
    _json["_id"]=ObjectId(id)
    print(_json)
    print(ObjectId(id))
    print("VER:",_json["nombre"])
    try:
        dbResponse = mongo.db.beneficiario.update_one(
        {"_id": ObjectId(id)},
        {"$set": _json}
        )
        if dbResponse.modified_count == 1:
            return Response(
            response=json.dumps({"mensaje": "updated!!"}, default=str),
            status=200,
            mimetype="application/json"
            )
        return Response(
        response=json.dumps({"mensaje": "Nothing to Update!!"}, default=str),
        status=200,
        mimetype="application/json"
        )
    except Exception as e:
        print(e)
        return Response(
        response=json.dumps({"mensaje": "OOPS!! can't update"}, default=str),
        status=500,
        mimetype="application/json"
        )


@app.route("/api/beneficiario/<string:id>", methods=["DELETE"])
#@jwt_required()
def eliminarBeneficiario(id):
    try:
        dbResponse = mongo.db.beneficiario.delete_one({"_id": ObjectId(id)})
        if dbResponse.deleted_count == 1:
            return Response(
            response=json.dumps({"mensaje": "Deleted!!", "id": f"{id}"}, default=str),
            status=200,
            mimetype="application/json"
            )
        return Response(
        response=json.dumps({"mensaje": "Not Found!!", "id": f"{id}"}, default=str),
        status=404,
        mimetype="application/json"
        )
    except Exception as e:
        print(e)
        return Response(
        response=json.dumps({"mensaje": "OOPS!! can't delete"}, default=str),
        status=500,
        mimetype="application/json"
        )