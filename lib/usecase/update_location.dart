

import '../model/user_location.dart';
import '../repo/location_repo.dart';

class UpdateLocationUseCase {
  final LocationRepository repository;

  UpdateLocationUseCase(this.repository);

  Future<void> execute(String userId, UserLocation location) {
    return repository.updateLocation(userId, location);
  }
}
