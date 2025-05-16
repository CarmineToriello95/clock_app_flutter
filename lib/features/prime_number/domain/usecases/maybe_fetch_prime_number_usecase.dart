import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:clock_app/core/errors/failure.dart';
import 'package:clock_app/core/extensions/either_extension.dart';
import 'package:clock_app/core/usecases/usecase.dart';
import 'package:clock_app/features/prime_number/domain/entities/random_number_entity.dart';
import 'package:clock_app/features/prime_number/domain/repositories/prime_number_repository.dart';
import 'package:injectable/injectable.dart';

/// Call the repository to fetch a random number from the api.
/// If the number is prime, return it.
/// If the number is not prime, return null.
/// If an error occurred while fetching the random number, return a Failure object.
@injectable
class MaybeFetchPrimeNumberUsecase implements UseCase<int?, NoParams> {
  final PrimeNumberRepository repository;

  MaybeFetchPrimeNumberUsecase({required this.repository});

  @override
  Future<Either<Failure, int?>> call({required NoParams params}) async {
    final Either<Failure, RandomNumberEntity> result =
        await repository.fetchRandomNumber();

    /// If something went wrong while fetching the random number, return a failure object.
    if (result.isLeft()) {
      return Left(result.asLeft());
    }

    /// Retrieve the number
    final int number = result.asRight().value;

    /// If the number is prime return it otherwise return null
    return isPrime(number) ? Right(number) : Right(null);
  }

  bool isPrime(int number) {
    if (number <= 1) return false;

    // Check from 2 to square root of n (Optimized Method)
    for (int i = 2; i <= sqrt(number); i++) {
      if (number % i == 0) return false;
    }

    return true;
  }
}
