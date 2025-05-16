import 'package:equatable/equatable.dart';

class RandomNumberEntity extends Equatable {
  final int value;

  const RandomNumberEntity({required this.value});

  @override
  List<Object?> get props => [value];
}
