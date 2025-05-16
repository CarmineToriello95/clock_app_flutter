import 'package:equatable/equatable.dart';

sealed class ClockCubitState extends Equatable {
  const ClockCubitState();
}

class ClockInitialState extends ClockCubitState {
  const ClockInitialState();
  @override
  List<Object?> get props => [];
}

class ClockPopulatedState extends ClockCubitState {
  final String time;
  final String day;
  final String calendarWeek;

  const ClockPopulatedState({
    required this.time,
    required this.day,
    required this.calendarWeek,
  });

  ClockPopulatedState copyWith({
    String? time,
    String? day,
    String? calendarWeek,
  }) => ClockPopulatedState(
    time: time ?? this.time,
    day: day ?? this.day,
    calendarWeek: calendarWeek ?? this.calendarWeek,
  );

  @override
  List<Object?> get props => [time, day, calendarWeek];
}
