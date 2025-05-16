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
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import 'di_config.dart' as _i14;
import 'features/clock/presentation/cubit/clock_cubit.dart' as _i4;
import 'features/prime_number/data/datasources/local_data_source.dart' as _i7;
import 'features/prime_number/data/datasources/remote_data_source.dart' as _i5;
import 'features/prime_number/data/repositories/prime_number_repository_impl.dart'
    as _i9;
import 'features/prime_number/domain/repositories/prime_number_repository.dart'
    as _i8;
import 'features/prime_number/domain/usecases/maybe_fetch_prime_number_usecase.dart'
    as _i12;
import 'features/prime_number/domain/usecases/retrieve_last_prime_number_timestamp_usecase.dart'
    as _i10;
import 'features/prime_number/domain/usecases/save_prime_number_timestamp_usecase.dart'
    as _i11;
import 'features/prime_number/presentation/cubit/prime_number_cubit.dart'
    as _i13;

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
    gh.factory<_i5.RemoteDataSource>(
        () => _i5.RemoteDataSourceImpl(gh<_i3.Client>()));
    await gh.factoryAsync<_i6.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i7.LocalDataSource>(
        () => _i7.LocalDataSourceImpl(gh<_i6.SharedPreferences>()));
    gh.factory<_i8.PrimeNumberRepository>(() => _i9.PrimeNumberRepositoryImpl(
          gh<_i5.RemoteDataSource>(),
          gh<_i7.LocalDataSource>(),
        ));
    gh.factory<_i10.RetrieveLastPrimeNumberTimestampUsecase>(() =>
        _i10.RetrieveLastPrimeNumberTimestampUsecase(
            gh<_i8.PrimeNumberRepository>()));
    gh.factory<_i11.SavePrimeNumberTimestampUsecase>(() =>
        _i11.SavePrimeNumberTimestampUsecase(gh<_i8.PrimeNumberRepository>()));
    gh.factory<_i12.MaybeFetchPrimeNumberUsecase>(() =>
        _i12.MaybeFetchPrimeNumberUsecase(
            repository: gh<_i8.PrimeNumberRepository>()));
    gh.singleton<_i13.PrimeNumberCubit>(() => _i13.PrimeNumberCubit(
          gh<_i12.MaybeFetchPrimeNumberUsecase>(),
          gh<_i11.SavePrimeNumberTimestampUsecase>(),
          gh<_i10.RetrieveLastPrimeNumberTimestampUsecase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i14.RegisterModule {}
