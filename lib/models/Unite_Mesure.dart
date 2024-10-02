// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UniteMesure {
    String? nom_unite;
    String? definition;
    int? poids_indicatif;
    DateTime? date_enregistrement;
    String? id_personnel;
    String? modifier_le;
    String? modifier_par;
    int? id_unite;

    UniteMesure({
         this.nom_unite,
         this.definition,
         this.poids_indicatif,
         this.date_enregistrement,
         this.id_personnel,
         this.modifier_le,
         this.modifier_par,
         this.id_unite,
    });


  UniteMesure copyWith({
    String? nom_unite,
    String? definition,
    int? poids_indicatif,
    DateTime? date_enregistrement,
    String? id_personnel,
    String? modifier_le,
    String? modifier_par,
    int? id_unite,
  }) {
    return UniteMesure(
      nom_unite: nom_unite ?? this.nom_unite,
      definition: definition ?? this.definition,
      poids_indicatif: poids_indicatif ?? this.poids_indicatif,
      date_enregistrement: date_enregistrement ?? this.date_enregistrement,
      id_personnel: id_personnel ?? this.id_personnel,
      modifier_le: modifier_le ?? this.modifier_le,
      modifier_par: modifier_par ?? this.modifier_par,
      id_unite: id_unite ?? this.id_unite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nom_unite': nom_unite,
      'definition': definition,
      'poids_indicatif': poids_indicatif,
      'date_enregistrement': date_enregistrement?.millisecondsSinceEpoch,
      'id_personnel': id_personnel,
      'modifier_le': modifier_le,
      'modifier_par': modifier_par,
      'id_unite': id_unite,
    };
  }

  factory UniteMesure.fromMap(Map<String, dynamic> map) {
    return UniteMesure(
      nom_unite: map['nom_unite'] != null ? map['nom_unite'] as String : null,
      definition: map['definition'] != null ? map['definition'] as String : null,
      poids_indicatif: map['poids_indicatif'] != null ? map['poids_indicatif'] as int : null,
      date_enregistrement: map['date_enregistrement'] != null ? DateTime.fromMillisecondsSinceEpoch(map['date_enregistrement'] as int) : null,
      id_personnel: map['id_personnel'] != null ? map['id_personnel'] as String : null,
      modifier_le: map['modifier_le'] != null ? map['modifier_le'] as String : null,
      modifier_par: map['modifier_par'] != null ? map['modifier_par'] as String : null,
      id_unite: map['id_unite'] != null ? map['id_unite'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UniteMesure.fromJson(String source) => UniteMesure.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UniteMesure(nom_unite: $nom_unite, definition: $definition, poids_indicatif: $poids_indicatif, date_enregistrement: $date_enregistrement, id_personnel: $id_personnel, modifier_le: $modifier_le, modifier_par: $modifier_par, id_unite: $id_unite)';
  }

  @override
  bool operator ==(covariant UniteMesure other) {
    if (identical(this, other)) return true;
  
    return 
      other.nom_unite == nom_unite &&
      other.definition == definition &&
      other.poids_indicatif == poids_indicatif &&
      other.date_enregistrement == date_enregistrement &&
      other.id_personnel == id_personnel &&
      other.modifier_le == modifier_le &&
      other.modifier_par == modifier_par &&
      other.id_unite == id_unite;
  }

  @override
  int get hashCode {
    return nom_unite.hashCode ^
      definition.hashCode ^
      poids_indicatif.hashCode ^
      date_enregistrement.hashCode ^
      id_personnel.hashCode ^
      modifier_le.hashCode ^
      modifier_par.hashCode ^
      id_unite.hashCode;
  }
}
