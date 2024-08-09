import 'package:my_app/models/massage.dart';

abstract class MassageState{}
class GetMassageState extends MassageState{
  final List<Massage> massages;
  GetMassageState({required this.massages});
}
class NoMassagesState extends MassageState{}