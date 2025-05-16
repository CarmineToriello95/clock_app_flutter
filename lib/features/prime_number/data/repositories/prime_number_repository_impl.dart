import 'package:clock_app/features/prime_number/data/models/random_number_model.dart';
import 'package:clock_app/features/prime_number/domain/entities/random_number_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:clock_app/core/errors/failure.dart';
import 'package:clock_app/core/errors/prime_number/prime_number_failures.dart';
import 'package:clock_app/features/prime_number/data/datasources/local_data_source.dart';
import 'package:clock_app/features/prime_number/data/datasources/remote_data_source.dart';
import 'package:clock_app/features/prime_number/domain/repositories/prime_number_repository.dart';
import 'package:injectable/injectable.dart';

/// Concrete implementation of [PrimeNumberRepository]
@Injectable(as: PrimeNumberRepository)
class PrimeNumberRepositoryImpl implements PrimeNumberRepository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  PrimeNumberRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, RandomNumberEntity>> fetchRandomNumber() async {
    try {
      final RandomNumberModel numberModel =
          await _remoteDataSource.fetchRandomNumber();
      final RandomNumberEntity numberEntity = numberModel.toEntity();
      return Right(numberEntity);
    } catch (e) {
      return Left(FetchRandomNumberFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DateTime?>> retrieveLastPrimeNumberTimestamp() async {
    try {
      final DateTime? timestamp =
          await _localDataSource.retrieveLastPrimeTimestamp();
      return Right(timestamp);
    } catch (e) {
      return Left(RetrieveLastPrimeTimestampFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> savePrimeNumberTimestamp({
    required DateTime timestamp,
  }) async {
    try {
      final bool result = await _localDataSource.savePrimeNumberTimestamp(
        timestamp: timestamp,
      );
      return Right(result);
    } catch (e) {
      return Left(SavePrimeNumberTimestampFailure(e.toString()));
    }
  }
}
