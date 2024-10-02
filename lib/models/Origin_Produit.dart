// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OriginProduit {
    String? code_origin_produit;
    String? nom_origin_produit;
    String? etat;
    String? id_personnel;
    String? modifier_le;
    String? date_enregistrement;
    String? modifier_par;
    int? id_origin_produit;

    OriginProduit({
         this.code_origin_produit,
         this.nom_origin_produit,
         this.etat,
         this.id_personnel,
         this.modifier_le,
         this.date_enregistrement,
         this.modifier_par,
         this.id_origin_produit,
    });



  OriginProduit copyWith({
    String? code_origin_produit,
    String? nom_origin_produit,
    String? etat,
    String? id_personnel,
    String? modifier_le,
    String? date_enregistrement,
    String? modifier_par,
    int? id_origin_produit,
  }) {
    return OriginProduit(
      code_origin_produit: code_origin_produit ?? this.code_origin_produit,
      nom_origin_produit: nom_origin_produit ?? this.nom_origin_produit,
      etat: etat ?? this.etat,
      id_personnel: id_personnel ?? this.id_personnel,
      modifier_le: modifier_le ?? this.modifier_le,
      date_enregistrement: date_enregistrement ?? this.date_enregistrement,
      modifier_par: modifier_par ?? this.modifier_par,
      id_origin_produit: id_origin_produit ?? this.id_origin_produit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code_origin_produit': code_origin_produit,
      'nom_origin_produit': nom_origin_produit,
      'etat': etat,
      'id_personnel': id_personnel,
      'modifier_le': modifier_le,
      'date_enregistrement': date_enregistrement,
      'modifier_par': modifier_par,
      'id_origin_produit': id_origin_produit,
    };
  }

  factory OriginProduit.fromMap(Map<String, dynamic> map) {
    return OriginProduit(
      code_origin_produit: map['code_origin_produit'] != null ? map['code_origin_produit'] as String : null,
      nom_origin_produit: map['nom_origin_produit'] != null ? map['nom_origin_produit'] as String : null,
      etat: map['etat'] != null ? map['etat'] as String : null,
      id_personnel: map['id_personnel'] != null ? map['id_personnel'] as String : null,
      modifier_le: map['modifier_le'] != null ? map['modifier_le'] as String : null,
      date_enregistrement: map['date_enregistrement'] != null ? map['date_enregistrement'] as String : null,
      modifier_par: map['modifier_par'] != null ? map['modifier_par'] as String : null,
      id_origin_produit: map['id_origin_produit'] != null ? map['id_origin_produit'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OriginProduit.fromJson(String source) => OriginProduit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OriginProduit(code_origin_produit: $code_origin_produit, nom_origin_produit: $nom_origin_produit, etat: $etat, id_personnel: $id_personnel, modifier_le: $modifier_le, date_enregistrement: $date_enregistrement, modifier_par: $modifier_par, id_origin_produit: $id_origin_produit)';
  }

  @override
  bool operator ==(covariant OriginProduit other) {
    if (identical(this, other)) return true;
  
    return 
      other.code_origin_produit == code_origin_produit &&
      other.nom_origin_produit == nom_origin_produit &&
      other.etat == etat &&
      other.id_personnel == id_personnel &&
      other.modifier_le == modifier_le &&
      other.date_enregistrement == date_enregistrement &&
      other.modifier_par == modifier_par &&
      other.id_origin_produit == id_origin_produit;
  }

  @override
  int get hashCode {
    return code_origin_produit.hashCode ^
      nom_origin_produit.hashCode ^
      etat.hashCode ^
      id_personnel.hashCode ^
      modifier_le.hashCode ^
      date_enregistrement.hashCode ^
      modifier_par.hashCode ^
      id_origin_produit.hashCode;
  }
}
