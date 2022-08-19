
enum TypePersonnel
{
  gerant,
  cuisinier
}

class Personnel
{
  String uid;
  String id;
  String nom;
  String email;
  TypePersonnel type;

  Personnel({required this.uid, required this.id, required this.nom, required this.email,
     required this.type});

  String TypeString()
  {
    if(type == TypePersonnel.gerant)
      return 'Gérant';
    else
      return 'Cuisinier';
  }

  Map<String, dynamic> toMap()
  {
    return
      {
        "uid": uid, "nom": nom, "email": email, "type": type.index
      };
  }

  static Future<Personnel> fromMap(Map<String, dynamic> map) async
  {
    return Personnel(uid: map["uid"], id: map["id"], nom: map["nom"],
        email: map["email"],
        type: TypePersonnel.values[int.parse(map['type'].toString())] );
  }
}