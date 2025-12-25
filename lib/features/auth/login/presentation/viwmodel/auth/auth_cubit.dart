import 'package:bloc/bloc.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/features/auth/login/data/repos/loginrepoimp.dart';
import 'package:cleopatra/features/auth/login/model/signmodelrequest.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final authrepoimp authrepo;
  Signmodelrequest? signmodelrequest;
  AuthCubit(this.authrepo) : super(AuthInitial());
  sign({required String email, required String pass}) async {
    emit(loginloading());
    var result = await authrepo.sign(email: email, pass: pass);
    result.fold((failure) {
      emit(loginfailure(error_message: failure.error_message));
    }, (success) {
      emit(loginsuccess(signmodelrequest: success));
    });
  }

  signup({required Signmodelrequest signup}) async {
    emit(signuploading());
    var result = await authrepo.signup(signup: signup);
    result.fold((failure) {
      emit(signupfailure(errormessage: failure.error_message));
    }, (success) {
      emit(signupsuccess(suuccessmessage: success));
    });
  }

  getprofile({required String email}) async {
    emit(getprofileloading());
    var result = await authrepo.getprofile(email: email);
    result.fold((failure) {
      emit(getprofilefailure(errormessage: failure.error_message));
    }, (success) {
      signmodelrequest = success;
      emit(getprofilesuccess(successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }

  resetpass({required String email}) async {
    emit(resetpassloading());
    var result = await authrepo.resetpass(email: email);
    result.fold((failure) {
      emit(resetpassfailure(error_message: failure.error_message));
    }, (success) {
      emit(resetpasssuccess(success_message: success));
    });
  }

  signout() async {
    emit(signoutloading());
    var result = await authrepo.logout();
    result.fold((failure) {
      emit(signoutfailure(error_message: failure.error_message));
    }, (success) {
      cashhelper.cleardata();
      emit(signoutsuccess(success_message: success));
    });
  }
}
