import 'package:bloc_test/bloc_test.dart';
import 'package:clock_app/core/extensions/date_time_extensions.dart';
import 'package:clock_app/features/clock/presentation/cubit/clock_cubit.dart';
import 'package:clock_app/features/clock/presentation/cubit/clock_cubit_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/mocks.mocks.dart';

void main() {
  late ClockCubit cubit;
  late MockDateTimeHelper mockDateTimeHelper;
  final DateTime tDateNow = DateTime(2025, 4, 4);

  setUp(() {
    mockDateTimeHelper = MockDateTimeHelper();
    cubit = ClockCubit(mockDateTimeHelper);
  });

  blocTest(
    'WHEN starting the clock THEN emit $ClockPopulatedState with correct data',
    build: () {
      when(mockDateTimeHelper.now).thenReturn(tDateNow);
      return cubit;
    },
    act: (cubit) => cubit.startClock(),
    expect:
        () => [
          ClockPopulatedState(
            time: tDateNow.formatToHHmm,
            day: tDateNow.formatToEEEdMMM,
            calendarWeek: tDateNow.calendarWeekNumber().toString(),
          ),
        ],
  );
}
