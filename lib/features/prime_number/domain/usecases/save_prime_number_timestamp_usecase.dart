import 'package:dartz/dartz.dart';
import 'package:clock_app/core/errors/failure.dart';
import 'package:clock_app/core/usecases/usecase.dart';
import 'package:clock_app/features/prime_number/domain/repositories/prime_number_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SavePrimeNumberTimestampUsecase implements UseCase<bool, DateTime> {
  final PrimeNumberRepository _repository;

  SavePrimeNumberTimestampUsecase(this._repository);

  @override
  Future<Either<Failure, bool>> call({required DateTime params}) =>
      _repository.savePrimeNumberTimestamp(timestamp: params);
}
