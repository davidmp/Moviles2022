part of 'beneficiario_bloc.dart';

abstract class BeneficiarioEvent{
  final BeneficiarioModel beneficiario;
  const BeneficiarioEvent({this.beneficiario});
}
class ListarBeneficiarioEvent extends BeneficiarioEvent{ ListarBeneficiarioEvent(); }

class DeleteBeneficiarioEvent extends BeneficiarioEvent{
  DeleteBeneficiarioEvent({@required BeneficiarioModel beneficiario}):super(beneficiario:beneficiario);
}

class UpdateBeneficiarioEvent extends BeneficiarioEvent{
  UpdateBeneficiarioEvent({@required BeneficiarioModel beneficiario}):super(beneficiario:beneficiario);
}

class CreateBeneficiarioEvent extends BeneficiarioEvent {
  CreateBeneficiarioEvent({@required BeneficiarioModel beneficiario})
      :super(beneficiario: beneficiario);
}