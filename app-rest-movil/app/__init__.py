from flask import Flask
#from flask_pymongo import pymongo
from flask_mongoengine import MongoEngine
import datetime
from datetime import timedelta

app = Flask(__name__)

app.config["MONGODB_SETTINGS"] = {
    "db":"datavm"
}
app.config["USER_ENABLE_EMAIL"]=False
app.config["SECRET_KEY"]="super-secret"
#app.config["JWT_ACCESS_TOKEN_EXPIRES"] = datetime.timedelta(minutes=60)
#app.config["JWT_REFRESH_TOKEN_EXPIRES"] = datetime.timedelta(days=7)
app.config["JWT_AUTH_URL_RULE"]="/api/auth"
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = timedelta(hours=1)




app.debug=True


#app.config['MONGO_URI']="mongodb://localhost:27017/dataapp"
db = MongoEngine(app)
#db=PyMongo(app)

from flask_user import UserManager
from app.user.models import User, UserBase
user_manager=UserManager(app,db,User)


from flask_pymongo import PyMongo
appx = Flask(__name__)
appx.config["MONGO_URI"] = "mongodb://localhost:27017/datavm"
mongo = PyMongo(appx)
    

#JWT
from flask_jwt import JWT
from app.user.jwt import authenticate, identity
jwt=JWT(app,authenticate, identity)

#controlador de User
from app.user.controllers import userBp
app.register_blueprint(userBp)
from flask_restful import Api

# Restfull api
from app.rest import controller, beneficiarios_controller
api=Api(app)

