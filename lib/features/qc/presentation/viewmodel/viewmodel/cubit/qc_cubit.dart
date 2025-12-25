import 'package:bloc/bloc.dart';
import 'package:cleopatra/features/qc/data/models/qcmodel.dart';
import 'package:cleopatra/features/qc/data/repos/repos/qcrepoimp.dart';


import 'package:cleopatra/features/qc/presentation/viewmodel/viewmodel/cubit/qc_state.dart';


class qcsCubit extends Cubit<qcsState> {
  qcsCubit(this.qcrepoim) : super(qcsInitial());
   final qcrepoimp qcrepoim;
 
List<qcmodel>qcs=[];
  addqc({required qcmodel qc}) async {
    emit(addqcloading());
    var result = await qcrepoim.addqc(qcmodel: qc);
    result.fold((failure) {
      emit(addqcfailure(error_message: failure.error_message));
    }, (success) {
      emit(addqcsuccess(success_message: success));
    });
  }

  getqcs({String ?date,String? machinenumber,String?prodname}) async {
    emit(getqcloading());
    var result = await qcrepoim.getqcs(date: date,machinenumber: machinenumber,prodname: prodname);
    result.fold((failure) {
      emit(getqcfailure(error_message: failure.error_message));
    }, (success) {
      qcs = success;
      emit(getqcsuccess(success_message: "تم الحصول علي التقارير بنجاح"));
    });
  }

  updatqcs({required qcmodel qc}) async {
    emit(updateqcloading());
    var result = await qcrepoim.editqc(qcmodel: qc);
    result.fold((failure) {
      emit(updateqcfailure(error_message: failure.error_message));
    }, (success) {
     

      emit(updateqcsuccess(success_message: success));
    });
  }
 deleteqcs({required qcmodel qc}) async {
    emit(deleteqcloading());
    var result = await qcrepoim.deleteqc(qcmodel: qc);
    result.fold((failure) {
      emit(deleteqcfailure(error_message: failure.error_message));
    }, (success) {
      for (int i = 0; i < qcs.length; i++) {
        if (qc.docid ==
            qcs[i].docid) {
          qcs.removeAt(i);

          break;
        }
      }

      emit(deleteqcsuccess(success_message: success));
    });
  }
  
}
