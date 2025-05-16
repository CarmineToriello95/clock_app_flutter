/// Exception representing an error in the data layer while fetching the random number.
///
/// It is not inteded to propagate to the UI. It should be caught and translated
/// into a [Failure] in the repository.
class FetchRandomNumberException implements Exception {
  final String message;

  const FetchRandomNumberException(this.message);
}

class RetrieveLastPrimeTimestampException implements Exception {
  final String message;

  const RetrieveLastPrimeTimestampException(this.message);
}

class SaveLastPrimeTimestampException implements Exception {
  final String message;

  const SaveLastPrimeTimestampException(this.message);
}
