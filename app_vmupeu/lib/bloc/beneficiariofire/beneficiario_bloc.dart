import 'dart:async';
import 'package:app_vmupeu/modelo/beneficiario_model.dart';
import 'package:app_vmupeu/repository/BeneficiarioFireRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'beneficiario_event.dart';
part 'beneficiario_state.dart';
class BeneficiarioBloc extends Bloc<BeneficiarioEvent, BeneficiarioState> {
/*final BeneficiarioRepository _BeneficiarioRepository;
BeneficiarioBloc({BeneficiarioRepository BeneficiarioRepository}) :
_BeneficiarioRepository=BeneficiarioRepository,
super(BeneficiarioInitialState());*/
  final BeneficiarioFireRepository _beneficiarioRepository;

  BeneficiarioBloc({BeneficiarioFireRepository beneficiarioRepository})
      :
        _beneficiarioRepository=beneficiarioRepository,
        super(BeneficiarioInitialState());

  @override
  Stream<BeneficiarioState> mapEventToState(BeneficiarioEvent event) async* {
    print("legoLisX");
    if (event is ListarBeneficiarioEvent) {
      yield BeneficiarioLoadingState();
      try {
        List<BeneficiarioModel> beneficiarioList = await _beneficiarioRepository
            .getBeneficiario();
        yield BeneficiarioLoadedState(beneficiarioList);
      } catch (e) {
        print("Error ${e.toString()}");
        yield BeneficiarioError(e);
      }
    } else if (event is DeleteBeneficiarioEvent) {
      try {
        await _beneficiarioRepository.deleteBeneficiario(event.beneficiario.id);
        yield BeneficiarioLoadingState();
        List<BeneficiarioModel> beneficiarioList = await _beneficiarioRepository
            .getBeneficiario();
        yield BeneficiarioLoadedState(beneficiarioList);
      } catch (e) {
        print("Error ${e.toString()}");
        yield BeneficiarioError(e);
      }
    } else if (event is CreateBeneficiarioEvent) {
      try {
        await _beneficiarioRepository.createBeneficiario(event.beneficiario);
        yield BeneficiarioLoadingState();
        List<BeneficiarioModel> beneficiarioList = await _beneficiarioRepository
            .getBeneficiario();
        yield BeneficiarioLoadedState(beneficiarioList);
      } catch (e) {
        print("Error ${e.toString()}");
        yield BeneficiarioError(e);
      }
    } else if (event is UpdateBeneficiarioEvent) {
      try {
        await _beneficiarioRepository.updateBeneficiario(
            event.beneficiario.id, event.beneficiario);
        yield BeneficiarioLoadingState();
        List<BeneficiarioModel> beneficiarioList = await _beneficiarioRepository
            .getBeneficiario();
        yield BeneficiarioLoadedState(beneficiarioList);
      } catch (e) {
        print("Error ${e.toString()}");
        yield BeneficiarioError(e);
      }
    }
  }
}