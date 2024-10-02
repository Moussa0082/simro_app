// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategorieProduit {
    String? code_categorie_produit;
    String? nom_categorie_produit;
    String? famille_produit;
    int? id_categorie_produit;

    CategorieProduit({
         this.code_categorie_produit,
         this.nom_categorie_produit,
         this.famille_produit,
         this.id_categorie_produit,
    });


  

  CategorieProduit copyWith({
    String? code_categorie_produit,
    String? nom_categorie_produit,
    String? famille_produit,
    int? id_categorie_produit,
  }) {
    return CategorieProduit(
      code_categorie_produit: code_categorie_produit ?? this.code_categorie_produit,
      nom_categorie_produit: nom_categorie_produit ?? this.nom_categorie_produit,
      famille_produit: famille_produit ?? this.famille_produit,
      id_categorie_produit: id_categorie_produit ?? this.id_categorie_produit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code_categorie_produit': code_categorie_produit,
      'nom_categorie_produit': nom_categorie_produit,
      'famille_produit': famille_produit,
      'id_categorie_produit': id_categorie_produit,
    };
  }

  factory CategorieProduit.fromMap(Map<String, dynamic> map) {
    return CategorieProduit(
      code_categorie_produit: map['code_categorie_produit'] != null ? map['code_categorie_produit'] as String : null,
      nom_categorie_produit: map['nom_categorie_produit'] != null ? map['nom_categorie_produit'] as String : null,
      famille_produit: map['famille_produit'] != null ? map['famille_produit'] as String : null,
      id_categorie_produit: map['id_categorie_produit'] != null ? map['id_categorie_produit'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategorieProduit.fromJson(String source) => CategorieProduit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategorieProduit(code_categorie_produit: $code_categorie_produit, nom_categorie_produit: $nom_categorie_produit, famille_produit: $famille_produit, id_categorie_produit: $id_categorie_produit)';
  }

  @override
  bool operator ==(covariant CategorieProduit other) {
    if (identical(this, other)) return true;
  
    return 
      other.code_categorie_produit == code_categorie_produit &&
      other.nom_categorie_produit == nom_categorie_produit &&
      other.famille_produit == famille_produit &&
      other.id_categorie_produit == id_categorie_produit;
  }

  @override
  int get hashCode {
    return code_categorie_produit.hashCode ^
      nom_categorie_produit.hashCode ^
      famille_produit.hashCode ^
      id_categorie_produit.hashCode;
  }
}
