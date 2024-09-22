import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/constants.dart';
import '../model/user_location.dart';
import '../repo/location_repo.dart';

class FirebaseService implements LocationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> updateLocation(String userId, UserLocation location) async {
    await _firestore.collection(FirestoreConstants.usersCollection)
        .doc(userId)
        .set({'location': location.toMap()});
  }

  @override
  Stream<List<UserLocation>> getOtherUsersLocations(String currentUserId) {
    return _firestore.collection(FirestoreConstants.usersCollection)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .where((doc) => doc.id != currentUserId)
          .map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return UserLocation.fromMap(data['location']);
      }).toList();
    });
  }
}
