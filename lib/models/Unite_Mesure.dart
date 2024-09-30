// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class UniteMesure {
    String? nomUnite;
    String? definition;
    int? poidsIndicatif;
    DateTime? dateEnregistrement;
    String? idPersonnel;
    DateTime? modifierLe;
    String? modifierPar;
    int? idUnite;

    UniteMesure({
         this.nomUnite,
         this.definition,
         this.poidsIndicatif,
         this.dateEnregistrement,
         this.idPersonnel,
         this.modifierLe,
         this.modifierPar,
         this.idUnite,
    });

  UniteMesure copyWith({
    String? nomUnite,
    String? definition,
    int? poidsIndicatif,
    DateTime? dateEnregistrement,
    String? idPersonnel,
    DateTime? modifierLe,
    String? modifierPar,
    int? idUnite,
  }) {
    return UniteMesure(
      nomUnite: nomUnite ?? this.nomUnite,
      definition: definition ?? this.definition,
      poidsIndicatif: poidsIndicatif ?? this.poidsIndicatif,
      dateEnregistrement: dateEnregistrement ?? this.dateEnregistrement,
      idPersonnel: idPersonnel ?? this.idPersonnel,
      modifierLe: modifierLe ?? this.modifierLe,
      modifierPar: modifierPar ?? this.modifierPar,
      idUnite: idUnite ?? this.idUnite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nomUnite': nomUnite,
      'definition': definition,
      'poidsIndicatif': poidsIndicatif,
      'dateEnregistrement': dateEnregistrement?.millisecondsSinceEpoch,
      'idPersonnel': idPersonnel,
      'modifierLe': modifierLe?.millisecondsSinceEpoch,
      'modifierPar': modifierPar,
      'idUnite': idUnite,
    };
  }

  factory UniteMesure.fromMap(Map<String, dynamic> map) {
    return UniteMesure(
      nomUnite: map['nomUnite'] != null ? map['nomUnite'] as String : null,
      definition: map['definition'] != null ? map['definition'] as String : null,
      poidsIndicatif: map['poidsIndicatif'] != null ? map['poidsIndicatif'] as int : null,
      dateEnregistrement: map['dateEnregistrement'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateEnregistrement'] as int) : null,
      idPersonnel: map['idPersonnel'] != null ? map['idPersonnel'] as String : null,
      modifierLe: map['modifierLe'] != null ? DateTime.fromMillisecondsSinceEpoch(map['modifierLe'] as int) : null,
      modifierPar: map['modifierPar'] != null ? map['modifierPar'] as String : null,
      idUnite: map['idUnite'] != null ? map['idUnite'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UniteMesure.fromJson(String source) => UniteMesure.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UniteMesure(nomUnite: $nomUnite, definition: $definition, poidsIndicatif: $poidsIndicatif, dateEnregistrement: $dateEnregistrement, idPersonnel: $idPersonnel, modifierLe: $modifierLe, modifierPar: $modifierPar, idUnite: $idUnite)';
  }

  @override
  bool operator ==(covariant UniteMesure other) {
    if (identical(this, other)) return true;
  
    return 
      other.nomUnite == nomUnite &&
      other.definition == definition &&
      other.poidsIndicatif == poidsIndicatif &&
      other.dateEnregistrement == dateEnregistrement &&
      other.idPersonnel == idPersonnel &&
      other.modifierLe == modifierLe &&
      other.modifierPar == modifierPar &&
      other.idUnite == idUnite;
  }

  @override
  int get hashCode {
    return nomUnite.hashCode ^
      definition.hashCode ^
      poidsIndicatif.hashCode ^
      dateEnregistrement.hashCode ^
      idPersonnel.hashCode ^
      modifierLe.hashCode ^
      modifierPar.hashCode ^
      idUnite.hashCode;
  }
}
