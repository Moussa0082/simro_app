// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Collecteur {
    String? nom;
    String? prenom;
    String? sexe;
    String? whatsapp;
    int? telephone;
    String? adresse;
    int? relai;
    String? description;
    int? commune;
    int? id;

    Collecteur({
         this.nom,
         this.prenom,
         this.sexe,
         this.whatsapp,
         this.telephone,
         this.adresse,
         this.relai,
         this.description,
         this.commune,
         this.id,
    });


  Collecteur copyWith({
    String? nom,
    String? prenom,
    String? sexe,
    String? whatsapp,
    int? telephone,
    String? adresse,
    int? relai,
    String? description,
    int? commune,
    int? id,
  }) {
    return Collecteur(
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      sexe: sexe ?? this.sexe,
      whatsapp: whatsapp ?? this.whatsapp,
      telephone: telephone ?? this.telephone,
      adresse: adresse ?? this.adresse,
      relai: relai ?? this.relai,
      description: description ?? this.description,
      commune: commune ?? this.commune,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nom': nom,
      'prenom': prenom,
      'sexe': sexe,
      'whatsapp': whatsapp,
      'telephone': telephone,
      'adresse': adresse,
      'relai': relai,
      'description': description,
      'commune': commune,
      'id': id,
    };
  }

  factory Collecteur.fromMap(Map<String, dynamic> map) {
    return Collecteur(
      nom: map['nom'] != null ? map['nom'] as String : null,
      prenom: map['prenom'] != null ? map['prenom'] as String : null,
      sexe: map['sexe'] != null ? map['sexe'] as String : null,
      whatsapp: map['whatsapp'] != null ? map['whatsapp'] as String : null,
      telephone: map['telephone'] != null ? map['telephone'] as int : null,
      adresse: map['adresse'] != null ? map['adresse'] as String : null,
      relai: map['relai'] != null ? map['relai'] as int : null,
      description: map['description'] != null ? map['description'] as String : null,
      commune: map['commune'] != null ? map['commune'] as int : null,
      id: map['id'] != null ? map['id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Collecteur.fromJson(String source) => Collecteur.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Collecteur(nom: $nom, prenom: $prenom, sexe: $sexe, whatsapp: $whatsapp, telephone: $telephone, adresse: $adresse, relai: $relai, description: $description, commune: $commune, id: $id)';
  }

  @override
  bool operator ==(covariant Collecteur other) {
    if (identical(this, other)) return true;
  
    return 
      other.nom == nom &&
      other.prenom == prenom &&
      other.sexe == sexe &&
      other.whatsapp == whatsapp &&
      other.telephone == telephone &&
      other.adresse == adresse &&
      other.relai == relai &&
      other.description == description &&
      other.commune == commune &&
      other.id == id;
  }

  @override
  int get hashCode {
    return nom.hashCode ^
      prenom.hashCode ^
      sexe.hashCode ^
      whatsapp.hashCode ^
      telephone.hashCode ^
      adresse.hashCode ^
      relai.hashCode ^
      description.hashCode ^
      commune.hashCode ^
      id.hashCode;
  }
}
