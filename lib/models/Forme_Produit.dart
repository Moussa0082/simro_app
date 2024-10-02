// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FormeProduit {
    String? code_forme_produit;
    String? nom_forme_produit;
    String? produit_concerne;
    String? etat;
    String? idPersonnel;
    String? modifier_le;
    String? date_enregistrement;
    String? modifier_par;
    int? idForme_produit;

    FormeProduit({
         this.code_forme_produit,
         this.nom_forme_produit,
         this.produit_concerne,
         this.etat,
         this.idPersonnel,
         this.modifier_le,
         this.date_enregistrement,
         this.modifier_par,
         this.idForme_produit,
    });



  FormeProduit copyWith({
    String? code_forme_produit,
    String? nom_forme_produit,
    String? produit_concerne,
    String? etat,
    String? idPersonnel,
    String? modifier_le,
    String? date_enregistrement,
    String? modifier_par,
    int? idForme_produit,
  }) {
    return FormeProduit(
      code_forme_produit: code_forme_produit ?? this.code_forme_produit,
      nom_forme_produit: nom_forme_produit ?? this.nom_forme_produit,
      produit_concerne: produit_concerne ?? this.produit_concerne,
      etat: etat ?? this.etat,
      idPersonnel: idPersonnel ?? this.idPersonnel,
      modifier_le: modifier_le ?? this.modifier_le,
      date_enregistrement: date_enregistrement ?? this.date_enregistrement,
      modifier_par: modifier_par ?? this.modifier_par,
      idForme_produit: idForme_produit ?? this.idForme_produit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code_forme_produit': code_forme_produit,
      'nom_forme_produit': nom_forme_produit,
      'produit_concerne': produit_concerne,
      'etat': etat,
      'idPersonnel': idPersonnel,
      'modifier_le': modifier_le,
      'date_enregistrement': date_enregistrement,
      'modifier_par': modifier_par,
      'idForme_produit': idForme_produit,
    };
  }

  factory FormeProduit.fromMap(Map<String, dynamic> map) {
    return FormeProduit(
      code_forme_produit: map['code_forme_produit'] != null ? map['code_forme_produit'] as String : null,
      nom_forme_produit: map['nom_forme_produit'] != null ? map['nom_forme_produit'] as String : null,
      produit_concerne: map['produit_concerne'] != null ? map['produit_concerne'] as String : null,
      etat: map['etat'] != null ? map['etat'] as String : null,
      idPersonnel: map['idPersonnel'] != null ? map['idPersonnel'] as String : null,
      modifier_le: map['modifier_le'] != null ? map['modifier_le'] as String : null,
      date_enregistrement: map['date_enregistrement'] != null ? map['date_enregistrement'] as String : null,
      modifier_par: map['modifier_par'] != null ? map['modifier_par'] as String : null,
      idForme_produit: map['idForme_produit'] != null ? map['idForme_produit'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormeProduit.fromJson(String source) => FormeProduit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FormeProduit(code_forme_produit: $code_forme_produit, nom_forme_produit: $nom_forme_produit, produit_concerne: $produit_concerne, etat: $etat, idPersonnel: $idPersonnel, modifier_le: $modifier_le, date_enregistrement: $date_enregistrement, modifier_par: $modifier_par, idForme_produit: $idForme_produit)';
  }

  @override
  bool operator ==(covariant FormeProduit other) {
    if (identical(this, other)) return true;
  
    return 
      other.code_forme_produit == code_forme_produit &&
      other.nom_forme_produit == nom_forme_produit &&
      other.produit_concerne == produit_concerne &&
      other.etat == etat &&
      other.idPersonnel == idPersonnel &&
      other.modifier_le == modifier_le &&
      other.date_enregistrement == date_enregistrement &&
      other.modifier_par == modifier_par &&
      other.idForme_produit == idForme_produit;
  }

  @override
  int get hashCode {
    return code_forme_produit.hashCode ^
      nom_forme_produit.hashCode ^
      produit_concerne.hashCode ^
      etat.hashCode ^
      idPersonnel.hashCode ^
      modifier_le.hashCode ^
      date_enregistrement.hashCode ^
      modifier_par.hashCode ^
      idForme_produit.hashCode;
  }
}
