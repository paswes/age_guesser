import 'package:age_guesser/cubit/status.dart';
import 'package:age_guesser/api/age_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'age_state.dart';

class NameAgeCubit extends Cubit<NameAgeState> {
  final AgeApi ageApi;

  NameAgeCubit({
    required this.ageApi,
  }) : super(NameAgeState.initial());

  final TextEditingController nameController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void onChangedName(String value) => emit(state.copyWith(name: value));
  void removeFocus() => focusNode.unfocus();

  Future<void> getAge(String name) async {
    nameController.clear();
    removeFocus();
    emit(state.copyWith(name: null, status: Status.loading));
    try {
      await Future.delayed(Duration(seconds: 2));
      //final age = await ageApi.getAge(name);
      emit(state.copyWith(age: 17, status: Status.success));
    } catch (e) {
      emit(state.copyWith(status: Status.error, lastException: Exception(e)));
    }
  }
}
