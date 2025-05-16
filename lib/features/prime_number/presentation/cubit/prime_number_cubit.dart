import 'dart:async';

import 'package:clock_app/core/extensions/date_time_extensions.dart';
import 'package:clock_app/core/extensions/either_extension.dart';
import 'package:clock_app/core/usecases/usecase.dart';
import 'package:clock_app/features/prime_number/domain/usecases/maybe_fetch_prime_number_usecase.dart';
import 'package:clock_app/features/prime_number/domain/usecases/retrieve_last_prime_number_timestamp_usecase.dart';
import 'package:clock_app/features/prime_number/domain/usecases/save_prime_number_timestamp_usecase.dart';
import 'package:clock_app/features/prime_number/presentation/cubit/prime_number_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class PrimeNumberCubit extends Cubit<PrimeNumberCubitState> {
  final MaybeFetchPrimeNumberUsecase _maybeFetchPrimeNumberUsecase;
  final SavePrimeNumberTimestampUsecase _savePrimeNumberTimestampUsecase;
  final RetrieveLastPrimeNumberTimestampUsecase
  _retrieveLastPrimeNumberTimestampUsecase;

  late Timer _timer;

  PrimeNumberCubit(
    this._maybeFetchPrimeNumberUsecase,
    this._savePrimeNumberTimestampUsecase,
    this._retrieveLastPrimeNumberTimestampUsecase,
  ) : super(PrimeNumberInitialState());

  void startPeriodicNumberFetching() {
    _timer = Timer.periodic(Duration(seconds: 5), (_) async {
      // Call the usecase for maybe fetching a prime number.
      final result = await _maybeFetchPrimeNumberUsecase.call(
        params: NoParams(),
      );

      // If the usecase is successful (result.isRight()) and the number is prime (result.asRight()).
      if (result.isRight() && result.asRight() != null) {
        // Call the usecase to retrieve the last prime number timestamp.
        final retrieveLastPrimeTimestampResult =
            await _retrieveLastPrimeNumberTimestampUsecase.call(
              params: NoParams(),
            );

        // if the usecase is successful get the value
        final DateTime? lastPrimeTimeStamp =
            retrieveLastPrimeTimestampResult.isRight()
                ? retrieveLastPrimeTimestampResult.asRight()
                : null;

        final now = DateTime.now();

        emit(
          PrimeNumberPopulatedState(
            number: result.asRight()!,
            timeElapsedSinceLastPrimeNumber:
                lastPrimeTimeStamp != null
                    ? now.calculateTimeElapsed(lastPrimeTimeStamp)
                    : null,
          ),
        );

        // Call the usecase to save the timestamp of the new prime number.
        _savePrimeNumberTimestampUsecase.call(params: now);
      }
    });
  }

  @override
  Future<void> close() async {
    _timer.cancel();
    super.close();
  }
}
