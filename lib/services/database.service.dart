import 'package:brew_crew/model/user.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/model/brew.model.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference brewsCollection = Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewsCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
        sugars: doc.data['sugars'] ?? '',
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0
      );
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewsCollection.snapshots()
      .map(_brewListFromSnapshot);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength']
    );
  }

  Stream<UserData> get userData {
    return brewsCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }
}