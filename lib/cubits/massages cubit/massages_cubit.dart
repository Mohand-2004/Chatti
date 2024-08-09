import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubits/massages%20cubit/states.dart';
import 'package:my_app/models/firebase_collections.dart';
import 'package:my_app/models/massage.dart';

class MassagesCubit extends Cubit<MassageState>{
  MassagesCubit() : super(NoMassagesState());
  void getMassages(String senderEmail,String receiverEmail) async {
    var response = await fireMassages.get();
    List<Massage> massages = [];
    for(var massage in response.docs){
      if((massage['sender_email'] == senderEmail && massage['receiver_email'] == receiverEmail) || (massage['receiver_email'] == senderEmail && massage['sender_email'] == receiverEmail)){
        massages.add(Massage.fromJson(massage,massage.id));
      }
    }
    if(massages.isEmpty){
      emit(NoMassagesState());
      return ;
    }
    massages.sort((Massage m1,Massage m2){
      if(m1.date.isEqual(m2.date)){
        return m1.time < m2.time ? -1 : 1;
      }
      else{
        return m1.date < m2.date ? -1 : 1;
      }
    });
    emit(GetMassageState(massages: massages));
  }
}