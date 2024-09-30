// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class EnqueteCollecte {
    String? numFiche;
    String? marche;
    String? collecteur;
    DateTime? dateEnquete;
    DateTime? dateEnregistrement;
    String? idPersonnel;
    String? etat;
    DateTime? modifierLe;
    String? modifierPar;
    int? idEnquete;

    EnqueteCollecte({
         this.numFiche,
         this.marche,
         this.collecteur,
         this.dateEnquete,
         this.dateEnregistrement,
         this.idPersonnel,
         this.etat,
         this.modifierLe,
         this.modifierPar,
         this.idEnquete,
    });


  EnqueteCollecte copyWith({
    String? numFiche,
    String? marche,
    String? collecteur,
    DateTime? dateEnquete,
    DateTime? dateEnregistrement,
    String? idPersonnel,
    String? etat,
    DateTime? modifierLe,
    String? modifierPar,
    int? idEnquete,
  }) {
    return EnqueteCollecte(
      numFiche: numFiche ?? this.numFiche,
      marche: marche ?? this.marche,
      collecteur: collecteur ?? this.collecteur,
      dateEnquete: dateEnquete ?? this.dateEnquete,
      dateEnregistrement: dateEnregistrement ?? this.dateEnregistrement,
      idPersonnel: idPersonnel ?? this.idPersonnel,
      etat: etat ?? this.etat,
      modifierLe: modifierLe ?? this.modifierLe,
      modifierPar: modifierPar ?? this.modifierPar,
      idEnquete: idEnquete ?? this.idEnquete,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'numFiche': numFiche,
      'marche': marche,
      'collecteur': collecteur,
      'dateEnquete': dateEnquete?.millisecondsSinceEpoch,
      'dateEnregistrement': dateEnregistrement?.millisecondsSinceEpoch,
      'idPersonnel': idPersonnel,
      'etat': etat,
      'modifierLe': modifierLe?.millisecondsSinceEpoch,
      'modifierPar': modifierPar,
      'idEnquete': idEnquete,
    };
  }

  factory EnqueteCollecte.fromMap(Map<String, dynamic> map) {
    return EnqueteCollecte(
      numFiche: map['numFiche'] != null ? map['numFiche'] as String : null,
      marche: map['marche'] != null ? map['marche'] as String : null,
      collecteur: map['collecteur'] != null ? map['collecteur'] as String : null,
      dateEnquete: map['dateEnquete'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateEnquete'] as int) : null,
      dateEnregistrement: map['dateEnregistrement'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateEnregistrement'] as int) : null,
      idPersonnel: map['idPersonnel'] != null ? map['idPersonnel'] as String : null,
      etat: map['etat'] != null ? map['etat'] as String : null,
      modifierLe: map['modifierLe'] != null ? DateTime.fromMillisecondsSinceEpoch(map['modifierLe'] as int) : null,
      modifierPar: map['modifierPar'] != null ? map['modifierPar'] as String : null,
      idEnquete: map['idEnquete'] != null ? map['idEnquete'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EnqueteCollecte.fromJson(String source) => EnqueteCollecte.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EnqueteCollecte(numFiche: $numFiche, marche: $marche, collecteur: $collecteur, dateEnquete: $dateEnquete, dateEnregistrement: $dateEnregistrement, idPersonnel: $idPersonnel, etat: $etat, modifierLe: $modifierLe, modifierPar: $modifierPar, idEnquete: $idEnquete)';
  }

  @override
  bool operator ==(covariant EnqueteCollecte other) {
    if (identical(this, other)) return true;
  
    return 
      other.numFiche == numFiche &&
      other.marche == marche &&
      other.collecteur == collecteur &&
      other.dateEnquete == dateEnquete &&
      other.dateEnregistrement == dateEnregistrement &&
      other.idPersonnel == idPersonnel &&
      other.etat == etat &&
      other.modifierLe == modifierLe &&
      other.modifierPar == modifierPar &&
      other.idEnquete == idEnquete;
  }

  @override
  int get hashCode {
    return numFiche.hashCode ^
      marche.hashCode ^
      collecteur.hashCode ^
      dateEnquete.hashCode ^
      dateEnregistrement.hashCode ^
      idPersonnel.hashCode ^
      etat.hashCode ^
      modifierLe.hashCode ^
      modifierPar.hashCode ^
      idEnquete.hashCode;
  }
}
