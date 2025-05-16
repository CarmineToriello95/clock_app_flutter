import 'package:clock_app/features/prime_number/domain/entities/random_number_entity.dart';

/// Data layer representation of a random number
class RandomNumberModel extends RandomNumberEntity {
  const RandomNumberModel({required super.value});

  RandomNumberEntity toEntity() => RandomNumberEntity(value: value);
}
