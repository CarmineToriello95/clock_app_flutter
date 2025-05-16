import 'package:clock_app/core/usecases/usecase.dart';
import 'package:clock_app/features/prime_number/domain/entities/random_number_entity.dart';
import 'package:clock_app/features/prime_number/domain/usecases/maybe_fetch_prime_number_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/mocks.mocks.dart';

void main() {
  late MaybeFetchPrimeNumberUsecase usecase;
  late MockPrimeNumberRepository mockPrimeNumberRepository;

  setUp(() {
    mockPrimeNumberRepository = MockPrimeNumberRepository();
    usecase = MaybeFetchPrimeNumberUsecase(mockPrimeNumberRepository);
  });

  group('MaybeFetchPrimeNumberUsecase', () {
    test(
      'WHEN fetching a number is successful and the number is prime THEN return the number',
      () async {
        /// arrange
        final tNumberEntity = RandomNumberEntity(value: 5);
        when(
          mockPrimeNumberRepository.fetchRandomNumber(),
        ).thenAnswer((_) async => Right(tNumberEntity));

        /// act
        final result = await usecase.call(params: NoParams());

        /// assert
        expect(result, Right(tNumberEntity.value));
        verify(mockPrimeNumberRepository.fetchRandomNumber()).called(1);
        verifyNoMoreInteractions(mockPrimeNumberRepository);
      },
    );

    test(
      'WHEN fetching a number is successful but the number is not prime THEN return null',
      () async {
        /// arrange
        final tNumberEntity = RandomNumberEntity(value: 6);
        when(
          mockPrimeNumberRepository.fetchRandomNumber(),
        ).thenAnswer((_) async => Right(tNumberEntity));

        /// act
        final result = await usecase.call(params: NoParams());

        /// assert
        expect(result, Right(null));
        verify(mockPrimeNumberRepository.fetchRandomNumber()).called(1);
        verifyNoMoreInteractions(mockPrimeNumberRepository);
      },
    );
  });
}
