import 'package:age_guesser/modules/name_age/api/name_age_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'name_age_state.dart';

class NameAgeCubit extends Cubit<NameAgeState> {
  final AgeApi ageApi;

  NameAgeCubit({
    required this.ageApi,
  }) : super(NameAgeState.initial());

  final TextEditingController nameController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void onChangedName(String value) => emit(state.copyWith(name: value));

  void resetName() {
    emit(state.copyWith(name: ''));
    nameController.clear();
    focusNode.unfocus();
  }

  Future<void> onSubmit(String name) async {
    resetName();
    emit(state.copyWith(status: Status.loading));
    try {
      //await Future.delayed(const Duration(seconds: 2));
      final result = await ageApi.getAgeByName(name);
      emit(state.copyWith(age: result.age, status: Status.success));
    } catch (e) {
      emit(state.copyWith(status: Status.error, lastException: Exception(e)));
    }
  }
}

enum Status {
  initial,
  loading,
  success,
  error;
}
