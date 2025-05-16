import 'package:clock_app/features/prime_number/data/datasources/local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../core/mocks.mocks.dart';

void main() {
  late LocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;
  final DateTime tDate = DateTime(2025, 4, 4);
  final int tDateInMilliseconds = tDate.millisecondsSinceEpoch;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = LocalDataSourceImpl(mockSharedPreferences);
  });

  group('LocalDataSource', () {
    test(
      'WHEN retrieving a timestamp is successful THEN perform correct storage interactions and return a nullable $DateTime object',
      () async {
        /// arrange
        when(
          mockSharedPreferences.getInt('timestampSinceEpoch'),
        ).thenReturn(tDateInMilliseconds);

        /// act
        final result = await dataSource.retrieveLastPrimeTimestamp();

        /// assert
        expect(
          result,
          DateTime.fromMillisecondsSinceEpoch(tDateInMilliseconds),
        );
        verify(mockSharedPreferences.getInt('timestampSinceEpoch')).called(1);
        verifyNoMoreInteractions(mockSharedPreferences);
      },
    );

    test(
      'WHEN saving a timestamp is successful THEN perform correct storage interactions and return a $bool object',
      () async {
        /// arrange
        when(
          mockSharedPreferences.setInt(
            'timestampSinceEpoch',
            tDateInMilliseconds,
          ),
        ).thenAnswer((_) async => true);

        /// act
        final result = await dataSource.savePrimeNumberTimestamp(
          timestamp: tDate,
        );

        /// assert
        expect(result, true);
        verify(
          mockSharedPreferences.setInt(
            'timestampSinceEpoch',
            tDateInMilliseconds,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockSharedPreferences);
      },
    );
  });
}
