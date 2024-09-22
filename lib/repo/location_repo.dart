import '../model/user_location.dart';

abstract class LocationRepository {
  Future<void> updateLocation(String userId, UserLocation location);
  Stream<List<UserLocation>> getOtherUsersLocations(String currentUserId);
}
