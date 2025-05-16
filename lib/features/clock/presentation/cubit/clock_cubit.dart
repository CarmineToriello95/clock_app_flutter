import 'dart:async';

import 'package:clock_app/core/extensions/date_time_extensions.dart';
import 'package:clock_app/features/clock/presentation/cubit/clock_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClockCubit extends Cubit<ClockCubitState> {
  late Timer _clockTimer;

  ClockCubit() : super(ClockInitialState());

  void startClock() {
    final now = DateTime.now();
    _emitCurrentTime();

    final secondsUntilNextMinute = 60 - now.second;

    // One-shot timer to align with the next full minute
    _clockTimer = Timer(Duration(seconds: secondsUntilNextMinute), () {
      _emitCurrentTime();
      _startMinuteTimer();
    });
  }

  void _startMinuteTimer() {
    _clockTimer.cancel(); // Cancel any previous timer
    _clockTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      _emitCurrentTime();
    });
  }

  void _emitCurrentTime() {
    final DateTime now = DateTime.now();
    emit(
      ClockPopulatedState(
        time: now.formatToHHmm,
        day: now.formatToEEEdMMM,
        calendarWeek: now.calendarWeekNumber().toString(),
      ),
    );
  }

  @override
  Future<void> close() async {
    _clockTimer.cancel();
    super.close();
  }
}
