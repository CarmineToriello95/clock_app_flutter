import 'package:equatable/equatable.dart';

/// Base class representing failures that occur when fetching data from the api or local storage.
///
/// Failures are derived from exceptions and are safe to expose to the presentation layer.
/// They are created in repositories by converting caught exceptions into failures objects.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}
