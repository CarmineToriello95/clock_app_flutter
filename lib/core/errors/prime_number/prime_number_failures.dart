import 'package:clock_app/core/errors/failure.dart';

/// Class representing a failure occurred when fetching the random number.
class FetchRandomNumberFailure extends Failure {
  const FetchRandomNumberFailure(super.message);
}

/// Class representing a failure occurred when retrieving the timestamp of the last prime.
class RetrieveLastPrimeTimestampFailure extends Failure {
  const RetrieveLastPrimeTimestampFailure(super.message);
}

/// Class representing a failure occurred when saving the timestamp of the prime number.
class SavePrimeNumberTimestampFailure extends Failure {
  const SavePrimeNumberTimestampFailure(super.message);
}
