import 'package:get_it/get_it.dart';

import 'modules/dashboard/repository/bookings_repository.dart';
import 'modules/dashboard/repository/bookings_repository_impl.dart';
import 'utilities/api_provider.dart';

final getIt = GetIt.instance;

configurableDependencies() {
  getIt.registerLazySingleton<BookingRepository>(
      () => BookingRepositoryImpl(apiProvider: ApiProvider()));
}
