import 'package:clock_app/core/errors/failure.dart';
import 'package:clock_app/features/prime_number/domain/entities/random_number_entity.dart';
import 'package:dartz/dartz.dart';

/// Contract that defines the operations to fetch a random number
/// and save or retrieve a timestamp to/from local storage.
abstract class PrimeNumberRepository {
  /// Fetches a random number from the data source.
  ///
  /// Returns a [RandomNumberEntity] object if successful.
  ///
  /// Returns a [Failure] object if not successful.
  Future<Either<Failure, RandomNumberEntity>> fetchRandomNumber();

  /// Save a timestamp into local storage.
  ///
  /// Returns a [bool] object if successful.
  ///
  /// Returns a [Failure] object if not successful.
  Future<Either<Failure, bool>> savePrimeNumberTimestamp({
    required DateTime timestamp,
  });

  /// Retrieves a timestamp from local storage.
  ///
  /// Returns a nullable [DateTime] object if successful.
  ///
  /// Returns a [Failure] object if not successful.
  Future<Either<Failure, DateTime?>> retrieveLastPrimeNumberTimestamp();
}
