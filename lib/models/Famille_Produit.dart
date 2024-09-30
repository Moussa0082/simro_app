// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class FamilleProduit {
    String? codeFamilleProduit;
    String? nomFamilleProduit;
    int? affichageEcran;
    String? etat;
    String? idPersonnel;
    DateTime? modifierLe;
    DateTime? dateEnregistrement;
    String? modifierPar;
    int? idFamilleProduit;

    FamilleProduit({
         this.codeFamilleProduit,
         this.nomFamilleProduit,
         this.affichageEcran,
         this.etat,
         this.idPersonnel,
         this.modifierLe,
         this.dateEnregistrement,
         this.modifierPar,
         this.idFamilleProduit,
    });


  FamilleProduit copyWith({
    String? codeFamilleProduit,
    String? nomFamilleProduit,
    int? affichageEcran,
    String? etat,
    String? idPersonnel,
    DateTime? modifierLe,
    DateTime? dateEnregistrement,
    String? modifierPar,
    int? idFamilleProduit,
  }) {
    return FamilleProduit(
      codeFamilleProduit: codeFamilleProduit ?? this.codeFamilleProduit,
      nomFamilleProduit: nomFamilleProduit ?? this.nomFamilleProduit,
      affichageEcran: affichageEcran ?? this.affichageEcran,
      etat: etat ?? this.etat,
      idPersonnel: idPersonnel ?? this.idPersonnel,
      modifierLe: modifierLe ?? this.modifierLe,
      dateEnregistrement: dateEnregistrement ?? this.dateEnregistrement,
      modifierPar: modifierPar ?? this.modifierPar,
      idFamilleProduit: idFamilleProduit ?? this.idFamilleProduit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codeFamilleProduit': codeFamilleProduit,
      'nomFamilleProduit': nomFamilleProduit,
      'affichageEcran': affichageEcran,
      'etat': etat,
      'idPersonnel': idPersonnel,
      'modifierLe': modifierLe?.millisecondsSinceEpoch,
      'dateEnregistrement': dateEnregistrement?.millisecondsSinceEpoch,
      'modifierPar': modifierPar,
      'idFamilleProduit': idFamilleProduit,
    };
  }

  factory FamilleProduit.fromMap(Map<String, dynamic> map) {
    return FamilleProduit(
      codeFamilleProduit: map['codeFamilleProduit'] != null ? map['codeFamilleProduit'] as String : null,
      nomFamilleProduit: map['nomFamilleProduit'] != null ? map['nomFamilleProduit'] as String : null,
      affichageEcran: map['affichageEcran'] != null ? map['affichageEcran'] as int : null,
      etat: map['etat'] != null ? map['etat'] as String : null,
      idPersonnel: map['idPersonnel'] != null ? map['idPersonnel'] as String : null,
      modifierLe: map['modifierLe'] != null ? DateTime.fromMillisecondsSinceEpoch(map['modifierLe'] as int) : null,
      dateEnregistrement: map['dateEnregistrement'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateEnregistrement'] as int) : null,
      modifierPar: map['modifierPar'] != null ? map['modifierPar'] as String : null,
      idFamilleProduit: map['idFamilleProduit'] != null ? map['idFamilleProduit'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FamilleProduit.fromJson(String source) => FamilleProduit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FamilleProduit(codeFamilleProduit: $codeFamilleProduit, nomFamilleProduit: $nomFamilleProduit, affichageEcran: $affichageEcran, etat: $etat, idPersonnel: $idPersonnel, modifierLe: $modifierLe, dateEnregistrement: $dateEnregistrement, modifierPar: $modifierPar, idFamilleProduit: $idFamilleProduit)';
  }

  @override
  bool operator ==(covariant FamilleProduit other) {
    if (identical(this, other)) return true;
  
    return 
      other.codeFamilleProduit == codeFamilleProduit &&
      other.nomFamilleProduit == nomFamilleProduit &&
      other.affichageEcran == affichageEcran &&
      other.etat == etat &&
      other.idPersonnel == idPersonnel &&
      other.modifierLe == modifierLe &&
      other.dateEnregistrement == dateEnregistrement &&
      other.modifierPar == modifierPar &&
      other.idFamilleProduit == idFamilleProduit;
  }

  @override
  int get hashCode {
    return codeFamilleProduit.hashCode ^
      nomFamilleProduit.hashCode ^
      affichageEcran.hashCode ^
      etat.hashCode ^
      idPersonnel.hashCode ^
      modifierLe.hashCode ^
      dateEnregistrement.hashCode ^
      modifierPar.hashCode ^
      idFamilleProduit.hashCode;
  }
}
