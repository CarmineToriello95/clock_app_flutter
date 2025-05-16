import 'package:clock_app/core/errors/prime_number/prime_number_exceptions.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _timestampStorageKey = 'timestampSinceEpoch';

abstract class LocalDataSource {
  Future<bool> savePrimeNumberTimestamp({required DateTime timestamp});
  Future<DateTime?> retrieveLastPrimeTimestamp();
}

@Injectable(as: LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences _sharedPreferences;

  LocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<DateTime?> retrieveLastPrimeTimestamp() {
    try {
      final int? timestampSinceEpoch = _sharedPreferences.getInt(
        _timestampStorageKey,
      );
      if (timestampSinceEpoch == null) {
        return Future.value(null);
      } else {
        return Future.value(
          DateTime.fromMillisecondsSinceEpoch(timestampSinceEpoch),
        );
      }
    } catch (e) {
      throw RetrieveLastPrimeTimestampException(e.toString());
    }
  }

  @override
  Future<bool> savePrimeNumberTimestamp({required DateTime timestamp}) {
    try {
      return _sharedPreferences.setInt(
        _timestampStorageKey,
        timestamp.millisecondsSinceEpoch,
      );
    } catch (e) {
      throw SavePrimeNumberTimestampException(e.toString());
    }
  }
}
