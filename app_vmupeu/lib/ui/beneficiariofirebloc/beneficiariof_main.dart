import 'package:app_vmupeu/bloc/beneficiariofire/beneficiario_bloc.dart';
import 'package:app_vmupeu/drawer/app_theme.dart';
import 'package:app_vmupeu/repository/BeneficiarioFireRepository.dart';
import 'package:app_vmupeu/ui/beneficiariofirebloc/beneficiariof_edit.dart';
import 'package:app_vmupeu/ui/beneficiariofirebloc/beneficiariof_form.dart';
import 'package:flutter/material.dart';
import 'package:app_vmupeu/modelo/beneficiario_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MainBeneficiarioFire extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
            providers: [
              //BlocProvider(create: (_)=>TickerBloc(Ticker())),
              BlocProvider(create: (_)=>BeneficiarioBloc( beneficiarioRepository:
              BeneficiarioFireRepository())),
            ],
      /*Provider<BeneficiarioApi>(
      create: (_) => BeneficiarioApi.create(),*/
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.lightBlue),
        home: BeneficiarioFUI(),
      ),
    );
  }
}

class BeneficiarioFUI extends StatefulWidget {
  @override
  _BeneficiarioFUIState createState() => _BeneficiarioFUIState();
}

class _BeneficiarioFUIState extends State<BeneficiarioFUI> {
//ApiCovid apiService;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  var api;
  @override
  void initState() {
    super.initState();
//apiService = ApiCovid();
//api=Provider.of<PredictionApi>(context, listen: false).getPrediction();
    print("entro aqui");
  }

  Future onGoBack(dynamic value) {
    setState(() {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BeneficiarioBloc>(context).add(ListarBeneficiarioEvent());
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          'Lista de Beneficiarios',
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                print("Si funciona");
              },
              child: Icon(
                Icons.search,
                size: 26.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                //final producto=new ModeloProductos();
                //formDialog(context, producto);
                print("Si funciona 2");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BeneficiarioFireForm()),
                ).then(onGoBack);
              },
              child: Icon(Icons.add_box_sharp),
            ),
          )
        ],
      ),
      backgroundColor: AppTheme.nearlyWhite,
      body: BlocBuilder<BeneficiarioBloc, BeneficiarioState>(
        builder: (context, state){
          print("legoLis");
      if(state is BeneficiarioLoadedState){

        return _buildListView(state.BeneficiarioList);
      }else{
        return Center(
        child: CircularProgressIndicator(),
        );
    }
    })

        /*FutureBuilder<List<BeneficiarioModel>>(

        future: Provider.of<BeneficiarioApi>(context, listen: true)
            .getBeneficiario(),
        builder: (BuildContext context,
            AsyncSnapshot<List<BeneficiarioModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<BeneficiarioModel> Beneficiario = snapshot.data;
            print(Beneficiario.length);
            return _buildListView(Beneficiario);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )*/,
    );
  }

  Widget _buildListView(List<BeneficiarioModel> beneficiario) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          BeneficiarioModel beneficiariox = beneficiario[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                        title: Text(beneficiariox.nombre,
                            style: Theme.of(context).textTheme.headline6),
                        subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.redAccent),
                                child: Text(
                                  beneficiariox.dni,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.yellow),
                                child: Text(
                                  beneficiariox.genero.toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ]),
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/imagen/man-icon.png"),
                        ),
                        trailing: Row(mainAxisSize: MainAxisSize.min,
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BeneficiarioFormFireEdit(
                                              modelP: beneficiariox)),
                                    ).then(onGoBack);
                                  }),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                Text("Mensaje de confirmacion"),
                                            content: Text("Desea Eliminar?"),
                                            actions: [
                                              FlatButton(
                                                child: const Text('CANCEL'),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop('Failure');
                                                },
                                              ),
                                              FlatButton(
                                                  child: const Text('ACCEPT'),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop('Success');
                                                  })
                                            ],
                                          );
                                        }).then((value) {
                                      if (value.toString() == "Success") {
                                        print(beneficiariox.id);
                                        /*Provider.of<BeneficiarioApi>(context,
                                                listen: false)
                                            .deleteBeneficiario(beneficiariox.id)
                                            .then((value) => onGoBack(value));*/
                                        //var onGoBack = onGoBack;
                                        BlocProvider.of<BeneficiarioBloc>(context).add(DeleteBeneficiarioEvent(beneficiario: beneficiariox));
                                      }
                                    });
                                  })
                            ])),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: beneficiario.length,
      ),
    );
  }
}
