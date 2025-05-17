import 'package:clock_app/core/extensions/date_time_extensions.dart';
import 'package:clock_app/di_config.dart';
import 'package:clock_app/features/clock/presentation/cubit/clock_cubit.dart';
import 'package:clock_app/features/clock/presentation/cubit/clock_cubit_state.dart';
import 'package:clock_app/features/clock/presentation/pages/clock_page.dart';
import 'package:clock_app/features/prime_number/presentation/cubit/prime_number_cubit.dart';
import 'package:clock_app/features/prime_number/presentation/cubit/prime_number_cubit_state.dart';
import 'package:clock_app/features/prime_number/presentation/pages/prime_number_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/mocks.mocks.dart';

void main() {
  late MockClockCubit mockClockCubit;
  late MockPrimeNumberCubit mockPrimeNumberCubit;

  setUpAll(() async {
    mockClockCubit = MockClockCubit();
    mockPrimeNumberCubit = MockPrimeNumberCubit();

    getIt.registerFactory<ClockCubit>(() => mockClockCubit);
    getIt.registerSingleton<PrimeNumberCubit>(mockPrimeNumberCubit);

    provideDummy<ClockCubitState>(const ClockInitialState());
    provideDummy<PrimeNumberCubitState>(const PrimeNumberInitialState());
  });

  group('ClockPageTest', () {
    final tDateNow = DateTime.now();
    final clockCubitPopulatedState = ClockPopulatedState(
      time: tDateNow.formatToHHmm,
      day: tDateNow.formatToEEEdMMM,
      calendarWeek: tDateNow.calendarWeekNumber().toString(),
    );
    final primeNumberCubitPopulatedState = PrimeNumberPopulatedState(
      number: 5,
      timeElapsedSinceLastPrimeNumber: '10s',
    );
    testWidgets('WHEN clock is started THEN render correct data', (
      tester,
    ) async {
      /// arrange
      when(mockClockCubit.state).thenReturn(clockCubitPopulatedState);
      when(
        mockClockCubit.stream,
      ).thenAnswer((_) => Stream.value(clockCubitPopulatedState));
      when(mockPrimeNumberCubit.state).thenReturn(PrimeNumberInitialState());
      when(
        mockPrimeNumberCubit.stream,
      ).thenAnswer((_) => Stream.value(PrimeNumberInitialState()));

      /// act
      await tester.pumpWidget(MaterialApp(home: ClockPage()));

      /// assert
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data != null &&
              widget.data!.contains(tDateNow.formatToHHmm),
        ),
        findsOne,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data != null &&
              widget.data!.contains(tDateNow.formatToEEEdMMM),
        ),
        findsOne,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data != null &&
              widget.data!.contains(tDateNow.calendarWeekNumber().toString()),
        ),
        findsOne,
      );
    });

    testWidgets(
      'GIVEN the clock page rendered WHEN a prime number is fetched successfully THEN show $PrimeNumberPage',
      (tester) async {
        /// arrange
        when(mockClockCubit.state).thenReturn(clockCubitPopulatedState);
        when(
          mockClockCubit.stream,
        ).thenAnswer((_) => Stream.value(clockCubitPopulatedState));
        when(
          mockPrimeNumberCubit.state,
        ).thenReturn(primeNumberCubitPopulatedState);
        when(
          mockPrimeNumberCubit.stream,
        ).thenAnswer((_) => Stream.value(primeNumberCubitPopulatedState));

        /// act
        await tester.pumpWidget(MaterialApp(home: ClockPage()));

        await tester.pumpAndSettle();

        /// assert
        expect(find.byType(PrimeNumberPage), findsOne);
      },
    );
  });
}
