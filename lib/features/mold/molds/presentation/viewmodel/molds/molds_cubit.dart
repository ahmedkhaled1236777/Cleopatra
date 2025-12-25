import 'package:bloc/bloc.dart';
import 'package:cleopatra/features/mold/molds/data/models/moldmodel.dart';
import 'package:cleopatra/features/mold/molds/data/repos/moldrepoimp.dart';

part 'molds_state.dart';

class MoldsCubit extends Cubit<MoldsState> {
  final moldrepoimp moldrepo;
  MoldsCubit(this.moldrepo) : super(MoldsInitial());
  String moldname = "اختر الاسطمبه";
  String materialtype = "نوع الخامه";
  String type = "تركيب";
  List<moldmodel> mymolds = [];
  List<moldmodel> filtermymolds = [];

  List<String> materiales = [
    "pp",
    "abs",
    "pc",
    "pa",
    "mabs",
    "ps",
    "pe",
    "pet",
    "pvc"
  ];
  moldchange(String val) {
    moldname = val;
    emit(changemold());
  }

  materialchange(String val) {
    materialtype = val;
    emit(changemold());
  }

  changetype({required String value}) {
    type = value;
    emit(changetypestate());
  }

  addmold({required moldmodel moldmodel}) async {
    emit(addmoldloading());
    var result = await moldrepo.addmold(moldmodel: moldmodel);
    result.fold((failure) {
      emit(addmoldfailure(error_message: failure.error_message));
    }, (success) {
      emit(addmoldsuccess(success_message: success));
    });
  }

  getmolds() async {
    emit(getmoldloading());
    var result = await moldrepo.getmolds();
    result.fold((failure) {
      emit(getmoldfailure(error_message: failure.error_message));
    }, (success) {
      mymolds = success;
      filtermymolds = success;
      emit(getmoldsuccess(success_message: "تم الحصول علي الاسطمبات بنجاح"));
    });
  }

  deltemold({required docid}) async {
    emit(deletemoldloading());
    var result = await moldrepo.deletemold(docid: docid);
    result.fold((failure) {
      emit(deletemoldfailure(error_message: failure.error_message));
    }, (success) {
      for (int i = 0; i < mymolds.length; i++) {
        if (docid ==
            "${mymolds[i].date}-${mymolds[i].moldname}-${mymolds[i].status}-${mymolds[i].machinenumber}") {
          mymolds.removeAt(i);

          break;
        }
      }

      emit(deletemoldsuccess(success_message: success));
    });
  }

  searchmold({String? moldname, String? date}) {
    bool datte = false;
    mymolds = [];
    if (date != null) {
      datte = true;
      filtermymolds.forEach((e) {
        if (e.date == date) {
          mymolds.add(e);
        }
      });
    }
    if (moldname != null) {
      if (datte) {
        for (int i = 0; i < mymolds.length; i++) {
          if (mymolds[i].moldname != moldname) {
            mymolds.removeAt(i);
          }
        }
      } else
        filtermymolds.forEach((e) {
          if (e.moldname == moldname) {
            mymolds.add(e);
          }
        });
    }
    emit(searchformold());
  }

  resetsearch() {
    mymolds = filtermymolds;
    emit(searchformold());
  }

  resetmold() {
    moldname = "اختر الاسطمبه";
    emit(resetmoldname());
  }
}
