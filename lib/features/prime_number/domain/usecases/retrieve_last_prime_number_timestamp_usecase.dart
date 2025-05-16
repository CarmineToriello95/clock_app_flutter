import 'package:dartz/dartz.dart';
import 'package:clock_app/core/errors/failure.dart';
import 'package:clock_app/core/usecases/usecase.dart';
import 'package:clock_app/features/prime_number/domain/repositories/prime_number_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RetrieveLastPrimeNumberTimestampUsecase
    implements UseCase<DateTime?, NoParams> {
  final PrimeNumberRepository _repository;

  RetrieveLastPrimeNumberTimestampUsecase(this._repository);
  @override
  Future<Either<Failure, DateTime?>> call({required NoParams params}) =>
      _repository.retrieveLastPrimeNumberTimestamp();
}
