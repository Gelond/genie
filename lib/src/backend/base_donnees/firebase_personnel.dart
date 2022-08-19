
import 'package:genie/src/backend/modeles/personnel.dart';

import 'firebase_management.dart';

class FirebasePersonnel
{
  static Future<Personnel?> getPersonnel(String id) async
  {
    Map<String, dynamic>? personnelMap = await GenieFirebase.getDocument("users/$id");
    if(personnelMap!=null)
      return await Personnel.fromMap(personnelMap);
  }

  static Future<Personnel?> getPersonnelByUid(String uid) async
  {
    List<Map<String, dynamic>> personnelMap = await GenieFirebase.filter("users", "uid", uid);
    if(personnelMap.isNotEmpty)
      return await Personnel.fromMap(personnelMap[0]);
  }

  static Future<void>addPersonnel(Personnel p) async
  {
    await GenieFirebase.add("users", p.toMap());
  }

  static Future<bool> deletePersonnel(String id) async
  {
    return await GenieFirebase.deleteDocument("users/$id");
  }
}