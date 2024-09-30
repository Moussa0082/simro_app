// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class OriginProduit {
    String? codeOriginProduit;
    String? nomOriginProduit;
    String? etat;
    String? idPersonnel;
    DateTime? modifierLe;
    DateTime? dateEnregistrement;
    String? modifierPar;
    int? idOriginProduit;

    OriginProduit({
         this.codeOriginProduit,
         this.nomOriginProduit,
         this.etat,
         this.idPersonnel,
         this.modifierLe,
         this.dateEnregistrement,
         this.modifierPar,
         this.idOriginProduit,
    });


  OriginProduit copyWith({
    String? codeOriginProduit,
    String? nomOriginProduit,
    String? etat,
    String? idPersonnel,
    DateTime? modifierLe,
    DateTime? dateEnregistrement,
    String? modifierPar,
    int? idOriginProduit,
  }) {
    return OriginProduit(
      codeOriginProduit: codeOriginProduit ?? this.codeOriginProduit,
      nomOriginProduit: nomOriginProduit ?? this.nomOriginProduit,
      etat: etat ?? this.etat,
      idPersonnel: idPersonnel ?? this.idPersonnel,
      modifierLe: modifierLe ?? this.modifierLe,
      dateEnregistrement: dateEnregistrement ?? this.dateEnregistrement,
      modifierPar: modifierPar ?? this.modifierPar,
      idOriginProduit: idOriginProduit ?? this.idOriginProduit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codeOriginProduit': codeOriginProduit,
      'nomOriginProduit': nomOriginProduit,
      'etat': etat,
      'idPersonnel': idPersonnel,
      'modifierLe': modifierLe?.millisecondsSinceEpoch,
      'dateEnregistrement': dateEnregistrement?.millisecondsSinceEpoch,
      'modifierPar': modifierPar,
      'idOriginProduit': idOriginProduit,
    };
  }

  factory OriginProduit.fromMap(Map<String, dynamic> map) {
    return OriginProduit(
      codeOriginProduit: map['codeOriginProduit'] != null ? map['codeOriginProduit'] as String : null,
      nomOriginProduit: map['nomOriginProduit'] != null ? map['nomOriginProduit'] as String : null,
      etat: map['etat'] != null ? map['etat'] as String : null,
      idPersonnel: map['idPersonnel'] != null ? map['idPersonnel'] as String : null,
      modifierLe: map['modifierLe'] != null ? DateTime.fromMillisecondsSinceEpoch(map['modifierLe'] as int) : null,
      dateEnregistrement: map['dateEnregistrement'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateEnregistrement'] as int) : null,
      modifierPar: map['modifierPar'] != null ? map['modifierPar'] as String : null,
      idOriginProduit: map['idOriginProduit'] != null ? map['idOriginProduit'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OriginProduit.fromJson(String source) => OriginProduit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OriginProduit(codeOriginProduit: $codeOriginProduit, nomOriginProduit: $nomOriginProduit, etat: $etat, idPersonnel: $idPersonnel, modifierLe: $modifierLe, dateEnregistrement: $dateEnregistrement, modifierPar: $modifierPar, idOriginProduit: $idOriginProduit)';
  }

  @override
  bool operator ==(covariant OriginProduit other) {
    if (identical(this, other)) return true;
  
    return 
      other.codeOriginProduit == codeOriginProduit &&
      other.nomOriginProduit == nomOriginProduit &&
      other.etat == etat &&
      other.idPersonnel == idPersonnel &&
      other.modifierLe == modifierLe &&
      other.dateEnregistrement == dateEnregistrement &&
      other.modifierPar == modifierPar &&
      other.idOriginProduit == idOriginProduit;
  }

  @override
  int get hashCode {
    return codeOriginProduit.hashCode ^
      nomOriginProduit.hashCode ^
      etat.hashCode ^
      idPersonnel.hashCode ^
      modifierLe.hashCode ^
      dateEnregistrement.hashCode ^
      modifierPar.hashCode ^
      idOriginProduit.hashCode;
  }
}
