// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Grossiste {
    String? code;
    String? nom;
    String? contact;
    String? localite;
    String? adresse;
    String? typeActeur;
    int? longitude;
    int? latitude;
    DateTime? dateEnregistrement;
    String? idPersonnel;
    String? etat;
    DateTime? modifierLe;
    String? modifierPar;
    int? idGrossiste;

    Grossiste({
         this.code,
         this.nom,
         this.contact,
         this.localite,
         this.adresse,
         this.typeActeur,
         this.longitude,
         this.latitude,
         this.dateEnregistrement,
         this.idPersonnel,
         this.etat,
         this.modifierLe,
         this.modifierPar,
         this.idGrossiste,
    });


  Grossiste copyWith({
    String? code,
    String? nom,
    String? contact,
    String? localite,
    String? adresse,
    String? typeActeur,
    int? longitude,
    int? latitude,
    DateTime? dateEnregistrement,
    String? idPersonnel,
    String? etat,
    DateTime? modifierLe,
    String? modifierPar,
    int? idGrossiste,
  }) {
    return Grossiste(
      code: code ?? this.code,
      nom: nom ?? this.nom,
      contact: contact ?? this.contact,
      localite: localite ?? this.localite,
      adresse: adresse ?? this.adresse,
      typeActeur: typeActeur ?? this.typeActeur,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      dateEnregistrement: dateEnregistrement ?? this.dateEnregistrement,
      idPersonnel: idPersonnel ?? this.idPersonnel,
      etat: etat ?? this.etat,
      modifierLe: modifierLe ?? this.modifierLe,
      modifierPar: modifierPar ?? this.modifierPar,
      idGrossiste: idGrossiste ?? this.idGrossiste,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'nom': nom,
      'contact': contact,
      'localite': localite,
      'adresse': adresse,
      'typeActeur': typeActeur,
      'longitude': longitude,
      'latitude': latitude,
      'dateEnregistrement': dateEnregistrement?.millisecondsSinceEpoch,
      'idPersonnel': idPersonnel,
      'etat': etat,
      'modifierLe': modifierLe?.millisecondsSinceEpoch,
      'modifierPar': modifierPar,
      'idGrossiste': idGrossiste,
    };
  }

  factory Grossiste.fromMap(Map<String, dynamic> map) {
    return Grossiste(
      code: map['code'] != null ? map['code'] as String : null,
      nom: map['nom'] != null ? map['nom'] as String : null,
      contact: map['contact'] != null ? map['contact'] as String : null,
      localite: map['localite'] != null ? map['localite'] as String : null,
      adresse: map['adresse'] != null ? map['adresse'] as String : null,
      typeActeur: map['typeActeur'] != null ? map['typeActeur'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as int : null,
      latitude: map['latitude'] != null ? map['latitude'] as int : null,
      dateEnregistrement: map['dateEnregistrement'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateEnregistrement'] as int) : null,
      idPersonnel: map['idPersonnel'] != null ? map['idPersonnel'] as String : null,
      etat: map['etat'] != null ? map['etat'] as String : null,
      modifierLe: map['modifierLe'] != null ? DateTime.fromMillisecondsSinceEpoch(map['modifierLe'] as int) : null,
      modifierPar: map['modifierPar'] != null ? map['modifierPar'] as String : null,
      idGrossiste: map['idGrossiste'] != null ? map['idGrossiste'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Grossiste.fromJson(String source) => Grossiste.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Grossiste(code: $code, nom: $nom, contact: $contact, localite: $localite, adresse: $adresse, typeActeur: $typeActeur, longitude: $longitude, latitude: $latitude, dateEnregistrement: $dateEnregistrement, idPersonnel: $idPersonnel, etat: $etat, modifierLe: $modifierLe, modifierPar: $modifierPar, idGrossiste: $idGrossiste)';
  }

  @override
  bool operator ==(covariant Grossiste other) {
    if (identical(this, other)) return true;
  
    return 
      other.code == code &&
      other.nom == nom &&
      other.contact == contact &&
      other.localite == localite &&
      other.adresse == adresse &&
      other.typeActeur == typeActeur &&
      other.longitude == longitude &&
      other.latitude == latitude &&
      other.dateEnregistrement == dateEnregistrement &&
      other.idPersonnel == idPersonnel &&
      other.etat == etat &&
      other.modifierLe == modifierLe &&
      other.modifierPar == modifierPar &&
      other.idGrossiste == idGrossiste;
  }

  @override
  int get hashCode {
    return code.hashCode ^
      nom.hashCode ^
      contact.hashCode ^
      localite.hashCode ^
      adresse.hashCode ^
      typeActeur.hashCode ^
      longitude.hashCode ^
      latitude.hashCode ^
      dateEnregistrement.hashCode ^
      idPersonnel.hashCode ^
      etat.hashCode ^
      modifierLe.hashCode ^
      modifierPar.hashCode ^
      idGrossiste.hashCode;
  }
}
