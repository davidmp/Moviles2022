from flask.wrappers import Response
from flask import request, jsonify
import json
from app import app,mongo 
import datetime
from flask_jwt import jwt_required
from bson.objectid import ObjectId
import uuid

@app.route("/api/persona")
def listarPersona():
    #data = list(mongo.db.persona.find({}, {"_id": False}))
    #data = list(mongo.db.persona.find_and_replace({},{"_id": "id"}))
    data = list(mongo.db.persona.find({}))
    #data=list(map(lambda person:{'id' if key=="_id" else key: val for key, val in person.items()}, data)) # Activar Android Nativo
    #print(online_users)
    print("Holasss")
    return Response(
        response=json.dumps(data,default=str),
        status=200,
        mimetype="application/json"
    )    

@app.route("/api/persona/<string:id>")
@jwt_required()
def listarPersonaId(id):
    data = list(mongo.db.persona.find({"_id": ObjectId(id)}))
    #print(online_users)
    print("Holasss")
    return Response(
    response=json.dumps(data,default=str),
    status=200,
    mimetype="application/json"
    )


@app.route("/api/persona/crear",methods=["POST"])
@jwt_required()
def crear():
    try:
        #u = uuid.uuid1()
        _json=request.json
        data_format=datetime.datetime.strptime(_json["fecha_nac"],'%Y-%m-%d')
        _json["fecha_nac"]=data_format
        #del _json["id"] #Activar para android Nativo
        print(_json)
        #_json["_id"]=uuid.uuid1()
        dbResponse=mongo.db.persona.insert_one(_json)
        
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
    
@app.route("/api/personau/<string:id>", methods=["PATCH"])
def update(id):
    print(id)
    _json=request.json
    print("VER:",_json["nombre"])
    try:
        dbResponse = mongo.db.persona.update_one(
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

@app.route("/api/personaut/<string:id>", methods=["PATCH"])
def update_two(id):
    print(id)
    _json=request.json
    print("VER:",_json["nombre"])
    try:
        dbResponse = mongo.db.persona.update_one(
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


@app.route("/api/persona/<string:id>", methods=["DELETE"])
#@jwt_required()
def delete(id):
    try:
        dbResponse = mongo.db.persona.delete_one({"_id": ObjectId(id)})
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