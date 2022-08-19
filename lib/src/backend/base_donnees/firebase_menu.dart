import 'package:genie/src/backend/base_donnees/firebase_management.dart';

import '../modeles/menu.dart';
import '../modeles/produit.dart';

class FirebaseMenu
{
  Future<List> getMenus() async
  {
    List<Map<String, dynamic>> listMap = await GenieFirebase.getAllDocOfCollection("menus");

    return listMap.map((m) => Menu.fromMap(m)).toList();
  }

  Future<Menu?> getMenu(String id) async
  {
    Map<String, dynamic>? menuMap = await GenieFirebase.getDocument("menus/$id");
    if(menuMap!=null)
      return Menu.fromMap(menuMap);

    //else return null;
  }

  Future<void>addMenu(Menu m) async
  {
    await GenieFirebase.add("menus", m.toMap());
  }

  Future<bool> deleteMenu(String id) async
  {
    return await GenieFirebase.deleteDocument("menus/$id");
  }
}