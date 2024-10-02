// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Enqueteur {
    int? idEnqueteur;
    String? code;
    String? nom;
    String? prenom;
    String? sexe;
    String? contact;
    String? localite;
    String? adresse;
    int? superviseur;
    String? description;
    String? appProfil;
    int? id_acteur;
    String? etat;
    String? date_enregistrement;
    String? id_personnel;
    String? modifier_le;
    String? modifier_par;

  Enqueteur({
    this.idEnqueteur,
    this.code,
    this.nom,
    this.prenom,
    this.sexe,
    this.contact,
    this.localite,
    this.adresse,
    this.superviseur,
    this.description,
    this.appProfil,
    this.id_acteur,
    this.etat,
    this.date_enregistrement,
    this.id_personnel,
    this.modifier_le,
    this.modifier_par,
  });
    


  Enqueteur copyWith({
    int? idEnqueteur,
    String? code,
    String? nom,
    String? prenom,
    String? sexe,
    String? contact,
    String? localite,
    String? adresse,
    int? superviseur,
    String? description,
    String? appProfil,
    int? id_acteur,
    String? etat,
    String? date_enregistrement,
    String? id_personnel,
    String? modifier_le,
    String? modifier_par,
  }) {
    return Enqueteur(
      idEnqueteur: idEnqueteur ?? this.idEnqueteur,
      code: code ?? this.code,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      sexe: sexe ?? this.sexe,
      contact: contact ?? this.contact,
      localite: localite ?? this.localite,
      adresse: adresse ?? this.adresse,
      superviseur: superviseur ?? this.superviseur,
      description: description ?? this.description,
      appProfil: appProfil ?? this.appProfil,
      id_acteur: id_acteur ?? this.id_acteur,
      etat: etat ?? this.etat,
      date_enregistrement: date_enregistrement ?? this.date_enregistrement,
      id_personnel: id_personnel ?? this.id_personnel,
      modifier_le: modifier_le ?? this.modifier_le,
      modifier_par: modifier_par ?? this.modifier_par,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idEnqueteur': idEnqueteur,
      'code': code,
      'nom': nom,
      'prenom': prenom,
      'sexe': sexe,
      'contact': contact,
      'localite': localite,
      'adresse': adresse,
      'superviseur': superviseur,
      'description': description,
      'appProfil': appProfil,
      'id_acteur': id_acteur,
      'etat': etat,
      'date_enregistrement': date_enregistrement,
      'id_personnel': id_personnel,
      'modifier_le': modifier_le,
      'modifier_par': modifier_par,
    };
  }

  factory Enqueteur.fromMap(Map<String, dynamic> map) {
    return Enqueteur(
      idEnqueteur: map['idEnqueteur'] != null ? map['idEnqueteur'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      nom: map['nom'] != null ? map['nom'] as String : null,
      prenom: map['prenom'] != null ? map['prenom'] as String : null,
      sexe: map['sexe'] != null ? map['sexe'] as String : null,
      contact: map['contact'] != null ? map['contact'] as String : null,
      localite: map['localite'] != null ? map['localite'] as String : null,
      adresse: map['adresse'] != null ? map['adresse'] as String : null,
      superviseur: map['superviseur'] != null ? map['superviseur'] as int : null,
      description: map['description'] != null ? map['description'] as String : null,
      appProfil: map['appProfil'] != null ? map['appProfil'] as String : null,
      id_acteur: map['id_acteur'] != null ? map['id_acteur'] as int : null,
      etat: map['etat'] != null ? map['etat'] as String : null,
      date_enregistrement: map['date_enregistrement'] != null ? map['date_enregistrement'] as String : null,
      id_personnel: map['id_personnel'] != null ? map['id_personnel'] as String : null,
      modifier_le: map['modifier_le'] != null ? map['modifier_le'] as String : null,
      modifier_par: map['modifier_par'] != null ? map['modifier_par'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Enqueteur.fromJson(String source) => Enqueteur.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Enqueteur(idEnqueteur: $idEnqueteur, code: $code, nom: $nom, prenom: $prenom, sexe: $sexe, contact: $contact, localite: $localite, adresse: $adresse, superviseur: $superviseur, description: $description, appProfil: $appProfil, id_acteur: $id_acteur, etat: $etat, date_enregistrement: $date_enregistrement, id_personnel: $id_personnel, modifier_le: $modifier_le, modifier_par: $modifier_par)';
  }

  @override
  bool operator ==(covariant Enqueteur other) {
    if (identical(this, other)) return true;
  
    return 
      other.idEnqueteur == idEnqueteur &&
      other.code == code &&
      other.nom == nom &&
      other.prenom == prenom &&
      other.sexe == sexe &&
      other.contact == contact &&
      other.localite == localite &&
      other.adresse == adresse &&
      other.superviseur == superviseur &&
      other.description == description &&
      other.appProfil == appProfil &&
      other.id_acteur == id_acteur &&
      other.etat == etat &&
      other.date_enregistrement == date_enregistrement &&
      other.id_personnel == id_personnel &&
      other.modifier_le == modifier_le &&
      other.modifier_par == modifier_par;
  }

  @override
  int get hashCode {
    return idEnqueteur.hashCode ^
      code.hashCode ^
      nom.hashCode ^
      prenom.hashCode ^
      sexe.hashCode ^
      contact.hashCode ^
      localite.hashCode ^
      adresse.hashCode ^
      superviseur.hashCode ^
      description.hashCode ^
      appProfil.hashCode ^
      id_acteur.hashCode ^
      etat.hashCode ^
      date_enregistrement.hashCode ^
      id_personnel.hashCode ^
      modifier_le.hashCode ^
      modifier_par.hashCode;
  }
}
