import 'dart:convert';

import 'package:clock_app/core/errors/prime_number/prime_number_exceptions.dart';
import 'package:clock_app/features/prime_number/data/models/random_number_model.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

abstract class RemoteDataSource {
  Future<RandomNumberModel> fetchRandomNumber();
}

@Injectable(as: RemoteDataSource)
class RemoteDataSourceImpl implements RemoteDataSource {
  final Client _client;

  RemoteDataSourceImpl(this._client);

  @override
  Future<RandomNumberModel> fetchRandomNumber() async {
    try {
      final uri = Uri.https('www.randomnumberapi.com', '/api/v1.0/random');

      final Response response = await _client.get(uri);

      if (response.statusCode == 200) {
        final decodedBody = jsonDecode(response.body) as List<dynamic>;
        if (decodedBody.first is int) {
          return RandomNumberModel(value: decodedBody.first);
        } else {
          throw FetchRandomNumberException('Error: data is not of type int');
        }
      }
      throw FetchRandomNumberException(
        'Error: status code is ${response.statusCode}',
      );
    } catch (e) {
      throw FetchRandomNumberException(e.toString());
    }
  }
}
