part of 'beneficiario_bloc.dart';
class BeneficiarioState{ }

class BeneficiarioInitialState extends BeneficiarioState{ }

class BeneficiarioLoadingState extends BeneficiarioState{}

class BeneficiarioLoadedState extends BeneficiarioState{
  List<BeneficiarioModel> BeneficiarioList;
  BeneficiarioLoadedState(this.BeneficiarioList);
}

class BeneficiarioError extends BeneficiarioState{
  Error e;
  BeneficiarioError(this.e);
}