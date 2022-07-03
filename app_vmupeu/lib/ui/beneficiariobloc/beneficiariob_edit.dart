import 'package:app_vmupeu/apis/api_beneficiario.dart';
import 'package:app_vmupeu/bloc/beneficiario/beneficiario_bloc.dart';
import 'package:app_vmupeu/drawer/app_theme.dart';
import 'package:app_vmupeu/modelo/beneficiario_model.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class BeneficiarioFormEdit extends StatefulWidget {
  BeneficiarioModel modelP;

  BeneficiarioFormEdit({this.modelP}) : super();

  @override
  _BeneficiarioFormEditState createState() => _BeneficiarioFormEditState(modelP: modelP);
}

List<Map<String, String>> lista = [
  {'value': 'M', 'display': 'Masculino'},
  {'value': 'F', 'display': 'Femenino'}
];

class _BeneficiarioFormEditState extends State<BeneficiarioFormEdit> {
  String _dni;
  String _nombre;
  String _telefono;
  int _edad;
  String _fecha_nac;
  String _genero;
  var _data = [];

  BeneficiarioModel modelP;
  _BeneficiarioFormEditState({this.modelP}) : super();

  @override
  void initState() {
    super.initState();
    _genero = modelP.genero;
    print("Llega ID:" + modelP.id);

    print("ver data: ${modelP.nombre}");
    print("ver: ${lista.map((item) => item['value']).toList()}");
    print("verv: ${lista.map((item) => item['display']).toList()}");
  }

  final _formKey = GlobalKey<FormState>();
  GroupController controller = GroupController();
  GroupController multipleCheckController = GroupController(
    isMultipleSelection: true,
  );

  Widget _buildDni() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'DNI:'),
      maxLength: 8,
      initialValue: modelP.dni,
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'DNI Requerido!';
        }
        if (value.length != 8) {
          return 'DNI debe ser 8 digitos!';
        }
        return null;
      },
      onSaved: (String value) {
        _dni = value;
      },
    );
  }

  Widget _buildNombre() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nombre:'),
      keyboardType: TextInputType.text,
      initialValue: modelP.nombre,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onSaved: (String value) {
        _nombre = value;
      },
    );
  }

  Widget _buildTelefono() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Num. Telefono:'),
      keyboardType: TextInputType.phone,
      initialValue: modelP.telefono,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Numero de Telefono Requerido';
        }
        return null;
      },
      onSaved: (String value) {
        _telefono = value;
      },
    );
  }

  /* Widget _buildEdad() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Edad:'),
      keyboardType: TextInputType.number,
      initialValue: modelP.edad.toString(),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Edad es campo Requerido';
        }
        return null;
      },
      onSaved: (String value) {
        _edad = int.parse(value);
      },
    );
  }*/

  Widget _buildFechaNac() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'F. Nacimiento:'),
      keyboardType: TextInputType.datetime,
      initialValue: modelP.fechaNac,
      validator: (String value) {
        if (value.isEmpty) {
          return 'F. Nacimiento es campo Requerido';
        }
        if (!RegExp(
                r"^\d{4}[\-\/\s]?((((0[13578])|(1[02]))[\-\/\s]?(([0-2][0-9])|(3[01])))|(((0[469])|(11))[\-\/\s]?(([0-2][0-9])|(30)))|(02[\-\/\s]?[0-2][0-9]))$")
            .hasMatch(value)) {
          return 'El formato de fecha no es correcto YYYY-mm-dd';
        }

        return null;
      },
      onSaved: (String value) {
        _fecha_nac = value;
      },
    );
  }

  Widget _buildGenero() {
    return DropDownFormField(
      titleText: 'Genero',
      hintText: 'Seleccione',
      value: _genero,
      onSaved: (value) {
        setState(() {
          _genero = value;
        });
      },
      onChanged: (value) {
        setState(() {
          _genero = value;
        });
      },
      dataSource: lista,
      textField: 'display',
      valueField: 'value',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Reg. Beneficiario"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(24),
              color: AppTheme.nearlyWhite,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    /*_buildName(),*/
                    _buildDni(),
                    _buildNombre(),
                    _buildTelefono(),
                    //_buildEdad(),
                    _buildFechaNac(),
                    _buildGenero(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: Text('Cancelar')),
                          ElevatedButton(
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Processing Data'),
                                  ),
                                );
                                _formKey.currentState.save();
                                BeneficiarioModel mp = new BeneficiarioModel();
                                mp.nombre = _nombre;
                                mp.dni = _dni;
                                mp.telefono = _telefono;
                                //mp.edad = _edad;
                                mp.fechaNac = _fecha_nac;
                                mp.genero = _genero;
                                mp.id=modelP.id;
                                print("IDX:" + modelP.id);
                                BlocProvider.of<BeneficiarioBloc>(context).add(UpdateBeneficiarioEvent(beneficiario: mp));
                                Navigator.pop(context);
                                /*var api = await Provider.of<BeneficiarioApi>(
                                        context,
                                        listen: false)
                                    .updateBeneficiario(modelP.id, mp);
                                print("ver: ${api.toJson()['mensaje']}");
                                if (api.toJson()['mensaje'] == "updated!!") {
                                  Navigator.pop(context, () {
                                    setState(() {});
                                  });
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
                                }*/
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'No estan bien los datos de los campos!'),
                                  ),
                                );
                              }
                            },
                            child: const Text('Guardar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
