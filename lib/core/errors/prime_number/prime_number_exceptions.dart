/// Exception representing an error in the data layer while fetching the random number.
///
/// It is not inteded to propagate to the UI. It should be caught and translated
/// into a [Failure] in the repository.
class FetchRandomNumberException implements Exception {
  final String message;

  const FetchRandomNumberException(this.message);
}

/// Exception representing an error in the data layer while retrieving the last prime number timestamp.
///
/// It is not inteded to propagate to the UI. It should be caught and translated
/// into a [Failure] in the repository.
class RetrieveLastPrimeTimestampException implements Exception {
  final String message;

  const RetrieveLastPrimeTimestampException(this.message);
}

/// Exception representing an error in the data layer while saving the prime number timestamp.
///
/// It is not inteded to propagate to the UI. It should be caught and translated
/// into a [Failure] in the repository.
class SavePrimeNumberTimestampException implements Exception {
  final String message;

  const SavePrimeNumberTimestampException(this.message);
}
