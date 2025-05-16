import 'package:clock_app/core/utils/date_time_helper.dart';
import 'package:clock_app/features/prime_number/domain/repositories/prime_number_repository.dart';
import 'package:clock_app/features/prime_number/domain/usecases/maybe_fetch_prime_number_usecase.dart';
import 'package:clock_app/features/prime_number/domain/usecases/retrieve_last_prime_number_timestamp_usecase.dart';
import 'package:clock_app/features/prime_number/domain/usecases/save_prime_number_timestamp_usecase.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpClient extends Mock implements http.Client {}

@GenerateMocks([
  HttpClient,
  SharedPreferences,
  PrimeNumberRepository,
  MaybeFetchPrimeNumberUsecase,
  RetrieveLastPrimeNumberTimestampUsecase,
  SavePrimeNumberTimestampUsecase,
  DateTimeHelper,
])
class Mocks {}
