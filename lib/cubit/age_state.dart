part of 'age_cubit.dart';

class NameAgeState {
  final Status status;
  final Exception? lastException;
  final int? age;
  final String? name;

  const NameAgeState._({
    required this.status,
    required this.lastException,
    required this.age,
    required this.name,
  });

  factory NameAgeState.initial() => const NameAgeState._(
        status: Status.initial,
        lastException: null,
        age: null,
        name: null,
      );

  NameAgeState copyWith({
    Status? status,
    Exception? lastException,
    int? age,
    String? name,
  }) {
    return NameAgeState._(
      status: status ?? this.status,
      lastException: lastException ?? this.lastException,
      age: age ?? this.age,
      name: name ?? this.name,
    );
  }
}
