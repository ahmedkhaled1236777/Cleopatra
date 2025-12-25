import 'package:bloc/bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  int badge = 0;
  changebadgecount(int val) {
    badge = val;
    emit(changebadge());
  }
}
