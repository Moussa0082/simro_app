// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';



class Commune {
    String? code_commune;
    String? nom_commune;
    String? abrege_commune;
    String? departement;
    int? prefecture;
    String? etat;
    String? id_personnel;
    String? date_enregistrement;
    String? modifier_le;
    String? modifier_par;
    int? id_commune;

    Commune({
         this.code_commune,
         this.nom_commune,
         this.abrege_commune,
         this.departement,
         this.prefecture,
         this.etat,
         this.id_personnel,
         this.date_enregistrement,
         this.modifier_le,
         this.modifier_par,
         this.id_commune,
    });


  Commune copyWith({
    String? code_commune,
    String? nom_commune,
    String? abrege_commune,
    String? departement,
    int? prefecture,
    String? etat,
    String? id_personnel,
    String? date_enregistrement,
    String? modifier_le,
    String? modifier_par,
    int? id_commune,
  }) {
    return Commune(
      code_commune: code_commune ?? this.code_commune,
      nom_commune: nom_commune ?? this.nom_commune,
      abrege_commune: abrege_commune ?? this.abrege_commune,
      departement: departement ?? this.departement,
      prefecture: prefecture ?? this.prefecture,
      etat: etat ?? this.etat,
      id_personnel: id_personnel ?? this.id_personnel,
      date_enregistrement: date_enregistrement ?? this.date_enregistrement,
      modifier_le: modifier_le ?? this.modifier_le,
      modifier_par: modifier_par ?? this.modifier_par,
      id_commune: id_commune ?? this.id_commune,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code_commune': code_commune,
      'nom_commune': nom_commune,
      'abrege_commune': abrege_commune,
      'departement': departement,
      'prefecture': prefecture,
      'etat': etat,
      'id_personnel': id_personnel,
      'date_enregistrement': date_enregistrement,
      'modifier_le': modifier_le,
      'modifier_par': modifier_par,
      'id_commune': id_commune,
    };
  }

  factory Commune.fromMap(Map<String, dynamic> map) {
    return Commune(
      code_commune: map['code_commune'] != null ? map['code_commune'] as String : null,
      nom_commune: map['nom_commune'] != null ? map['nom_commune'] as String : null,
      abrege_commune: map['abrege_commune'] != null ? map['abrege_commune'] as String : null,
      departement: map['departement'] != null ? map['departement'] as String : null,
      prefecture: map['prefecture'] != null ? map['prefecture'] as int : null,
      etat: map['etat'] != null ? map['etat'] as String : null,
      id_personnel: map['id_personnel'] != null ? map['id_personnel'] as String : null,
      date_enregistrement: map['date_enregistrement'] != null ? map['date_enregistrement'] as String : null,
      modifier_le: map['modifier_le'] != null ? map['modifier_le'] as String : null,
      modifier_par: map['modifier_par'] != null ? map['modifier_par'] as String : null,
      id_commune: map['id_commune'] != null ? map['id_commune'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Commune.fromJson(String source) => Commune.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Commune(code_commune: $code_commune, nom_commune: $nom_commune, abrege_commune: $abrege_commune, departement: $departement, prefecture: $prefecture, etat: $etat, id_personnel: $id_personnel, date_enregistrement: $date_enregistrement, modifier_le: $modifier_le, modifier_par: $modifier_par, id_commune: $id_commune)';
  }

  @override
  bool operator ==(covariant Commune other) {
    if (identical(this, other)) return true;
  
    return 
      other.code_commune == code_commune &&
      other.nom_commune == nom_commune &&
      other.abrege_commune == abrege_commune &&
      other.departement == departement &&
      other.prefecture == prefecture &&
      other.etat == etat &&
      other.id_personnel == id_personnel &&
      other.date_enregistrement == date_enregistrement &&
      other.modifier_le == modifier_le &&
      other.modifier_par == modifier_par &&
      other.id_commune == id_commune;
  }

  @override
  int get hashCode {
    return code_commune.hashCode ^
      nom_commune.hashCode ^
      abrege_commune.hashCode ^
      departement.hashCode ^
      prefecture.hashCode ^
      etat.hashCode ^
      id_personnel.hashCode ^
      date_enregistrement.hashCode ^
      modifier_le.hashCode ^
      modifier_par.hashCode ^
      id_commune.hashCode;
  }
}
