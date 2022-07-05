import 'package:app_vmupeu/apis/api_beneficiario.dart';
import 'package:app_vmupeu/drawer/navigation_home_screen.dart';
import 'package:app_vmupeu/login/sign_in.dart';
import 'package:app_vmupeu/modelo/usuario_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainLogin extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Provider<BeneficiarioApi>(create: (_)=>BeneficiarioApi.create(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blue),
        home: LoginPage(),
      ),

    );
  }

}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  var token;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: AssetImage("assets/imagen/logo_upeu.png"),
                  height: 200.0),
              //FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton(){
    return OutlinedButton(

      //splashColor: Colors.grey,
      onPressed: () async {
        final prefs= await SharedPreferences.getInstance();

        signInWithGoogle().then((result) {
          if (result != null) {
            WidgetsFlutterBinding.ensureInitialized();
            Firebase.initializeApp();
            final api=Provider.of<BeneficiarioApi>(context,listen: false);
            final user=UsuarioModel();
            user.username="davidmp";
            user.password="A123456m";
            api.login(user).then((value){
              token="JWT "+value.access_token;
              prefs.setString("token", token);
              print(token);
            }).catchError((onError){
              print(onError.toString());
            });
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return NavigationHomeScreen();
                },
              ),
            );
          }else{
            print("Errro!!");
          }
        });
      },
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      //highlightElevation: 0,
      //borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/imagen/man-icon.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Ingresar VinMenX',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
