import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sink/models/category.dart';
import 'package:sink/models/entry.dart';

class FirestoreDatabase {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  final String userId;
  CollectionReference entries;
  CollectionReference categories;

  FirestoreDatabase._()
      // For testing only
      : this.userId = '',
        this.entries = _db.collection("empty_collection"),
        this.categories = _db.collection("empty_collection");

  FirestoreDatabase(this.userId)
      : this.entries = _db.collection("users").doc(userId).collection("entry"),
        this.categories =
            _db.collection("users").doc(userId).collection("category");

  Stream<QuerySnapshot> getEntriesSnapshot() {
    return entries.orderBy('date', descending: true).snapshots();
  }

  Stream<QuerySnapshot> getFirstEntry() {
    return entries.orderBy('date', descending: false).limit(1).snapshots();
  }

  Stream<QuerySnapshot> snapshotBetween(DateTime from, DateTime to) {
    return entries
        .where('date', isGreaterThanOrEqualTo: from, isLessThanOrEqualTo: to)
        .snapshots();
  }

  void create(Entry entry) {
    entries.doc(entry.id).set(entry.toMap());
  }

  void delete(Entry entry) {
    entries.doc(entry.id).delete();
  }

  Future<Future<QuerySnapshot<Object?>>> getCategories() async {
    return categories.orderBy('name', descending: false).get();
  }

  void createCategory(Category category) {
    categories.doc(category.id).set({
      'id': category.id,
      'name': category.name,
      'icon': category.icon,
      'color': category.color.value,
      'type': category.type.index,
    });
  }
}

class TestFirestoreDatabase extends FirestoreDatabase {
  String userId;

  TestFirestoreDatabase(
    this.userId,
  ) : super._();
}
