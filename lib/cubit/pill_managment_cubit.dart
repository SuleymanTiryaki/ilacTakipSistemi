import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pill_managment_state.dart';

class PillManagmentCubit extends Cubit<PillManagmentState> {
  PillManagmentCubit() : super(PillManagmentInitial());
}
