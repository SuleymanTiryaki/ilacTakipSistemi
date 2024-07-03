import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:untitled1/pillModel.dart';

class CubitState {
  // final String pillName;
  // final String pariodOfDay;
  // final String pillType;
  // final String howManyHours;
  // final TimeOfDay startTime;
  final List<PillModel>? pillModelList;

  CubitState({
// required this.pillName,
// required this.pariodOfDay,
// required this.howManyHours,
// required this.pillType,
// required this.startTime,
    this.pillModelList,
  });

  CubitState copyWith({
    // final String? pillName,
    // final String? pariodOfDay,
    // final String? pillType,
    // final String? howManyHours,
    // final TimeOfDay? startTime,
    final List<PillModel>? pillModelList,
  }) {
    return CubitState(
      pillModelList: pillModelList??this.pillModelList
    );
  }
}

class TextCubit extends Cubit<CubitState> {
  final TextEditingController textController;
  final TextEditingController textController2;
  final TextEditingController textController3;

  TextCubit(this.textController, this.textController2, this.textController3)
      : super(CubitState());

  final List<PillModel> pillModelList=[];

  // void pillNameChanged(String? pillName) {
  //   emit(state.copyWith(pillName: pillName));
  // }

  // void pariodOfDayChanged(String? pariodOfDay) {
  //   emit(state.copyWith(pariodOfDay: pariodOfDay));
  // }

  // void howManyHoursChanged(String? howManyHours) {
  //   emit(state.copyWith(howManyHours: howManyHours));
  // }

  void addPillModel(PillModel  pillModel) {
    Logger().d("addpill");
    Logger().d(pillModel.pillName);
    pillModelList.add(pillModel);
    Logger().d(pillModelList);
    emit(state.copyWith(pillModelList: pillModelList));
  }
}
