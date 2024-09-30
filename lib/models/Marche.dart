// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Marche {
    String? codeMarche;
    String? nomMarche;
    String? typeMarche;
    String? jourMarche;
    String? localite;
    int? longitude;
    int? latitude;
    int? superficie;
    String? description;
    int? commune;
    String? collecteur;
    String? idPersonnel;
    DateTime? dateEnregistrement;
    DateTime? modifierLe;
    String? modifierPar;
    int? idMarche;

    Marche({
         this.codeMarche,
         this.nomMarche,
         this.typeMarche,
         this.jourMarche,
         this.localite,
         this.longitude,
         this.latitude,
         this.superficie,
         this.description,
         this.commune,
         this.collecteur,
         this.idPersonnel,
         this.dateEnregistrement,
         this.modifierLe,
         this.modifierPar,
         this.idMarche,
    });


  Marche copyWith({
    String? codeMarche,
    String? nomMarche,
    String? typeMarche,
    String? jourMarche,
    String? localite,
    int? longitude,
    int? latitude,
    int? superficie,
    String? description,
    int? commune,
    String? collecteur,
    String? idPersonnel,
    DateTime? dateEnregistrement,
    DateTime? modifierLe,
    String? modifierPar,
    int? idMarche,
  }) {
    return Marche(
      codeMarche: codeMarche ?? this.codeMarche,
      nomMarche: nomMarche ?? this.nomMarche,
      typeMarche: typeMarche ?? this.typeMarche,
      jourMarche: jourMarche ?? this.jourMarche,
      localite: localite ?? this.localite,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      superficie: superficie ?? this.superficie,
      description: description ?? this.description,
      commune: commune ?? this.commune,
      collecteur: collecteur ?? this.collecteur,
      idPersonnel: idPersonnel ?? this.idPersonnel,
      dateEnregistrement: dateEnregistrement ?? this.dateEnregistrement,
      modifierLe: modifierLe ?? this.modifierLe,
      modifierPar: modifierPar ?? this.modifierPar,
      idMarche: idMarche ?? this.idMarche,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codeMarche': codeMarche,
      'nomMarche': nomMarche,
      'typeMarche': typeMarche,
      'jourMarche': jourMarche,
      'localite': localite,
      'longitude': longitude,
      'latitude': latitude,
      'superficie': superficie,
      'description': description,
      'commune': commune,
      'collecteur': collecteur,
      'idPersonnel': idPersonnel,
      'dateEnregistrement': dateEnregistrement?.millisecondsSinceEpoch,
      'modifierLe': modifierLe?.millisecondsSinceEpoch,
      'modifierPar': modifierPar,
      'idMarche': idMarche,
    };
  }

  factory Marche.fromMap(Map<String, dynamic> map) {
    return Marche(
      codeMarche: map['codeMarche'] != null ? map['codeMarche'] as String : null,
      nomMarche: map['nomMarche'] != null ? map['nomMarche'] as String : null,
      typeMarche: map['typeMarche'] != null ? map['typeMarche'] as String : null,
      jourMarche: map['jourMarche'] != null ? map['jourMarche'] as String : null,
      localite: map['localite'] != null ? map['localite'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as int : null,
      latitude: map['latitude'] != null ? map['latitude'] as int : null,
      superficie: map['superficie'] != null ? map['superficie'] as int : null,
      description: map['description'] != null ? map['description'] as String : null,
      commune: map['commune'] != null ? map['commune'] as int : null,
      collecteur: map['collecteur'] != null ? map['collecteur'] as String : null,
      idPersonnel: map['idPersonnel'] != null ? map['idPersonnel'] as String : null,
      dateEnregistrement: map['dateEnregistrement'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateEnregistrement'] as int) : null,
      modifierLe: map['modifierLe'] != null ? DateTime.fromMillisecondsSinceEpoch(map['modifierLe'] as int) : null,
      modifierPar: map['modifierPar'] != null ? map['modifierPar'] as String : null,
      idMarche: map['idMarche'] != null ? map['idMarche'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Marche.fromJson(String source) => Marche.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Marche(codeMarche: $codeMarche, nomMarche: $nomMarche, typeMarche: $typeMarche, jourMarche: $jourMarche, localite: $localite, longitude: $longitude, latitude: $latitude, superficie: $superficie, description: $description, commune: $commune, collecteur: $collecteur, idPersonnel: $idPersonnel, dateEnregistrement: $dateEnregistrement, modifierLe: $modifierLe, modifierPar: $modifierPar, idMarche: $idMarche)';
  }

  @override
  bool operator ==(covariant Marche other) {
    if (identical(this, other)) return true;
  
    return 
      other.codeMarche == codeMarche &&
      other.nomMarche == nomMarche &&
      other.typeMarche == typeMarche &&
      other.jourMarche == jourMarche &&
      other.localite == localite &&
      other.longitude == longitude &&
      other.latitude == latitude &&
      other.superficie == superficie &&
      other.description == description &&
      other.commune == commune &&
      other.collecteur == collecteur &&
      other.idPersonnel == idPersonnel &&
      other.dateEnregistrement == dateEnregistrement &&
      other.modifierLe == modifierLe &&
      other.modifierPar == modifierPar &&
      other.idMarche == idMarche;
  }

  @override
  int get hashCode {
    return codeMarche.hashCode ^
      nomMarche.hashCode ^
      typeMarche.hashCode ^
      jourMarche.hashCode ^
      localite.hashCode ^
      longitude.hashCode ^
      latitude.hashCode ^
      superficie.hashCode ^
      description.hashCode ^
      commune.hashCode ^
      collecteur.hashCode ^
      idPersonnel.hashCode ^
      dateEnregistrement.hashCode ^
      modifierLe.hashCode ^
      modifierPar.hashCode ^
      idMarche.hashCode;
  }
}
