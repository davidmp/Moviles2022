import 'package:data_connection_checker/data_connection_checker.dart';
Future<bool> isConected() async{
  return await DataConnectionChecker().hasConnection;
}