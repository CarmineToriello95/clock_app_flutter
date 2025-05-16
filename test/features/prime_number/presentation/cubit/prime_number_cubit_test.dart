import 'package:bloc_test/bloc_test.dart';
import 'package:clock_app/core/extensions/date_time_extensions.dart';
import 'package:clock_app/core/usecases/usecase.dart';
import 'package:clock_app/features/prime_number/presentation/cubit/prime_number_cubit.dart';
import 'package:clock_app/features/prime_number/presentation/cubit/prime_number_cubit_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/mocks.mocks.dart';

void main() {
  late PrimeNumberCubit cubit;
  late MockMaybeFetchPrimeNumberUsecase mockMaybeFetchPrimeNumberUsecase;
  late MockRetrieveLastPrimeNumberTimestampUsecase
  mockRetrieveLastPrimeNumberTimestampUsecase;
  late MockSavePrimeNumberTimestampUsecase mockSavePrimeNumberTimestampUsecase;
  late MockDateTimeHelper mockDateTimeHelper;
  final DateTime tDateNow = DateTime(2025, 4, 4);
  final DateTime tDateLastPrimeNumber = DateTime(2025, 4, 3);
  final int tPrimeNumber = 5;

  setUp(() {
    mockMaybeFetchPrimeNumberUsecase = MockMaybeFetchPrimeNumberUsecase();
    mockRetrieveLastPrimeNumberTimestampUsecase =
        MockRetrieveLastPrimeNumberTimestampUsecase();
    mockSavePrimeNumberTimestampUsecase = MockSavePrimeNumberTimestampUsecase();
    mockDateTimeHelper = MockDateTimeHelper();
    cubit = PrimeNumberCubit(
      mockMaybeFetchPrimeNumberUsecase,
      mockSavePrimeNumberTimestampUsecase,
      mockRetrieveLastPrimeNumberTimestampUsecase,
      mockDateTimeHelper,
    );
  });

  mockMaybeFetchPrimeNumberUsecaseSuccess() => when(
    mockMaybeFetchPrimeNumberUsecase.call(params: NoParams()),
  ).thenAnswer((_) async => Right(tPrimeNumber));

  mockRetrieveLastPrimeNumberTimestampUsecaseSuccess() => when(
    mockRetrieveLastPrimeNumberTimestampUsecase.call(params: NoParams()),
  ).thenAnswer((_) async => Right(tDateLastPrimeNumber));

  mockSavePrimeNumberTimestampUsecaseSuccess() => when(
    mockSavePrimeNumberTimestampUsecase.call(params: tDateNow),
  ).thenAnswer((_) async => Right(true));

  group('PrimeNumberCubit', () {
    blocTest(
      'WHEN fetching a prime number is successful THEN emit $PrimeNumberPopulatedState with correct data',
      build: () {
        mockMaybeFetchPrimeNumberUsecaseSuccess();
        mockRetrieveLastPrimeNumberTimestampUsecaseSuccess();
        mockSavePrimeNumberTimestampUsecaseSuccess();
        when(mockDateTimeHelper.now).thenReturn(tDateNow);
        return cubit;
      },
      wait: Duration(seconds: 4),
      act:
          (cubit) =>
              cubit.startPeriodicNumberFetching(interval: Duration(seconds: 3)),
      verify: (cubit) {
        verifyInOrder([
          mockMaybeFetchPrimeNumberUsecase.call(params: NoParams()),
          mockRetrieveLastPrimeNumberTimestampUsecase.call(params: NoParams()),
          mockSavePrimeNumberTimestampUsecase.call(params: tDateNow),
        ]);
        verifyNoMoreInteractions(mockMaybeFetchPrimeNumberUsecase);
        verifyNoMoreInteractions(mockRetrieveLastPrimeNumberTimestampUsecase);
        verifyNoMoreInteractions(mockSavePrimeNumberTimestampUsecase);
      },
      expect:
          () => [
            PrimeNumberPopulatedState(
              number: tPrimeNumber,
              timeElapsedSinceLastPrimeNumber: tDateNow.calculateTimeElapsed(
                tDateLastPrimeNumber,
              ),
            ),
          ],
    );
  });
}
