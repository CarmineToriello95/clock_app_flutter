import 'package:clock_app/features/prime_number/domain/repositories/prime_number_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpClient extends Mock implements http.Client {}

@GenerateMocks([HttpClient, SharedPreferences, PrimeNumberRepository])
class Mocks {}
