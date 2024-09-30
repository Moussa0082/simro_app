// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class FormeProduit {
    String? codeFormeProduit;
    String? nomFormeProduit;
    String? produitConcerne;
    String? etat;
    String? idPersonnel;
    DateTime? modifierLe;
    DateTime? dateEnregistrement;
    String? modifierPar;
    int? idFormeProduit;

    FormeProduit({
         this.codeFormeProduit,
         this.nomFormeProduit,
         this.produitConcerne,
         this.etat,
         this.idPersonnel,
         this.modifierLe,
         this.dateEnregistrement,
         this.modifierPar,
         this.idFormeProduit,
    });


  FormeProduit copyWith({
    String? codeFormeProduit,
    String? nomFormeProduit,
    String? produitConcerne,
    String? etat,
    String? idPersonnel,
    DateTime? modifierLe,
    DateTime? dateEnregistrement,
    String? modifierPar,
    int? idFormeProduit,
  }) {
    return FormeProduit(
      codeFormeProduit: codeFormeProduit ?? this.codeFormeProduit,
      nomFormeProduit: nomFormeProduit ?? this.nomFormeProduit,
      produitConcerne: produitConcerne ?? this.produitConcerne,
      etat: etat ?? this.etat,
      idPersonnel: idPersonnel ?? this.idPersonnel,
      modifierLe: modifierLe ?? this.modifierLe,
      dateEnregistrement: dateEnregistrement ?? this.dateEnregistrement,
      modifierPar: modifierPar ?? this.modifierPar,
      idFormeProduit: idFormeProduit ?? this.idFormeProduit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codeFormeProduit': codeFormeProduit,
      'nomFormeProduit': nomFormeProduit,
      'produitConcerne': produitConcerne,
      'etat': etat,
      'idPersonnel': idPersonnel,
      'modifierLe': modifierLe?.millisecondsSinceEpoch,
      'dateEnregistrement': dateEnregistrement?.millisecondsSinceEpoch,
      'modifierPar': modifierPar,
      'idFormeProduit': idFormeProduit,
    };
  }

  factory FormeProduit.fromMap(Map<String, dynamic> map) {
    return FormeProduit(
      codeFormeProduit: map['codeFormeProduit'] != null ? map['codeFormeProduit'] as String : null,
      nomFormeProduit: map['nomFormeProduit'] != null ? map['nomFormeProduit'] as String : null,
      produitConcerne: map['produitConcerne'] != null ? map['produitConcerne'] as String : null,
      etat: map['etat'] != null ? map['etat'] as String : null,
      idPersonnel: map['idPersonnel'] != null ? map['idPersonnel'] as String : null,
      modifierLe: map['modifierLe'] != null ? DateTime.fromMillisecondsSinceEpoch(map['modifierLe'] as int) : null,
      dateEnregistrement: map['dateEnregistrement'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateEnregistrement'] as int) : null,
      modifierPar: map['modifierPar'] != null ? map['modifierPar'] as String : null,
      idFormeProduit: map['idFormeProduit'] != null ? map['idFormeProduit'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormeProduit.fromJson(String source) => FormeProduit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FormeProduit(codeFormeProduit: $codeFormeProduit, nomFormeProduit: $nomFormeProduit, produitConcerne: $produitConcerne, etat: $etat, idPersonnel: $idPersonnel, modifierLe: $modifierLe, dateEnregistrement: $dateEnregistrement, modifierPar: $modifierPar, idFormeProduit: $idFormeProduit)';
  }

  @override
  bool operator ==(covariant FormeProduit other) {
    if (identical(this, other)) return true;
  
    return 
      other.codeFormeProduit == codeFormeProduit &&
      other.nomFormeProduit == nomFormeProduit &&
      other.produitConcerne == produitConcerne &&
      other.etat == etat &&
      other.idPersonnel == idPersonnel &&
      other.modifierLe == modifierLe &&
      other.dateEnregistrement == dateEnregistrement &&
      other.modifierPar == modifierPar &&
      other.idFormeProduit == idFormeProduit;
  }

  @override
  int get hashCode {
    return codeFormeProduit.hashCode ^
      nomFormeProduit.hashCode ^
      produitConcerne.hashCode ^
      etat.hashCode ^
      idPersonnel.hashCode ^
      modifierLe.hashCode ^
      dateEnregistrement.hashCode ^
      modifierPar.hashCode ^
      idFormeProduit.hashCode;
  }
}
