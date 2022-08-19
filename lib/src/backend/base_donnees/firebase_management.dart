import 'package:cloud_firestore/cloud_firestore.dart';

class GenieFirebase
{
  static FirebaseFirestore dbbInstance = FirebaseFirestore.instance;

  static Future<Map<String, dynamic>?> getDocument(String path) async {
    //dbbInstance.collection("ecole").where()

    DocumentSnapshot<Map<String, dynamic>> doc =
    await dbbInstance.doc(path).get();
    Map<String, dynamic>? m = doc.data();
    m!["id"] = doc.id;
    return m;
  }

  static Future<List<Map<String, dynamic>>> getAllDocOfCollection(
      String path) async {
    List<Map<String, dynamic>> docs = [];
    QuerySnapshot<Map<String, dynamic>> snapdoc =
    await dbbInstance.collection(path) .get();
    for (var element in snapdoc.docs) {
      Map<String, dynamic> m = element.data();
      m["id"] = element.id;
      docs.add(m);
    }
    //where("nom", isEqualTo: "Pizza"), orderBy('nom', descending: true) .
    return docs;
  }

  static Future<List<Map<String, dynamic>>> filter(
      String path, String key, String value,
      {bool array = false, int limit = 1000}) async {
    List<Map<String, dynamic>> docs = [];
    QuerySnapshot<Map<String, dynamic>> querydoc;
    if (array) {
      querydoc = await dbbInstance
          .collection(path)
          .where(key, arrayContains: value)
          .limit(limit)
          .get();
    } else {
      querydoc = await dbbInstance
          .collection(path)
          .where(key, isEqualTo: value)
          .limit(limit)
          .get();
    }

    for (var element in querydoc.docs) {
      Map<String, dynamic> m = element.data();
      m["id"] = element.id;
      docs.add(m);
    }
    return docs;
  }

  static Future<List<Map<String, dynamic>>> filterInt(
      String path, String key, int value,
      {bool array = false, int limit = 1000}) async {
    List<Map<String, dynamic>> docs = [];
    QuerySnapshot<Map<String, dynamic>> querydoc;
    if (array) {
      querydoc = await dbbInstance
          .collection(path)
          .where(key, arrayContains: value)
          .limit(limit)
          .get();
    } else {
      querydoc = await dbbInstance
          .collection(path)
          .where(key, isEqualTo: value)
          .limit(limit)
          .get();
    }

    for (var element in querydoc.docs) {
      Map<String, dynamic> m = element.data();
      m["id"] = element.id;
      docs.add(m);
    }
    return docs;
  }

  static Future<String> add(String path, Map<String, dynamic> map) async {
    var docRef = await dbbInstance.collection(path).add(map);
    return docRef.id;
  }

  static Future<bool> deleteDocument(String path) async {
    //dbbInstance.collection("ecole").where()

    DocumentSnapshot<Map<String, dynamic>> doc =
    await dbbInstance.doc(path).get();

    if( doc == null)
      return false;
    else
      {
        await doc.reference.delete();
        return true;
      }
  }
}