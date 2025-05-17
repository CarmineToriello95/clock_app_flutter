import 'package:equatable/equatable.dart';

sealed class PrimeNumberCubitState extends Equatable {
  const PrimeNumberCubitState();
}

class PrimeNumberInitialState extends PrimeNumberCubitState {
  const PrimeNumberInitialState();

  @override
  List<Object?> get props => [];
}

class PrimeNumberPopulatedState extends PrimeNumberCubitState {
  final int number;
  final String? timeElapsedSinceLastPrimeNumber;

  const PrimeNumberPopulatedState({
    required this.number,
    required this.timeElapsedSinceLastPrimeNumber,
  });

  @override
  List<Object?> get props => [number, timeElapsedSinceLastPrimeNumber];
}
