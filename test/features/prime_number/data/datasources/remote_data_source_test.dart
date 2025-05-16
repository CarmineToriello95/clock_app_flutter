import 'dart:convert';

import 'package:clock_app/core/utils/api_utils.dart';
import 'package:clock_app/features/prime_number/data/datasources/remote_data_source.dart';
import 'package:clock_app/features/prime_number/data/models/random_number_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../core/mocks.mocks.dart';

void main() {
  late RemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;
  final Uri tUri = Uri.https(ApiUtils.authority, ApiUtils.randomNumberPath);

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImpl(mockHttpClient);
  });

  void setUpMockHttpClientSuccess() {
    when(
      mockHttpClient.get(tUri),
    ).thenAnswer((_) async => http.Response(jsonEncode([10]), 200));
  }

  group('RemoteDataSource', () {
    test(
      'WHEN fetching a random number is successful THEN perform correct api interactions and return a $RandomNumberModel containing the fetched number',
      () async {
        /// arrange
        setUpMockHttpClientSuccess();
        final tRandomNumber = RandomNumberModel(value: 10);

        /// act
        final result = await dataSource.fetchRandomNumber();

        /// assert
        expect(result, tRandomNumber);
        verify(mockHttpClient.get(tUri)).called(1);
        verifyNoMoreInteractions(mockHttpClient);
      },
    );
  });
}
