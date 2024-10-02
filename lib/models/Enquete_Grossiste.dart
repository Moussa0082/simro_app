// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EnqueteGrossiste {
    String? num_fiche;
    String? marche;
    String? collecteur;
    String? date_enquete;
    String? date_enregistrement;
    String? id_personnel;
    String? etat;
    String? modifier_le;
    String? modifier_par;
    int? id_enquete;

    EnqueteGrossiste({
         this.num_fiche,
         this.marche,
         this.collecteur,
         this.date_enquete,
         this.date_enregistrement,
         this.id_personnel,
         this.etat,
         this.modifier_le,
         this.modifier_par,
         this.id_enquete,
    });



  EnqueteGrossiste copyWith({
    String? num_fiche,
    String? marche,
    String? collecteur,
    String? date_enquete,
    String? date_enregistrement,
    String? id_personnel,
    String? etat,
    String? modifier_le,
    String? modifier_par,
    int? id_enquete,
  }) {
    return EnqueteGrossiste(
      num_fiche: num_fiche ?? this.num_fiche,
      marche: marche ?? this.marche,
      collecteur: collecteur ?? this.collecteur,
      date_enquete: date_enquete ?? this.date_enquete,
      date_enregistrement: date_enregistrement ?? this.date_enregistrement,
      id_personnel: id_personnel ?? this.id_personnel,
      etat: etat ?? this.etat,
      modifier_le: modifier_le ?? this.modifier_le,
      modifier_par: modifier_par ?? this.modifier_par,
      id_enquete: id_enquete ?? this.id_enquete,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'num_fiche': num_fiche,
      'marche': marche,
      'collecteur': collecteur,
      'date_enquete': date_enquete,
      'date_enregistrement': date_enregistrement,
      'id_personnel': id_personnel,
      'etat': etat,
      'modifier_le': modifier_le,
      'modifier_par': modifier_par,
      'id_enquete': id_enquete,
    };
  }

  factory EnqueteGrossiste.fromMap(Map<String, dynamic> map) {
    return EnqueteGrossiste(
      num_fiche: map['num_fiche'] != null ? map['num_fiche'] as String : null,
      marche: map['marche'] != null ? map['marche'] as String : null,
      collecteur: map['collecteur'] != null ? map['collecteur'] as String : null,
      date_enquete: map['date_enquete'] != null ? map['date_enquete'] as String : null,
      date_enregistrement: map['date_enregistrement'] != null ? map['date_enregistrement'] as String : null,
      id_personnel: map['id_personnel'] != null ? map['id_personnel'] as String : null,
      etat: map['etat'] != null ? map['etat'] as String : null,
      modifier_le: map['modifier_le'] != null ? map['modifier_le'] as String : null,
      modifier_par: map['modifier_par'] != null ? map['modifier_par'] as String : null,
      id_enquete: map['id_enquete'] != null ? map['id_enquete'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EnqueteGrossiste.fromJson(String source) => EnqueteGrossiste.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EnqueteGrossiste(num_fiche: $num_fiche, marche: $marche, collecteur: $collecteur, date_enquete: $date_enquete, date_enregistrement: $date_enregistrement, id_personnel: $id_personnel, etat: $etat, modifier_le: $modifier_le, modifier_par: $modifier_par, id_enquete: $id_enquete)';
  }

  @override
  bool operator ==(covariant EnqueteGrossiste other) {
    if (identical(this, other)) return true;
  
    return 
      other.num_fiche == num_fiche &&
      other.marche == marche &&
      other.collecteur == collecteur &&
      other.date_enquete == date_enquete &&
      other.date_enregistrement == date_enregistrement &&
      other.id_personnel == id_personnel &&
      other.etat == etat &&
      other.modifier_le == modifier_le &&
      other.modifier_par == modifier_par &&
      other.id_enquete == id_enquete;
  }

  @override
  int get hashCode {
    return num_fiche.hashCode ^
      marche.hashCode ^
      collecteur.hashCode ^
      date_enquete.hashCode ^
      date_enregistrement.hashCode ^
      id_personnel.hashCode ^
      etat.hashCode ^
      modifier_le.hashCode ^
      modifier_par.hashCode ^
      id_enquete.hashCode;
  }
 }
