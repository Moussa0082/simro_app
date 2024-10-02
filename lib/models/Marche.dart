// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Marche {
    String? code_marche;
    String? nom_marche;
    String? type_marche;
    String? jour_marche;
    String? localite;
    int? longitude;
    int? latitude;
    double? superficie;
    String? description;
    int? commune;
    String? collecteur;
    String? idPersonnel;
    String? date_enregistrement;
    String? modifier_le;
    String? modifier_par;
    int? id_marche;

    Marche({
         this.code_marche,
         this.nom_marche,
         this.type_marche,
         this.jour_marche,
         this.localite,
         this.longitude,
         this.latitude,
         this.superficie,
         this.description,
         this.commune,
         this.collecteur,
         this.idPersonnel,
         this.date_enregistrement,
         this.modifier_le,
         this.modifier_par,
         this.id_marche,
    });




  Marche copyWith({
    String? code_marche,
    String? nom_marche,
    String? type_marche,
    String? jour_marche,
    String? localite,
    int? longitude,
    int? latitude,
    double? superficie,
    String? description,
    int? commune,
    String? collecteur,
    String? idPersonnel,
    String? date_enregistrement,
    String? modifier_le,
    String? modifier_par,
    int? id_marche,
  }) {
    return Marche(
      code_marche: code_marche ?? this.code_marche,
      nom_marche: nom_marche ?? this.nom_marche,
      type_marche: type_marche ?? this.type_marche,
      jour_marche: jour_marche ?? this.jour_marche,
      localite: localite ?? this.localite,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      superficie: superficie ?? this.superficie,
      description: description ?? this.description,
      commune: commune ?? this.commune,
      collecteur: collecteur ?? this.collecteur,
      idPersonnel: idPersonnel ?? this.idPersonnel,
      date_enregistrement: date_enregistrement ?? this.date_enregistrement,
      modifier_le: modifier_le ?? this.modifier_le,
      modifier_par: modifier_par ?? this.modifier_par,
      id_marche: id_marche ?? this.id_marche,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code_marche': code_marche,
      'nom_marche': nom_marche,
      'type_marche': type_marche,
      'jour_marche': jour_marche,
      'localite': localite,
      'longitude': longitude,
      'latitude': latitude,
      'superficie': superficie,
      'description': description,
      'commune': commune,
      'collecteur': collecteur,
      'idPersonnel': idPersonnel,
      'date_enregistrement': date_enregistrement,
      'modifier_le': modifier_le,
      'modifier_par': modifier_par,
      'id_marche': id_marche,
    };
  }

  factory Marche.fromMap(Map<String, dynamic> map) {
    return Marche(
      code_marche: map['code_marche'] != null ? map['code_marche'] as String : null,
      nom_marche: map['nom_marche'] != null ? map['nom_marche'] as String : null,
      type_marche: map['type_marche'] != null ? map['type_marche'] as String : null,
      jour_marche: map['jour_marche'] != null ? map['jour_marche'] as String : null,
      localite: map['localite'] != null ? map['localite'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as int : null,
      latitude: map['latitude'] != null ? map['latitude'] as int : null,
      superficie: map['superficie'] != null ? map['superficie'] as double : null,
      description: map['description'] != null ? map['description'] as String : null,
      commune: map['commune'] != null ? map['commune'] as int : null,
      collecteur: map['collecteur'] != null ? map['collecteur'] as String : null,
      idPersonnel: map['idPersonnel'] != null ? map['idPersonnel'] as String : null,
      date_enregistrement: map['date_enregistrement'] != null ? map['date_enregistrement'] as String : null,
      modifier_le: map['modifier_le'] != null ? map['modifier_le'] as String : null,
      modifier_par: map['modifier_par'] != null ? map['modifier_par'] as String : null,
      id_marche: map['id_marche'] != null ? map['id_marche'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Marche.fromJson(String source) => Marche.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Marche(code_marche: $code_marche, nom_marche: $nom_marche, type_marche: $type_marche, jour_marche: $jour_marche, localite: $localite, longitude: $longitude, latitude: $latitude, superficie: $superficie, description: $description, commune: $commune, collecteur: $collecteur, idPersonnel: $idPersonnel, date_enregistrement: $date_enregistrement, modifier_le: $modifier_le, modifier_par: $modifier_par, id_marche: $id_marche)';
  }

  @override
  bool operator ==(covariant Marche other) {
    if (identical(this, other)) return true;
  
    return 
      other.code_marche == code_marche &&
      other.nom_marche == nom_marche &&
      other.type_marche == type_marche &&
      other.jour_marche == jour_marche &&
      other.localite == localite &&
      other.longitude == longitude &&
      other.latitude == latitude &&
      other.superficie == superficie &&
      other.description == description &&
      other.commune == commune &&
      other.collecteur == collecteur &&
      other.idPersonnel == idPersonnel &&
      other.date_enregistrement == date_enregistrement &&
      other.modifier_le == modifier_le &&
      other.modifier_par == modifier_par &&
      other.id_marche == id_marche;
  }

  @override
  int get hashCode {
    return code_marche.hashCode ^
      nom_marche.hashCode ^
      type_marche.hashCode ^
      jour_marche.hashCode ^
      localite.hashCode ^
      longitude.hashCode ^
      latitude.hashCode ^
      superficie.hashCode ^
      description.hashCode ^
      commune.hashCode ^
      collecteur.hashCode ^
      idPersonnel.hashCode ^
      date_enregistrement.hashCode ^
      modifier_le.hashCode ^
      modifier_par.hashCode ^
      id_marche.hashCode;
  }
}
