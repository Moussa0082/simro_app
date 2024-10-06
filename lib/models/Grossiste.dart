// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Grossiste {
    String? code;
    String? nom;
    String? contact;
    String? localite;
    String? adresse;
    String? type_acteur;
    int? longitude;
    int? latitude;
    String? date_enregistrement;
    String? id_personnel;
    String? etat;
    String? modifier_le;
    String? modifier_par;
    int? id_grossiste;

    Grossiste({
         this.code,
         this.nom,
         this.contact,
         this.localite,
         this.adresse,
         this.type_acteur,
         this.longitude,
         this.latitude,
         this.date_enregistrement,
         this.id_personnel,
         this.etat,
         this.modifier_le,
         this.modifier_par,
         this.id_grossiste,
    });



  Grossiste copyWith({
    String? code,
    String? nom,
    String? contact,
    String? localite,
    String? adresse,
    String? type_acteur,
    int? longitude,
    int? latitude,
    String? date_enregistrement,
    String? id_personnel,
    String? etat,
    String? modifier_le,
    String? modifier_par,
    int? id_grossiste,
  }) {
    return Grossiste(
      code: code ?? this.code,
      nom: nom ?? this.nom,
      contact: contact ?? this.contact,
      localite: localite ?? this.localite,
      adresse: adresse ?? this.adresse,
      type_acteur: type_acteur ?? this.type_acteur,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      date_enregistrement: date_enregistrement ?? this.date_enregistrement,
      id_personnel: id_personnel ?? this.id_personnel,
      etat: etat ?? this.etat,
      modifier_le: modifier_le ?? this.modifier_le,
      modifier_par: modifier_par ?? this.modifier_par,
      id_grossiste: id_grossiste ?? this.id_grossiste,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'nom': nom,
      'contact': contact,
      'localite': localite,
      'adresse': adresse,
      'type_acteur': type_acteur,
      'longitude': longitude,
      'latitude': latitude,
      'date_enregistrement': date_enregistrement,
      'id_personnel': id_personnel,
      'etat': etat,
      'modifier_le': modifier_le,
      'modifier_par': modifier_par,
      'id_grossiste': id_grossiste,
    };
  }

  factory Grossiste.fromMap(Map<String, dynamic> map) {
    return Grossiste(
      code: map['code'] != null ? map['code'] as String : null,
      nom: map['nom'] != null ? map['nom'] as String : null,
      contact: map['contact'] != null ? map['contact'] as String : null,
      localite: map['localite'] != null ? map['localite'] as String : null,
      adresse: map['adresse'] != null ? map['adresse'] as String : null,
      type_acteur: map['type_acteur'] != null ? map['type_acteur'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as int : null,
      latitude: map['latitude'] != null ? map['latitude'] as int : null,
      date_enregistrement: map['date_enregistrement'] != null ? map['date_enregistrement'] as String : null,
      id_personnel: map['id_personnel'] != null ? map['id_personnel'] as String : null,
      etat: map['etat'] != null ? map['etat'] as String : null,
      modifier_le: map['modifier_le'] != null ? map['modifier_le'] as String : null,
      modifier_par: map['modifier_par'] != null ? map['modifier_par'] as String : null,
      id_grossiste: map['id_grossiste'] != null ? map['id_grossiste'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Grossiste.fromJson(String source) => Grossiste.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Grossiste(code: $code, nom: $nom, contact: $contact, localite: $localite, adresse: $adresse, type_acteur: $type_acteur, longitude: $longitude, latitude: $latitude, date_enregistrement: $date_enregistrement, id_personnel: $id_personnel, etat: $etat, modifier_le: $modifier_le, modifier_par: $modifier_par, id_grossiste: $id_grossiste)';
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
      other.type_acteur == type_acteur &&
      other.longitude == longitude &&
      other.latitude == latitude &&
      other.date_enregistrement == date_enregistrement &&
      other.id_personnel == id_personnel &&
      other.etat == etat &&
      other.modifier_le == modifier_le &&
      other.modifier_par == modifier_par &&
      other.id_grossiste == id_grossiste;
  }

  @override
  int get hashCode {
    return code.hashCode ^
      nom.hashCode ^
      contact.hashCode ^
      localite.hashCode ^
      adresse.hashCode ^
      type_acteur.hashCode ^
      longitude.hashCode ^
      latitude.hashCode ^
      date_enregistrement.hashCode ^
      id_personnel.hashCode ^
      etat.hashCode ^
      modifier_le.hashCode ^
      modifier_par.hashCode ^
      id_grossiste.hashCode;
  }
}
