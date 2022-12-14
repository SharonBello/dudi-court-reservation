import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_auth/models/reservation.dart';

class Database {
  // static Stream<QuerySnapshot> getAllEntries(String collection) {
  //   final CollectionReference reservationCollection = FirebaseFirestore.instance.collection(collection);
  //
  //   return reservationCollection.snapshots();
  // }
  // // just a simple get
  static Future<Object?> getAllEntries(String uid) async {
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('reservations');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // List<QueryDocumentSnapshot<T>> get docs;
    Object? mReservations;
    querySnapshot.docs.forEach((queryDocumentSnapshot) => {
      if(queryDocumentSnapshot.id == uid) {
        mReservations = queryDocumentSnapshot.data()
      }
    });
    return mReservations;
  }
  static Future<Map?> getAllDocumentsEntries() async {
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('reservations');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // List<QueryDocumentSnapshot<T>> get docs;
    var mReservations = new Map();
    querySnapshot.docs.forEach((queryDocumentSnapshot) => {
      mReservations[queryDocumentSnapshot.id] = queryDocumentSnapshot.data()
    });
    return mReservations;
  }
  static Future<Object?> getCourtsData() async {
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('courts');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    Object? courts;
    querySnapshot.docs.forEach((queryDocumentSnapshot) => {
      if(queryDocumentSnapshot.id == 'jawPTlXha948TQyBkuyP') {
        courts = queryDocumentSnapshot.data()
      }
    });
    return courts;
  }
  static Future<Object?> getSportCenterMembers() async {
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('sport_center_members');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    Object? sportCenterMembers;
    querySnapshot.docs.forEach((queryDocumentSnapshot) => {
      if(queryDocumentSnapshot.id == 'ksaAp1oIHwpb6eH6Z5Ig') {
        sportCenterMembers = queryDocumentSnapshot.data()
      }
    });
    return sportCenterMembers;
  }

  //
  // // get with custom order
  // static Future<List<Reservation>> getAllEntriesSortedByName(String collection) async {
  //   return (await FirebaseFirestore.instance
  //       .collection(collection)
  //       .orderBy("manufacturer", descending: false)
  //       .get())
  //       .docs
  //       .map((item) => Reservation.fromMap(item.data()))
  //       .toList();
  // }
  //
  // // get with filter
  // static Future<List<Reservation>> getAllEntriesFilteredByPrice(
  //     String collection) async {
  //   return (await FirebaseFirestore.instance
  //       .collection(collection)
  //       .where("price", isGreaterThan: 60000)
  //       .get())
  //       .docs
  //       .map((item) => Reservation.fromMap(item.data()))
  //       .toList();
  // }

  static Future addEntryWithAutogeneratedId(
      String collection, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection(collection).add(data);
  }

  // updates an existing entry (missing fields won't be touched on update), document must exist
  static Future updateEntryWithId(
      String collection, String documentId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(documentId)
        .update(data);
  }

  // adds or updates an existing entry (missing fields will be deleted on update!), document will be created if needed
  static Future addOrUpdateWithId(
      String collection, String documentId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(documentId)
        .set(data);
  }

  // deletes the entry with the given document id
  static Future deleteEntry(String collection, String documentId) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(documentId)
        .delete();
  }
}