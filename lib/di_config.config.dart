// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import 'core/utils/date_time_helper.dart' as _i5;
import 'di_config.dart' as _i15;
import 'features/clock/presentation/cubit/clock_cubit.dart' as _i4;
import 'features/prime_number/data/datasources/local_data_source.dart' as _i8;
import 'features/prime_number/data/datasources/remote_data_source.dart' as _i6;
import 'features/prime_number/data/repositories/prime_number_repository_impl.dart'
    as _i10;
import 'features/prime_number/domain/repositories/prime_number_repository.dart'
    as _i9;
import 'features/prime_number/domain/usecases/maybe_fetch_prime_number_usecase.dart'
    as _i13;
import 'features/prime_number/domain/usecases/retrieve_last_prime_number_timestamp_usecase.dart'
    as _i11;
import 'features/prime_number/domain/usecases/save_prime_number_timestamp_usecase.dart'
    as _i12;
import 'features/prime_number/presentation/cubit/prime_number_cubit.dart'
    as _i14;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.Client>(() => registerModule.client);
    gh.factory<_i4.ClockCubit>(() => _i4.ClockCubit());
    gh.factory<_i5.DateTimeHelper>(() => _i5.DateTimeHelper());
    gh.factory<_i6.RemoteDataSource>(
        () => _i6.RemoteDataSourceImpl(gh<_i3.Client>()));
    await gh.factoryAsync<_i7.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i8.LocalDataSource>(
        () => _i8.LocalDataSourceImpl(gh<_i7.SharedPreferences>()));
    gh.factory<_i9.PrimeNumberRepository>(() => _i10.PrimeNumberRepositoryImpl(
          gh<_i6.RemoteDataSource>(),
          gh<_i8.LocalDataSource>(),
        ));
    gh.factory<_i11.RetrieveLastPrimeNumberTimestampUsecase>(() =>
        _i11.RetrieveLastPrimeNumberTimestampUsecase(
            gh<_i9.PrimeNumberRepository>()));
    gh.factory<_i12.SavePrimeNumberTimestampUsecase>(() =>
        _i12.SavePrimeNumberTimestampUsecase(gh<_i9.PrimeNumberRepository>()));
    gh.factory<_i13.MaybeFetchPrimeNumberUsecase>(() =>
        _i13.MaybeFetchPrimeNumberUsecase(gh<_i9.PrimeNumberRepository>()));
    gh.singleton<_i14.PrimeNumberCubit>(() => _i14.PrimeNumberCubit(
          gh<_i13.MaybeFetchPrimeNumberUsecase>(),
          gh<_i12.SavePrimeNumberTimestampUsecase>(),
          gh<_i11.RetrieveLastPrimeNumberTimestampUsecase>(),
          gh<_i5.DateTimeHelper>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i15.RegisterModule {}
