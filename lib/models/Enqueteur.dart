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
    int? idActeur;
    String? etat;
    DateTime? dateEnregistrement;
    String? idPersonnel;
    DateTime? modifierLe;
    String? modifierPar;

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
    this.idActeur,
    this.etat,
    this.dateEnregistrement,
    this.idPersonnel,
    this.modifierLe,
    this.modifierPar,
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
    int? idActeur,
    String? etat,
    DateTime? dateEnregistrement,
    String? idPersonnel,
    DateTime? modifierLe,
    String? modifierPar,
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
      idActeur: idActeur ?? this.idActeur,
      etat: etat ?? this.etat,
      dateEnregistrement: dateEnregistrement ?? this.dateEnregistrement,
      idPersonnel: idPersonnel ?? this.idPersonnel,
      modifierLe: modifierLe ?? this.modifierLe,
      modifierPar: modifierPar ?? this.modifierPar,
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
      'idActeur': idActeur,
      'etat': etat,
      'dateEnregistrement': dateEnregistrement?.millisecondsSinceEpoch,
      'idPersonnel': idPersonnel,
      'modifierLe': modifierLe?.millisecondsSinceEpoch,
      'modifierPar': modifierPar,
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
      idActeur: map['idActeur'] != null ? map['idActeur'] as int : null,
      etat: map['etat'] != null ? map['etat'] as String : null,
      dateEnregistrement: map['dateEnregistrement'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateEnregistrement'] as int) : null,
      idPersonnel: map['idPersonnel'] != null ? map['idPersonnel'] as String : null,
      modifierLe: map['modifierLe'] != null ? DateTime.fromMillisecondsSinceEpoch(map['modifierLe'] as int) : null,
      modifierPar: map['modifierPar'] != null ? map['modifierPar'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Enqueteur.fromJson(String source) => Enqueteur.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Enqueteur(idEnqueteur: $idEnqueteur, code: $code, nom: $nom, prenom: $prenom, sexe: $sexe, contact: $contact, localite: $localite, adresse: $adresse, superviseur: $superviseur, description: $description, appProfil: $appProfil, idActeur: $idActeur, etat: $etat, dateEnregistrement: $dateEnregistrement, idPersonnel: $idPersonnel, modifierLe: $modifierLe, modifierPar: $modifierPar)';
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
      other.idActeur == idActeur &&
      other.etat == etat &&
      other.dateEnregistrement == dateEnregistrement &&
      other.idPersonnel == idPersonnel &&
      other.modifierLe == modifierLe &&
      other.modifierPar == modifierPar;
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
      idActeur.hashCode ^
      etat.hashCode ^
      dateEnregistrement.hashCode ^
      idPersonnel.hashCode ^
      modifierLe.hashCode ^
      modifierPar.hashCode;
  }
}
