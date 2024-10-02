// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FamilleProduit {
    String? code_famille_produit;
    String? nom_famille_produit;
    int? affichage_ecran;
    String? etat;
    String? idPersonnel;
    String? modifier_le;
    String? date_enregistrement;
    String? modifier_par;
    int? idFamille_produit;

    FamilleProduit({
         this.code_famille_produit,
         this.nom_famille_produit,
         this.affichage_ecran,
         this.etat,
         this.idPersonnel,
         this.modifier_le,
         this.date_enregistrement,
         this.modifier_par,
         this.idFamille_produit,
    });



  FamilleProduit copyWith({
    String? code_famille_produit,
    String? nom_famille_produit,
    int? affichage_ecran,
    String? etat,
    String? idPersonnel,
    String? modifier_le,
    String? date_enregistrement,
    String? modifier_par,
    int? idFamille_produit,
  }) {
    return FamilleProduit(
      code_famille_produit: code_famille_produit ?? this.code_famille_produit,
      nom_famille_produit: nom_famille_produit ?? this.nom_famille_produit,
      affichage_ecran: affichage_ecran ?? this.affichage_ecran,
      etat: etat ?? this.etat,
      idPersonnel: idPersonnel ?? this.idPersonnel,
      modifier_le: modifier_le ?? this.modifier_le,
      date_enregistrement: date_enregistrement ?? this.date_enregistrement,
      modifier_par: modifier_par ?? this.modifier_par,
      idFamille_produit: idFamille_produit ?? this.idFamille_produit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code_famille_produit': code_famille_produit,
      'nom_famille_produit': nom_famille_produit,
      'affichage_ecran': affichage_ecran,
      'etat': etat,
      'idPersonnel': idPersonnel,
      'modifier_le': modifier_le,
      'date_enregistrement': date_enregistrement,
      'modifier_par': modifier_par,
      'idFamille_produit': idFamille_produit,
    };
  }

  factory FamilleProduit.fromMap(Map<String, dynamic> map) {
    return FamilleProduit(
      code_famille_produit: map['code_famille_produit'] != null ? map['code_famille_produit'] as String : null,
      nom_famille_produit: map['nom_famille_produit'] != null ? map['nom_famille_produit'] as String : null,
      affichage_ecran: map['affichage_ecran'] != null ? map['affichage_ecran'] as int : null,
      etat: map['etat'] != null ? map['etat'] as String : null,
      idPersonnel: map['idPersonnel'] != null ? map['idPersonnel'] as String : null,
      modifier_le: map['modifier_le'] != null ? map['modifier_le'] as String : null,
      date_enregistrement: map['date_enregistrement'] != null ? map['date_enregistrement'] as String : null,
      modifier_par: map['modifier_par'] != null ? map['modifier_par'] as String : null,
      idFamille_produit: map['idFamille_produit'] != null ? map['idFamille_produit'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FamilleProduit.fromJson(String source) => FamilleProduit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FamilleProduit(code_famille_produit: $code_famille_produit, nom_famille_produit: $nom_famille_produit, affichage_ecran: $affichage_ecran, etat: $etat, idPersonnel: $idPersonnel, modifier_le: $modifier_le, date_enregistrement: $date_enregistrement, modifier_par: $modifier_par, idFamille_produit: $idFamille_produit)';
  }

  @override
  bool operator ==(covariant FamilleProduit other) {
    if (identical(this, other)) return true;
  
    return 
      other.code_famille_produit == code_famille_produit &&
      other.nom_famille_produit == nom_famille_produit &&
      other.affichage_ecran == affichage_ecran &&
      other.etat == etat &&
      other.idPersonnel == idPersonnel &&
      other.modifier_le == modifier_le &&
      other.date_enregistrement == date_enregistrement &&
      other.modifier_par == modifier_par &&
      other.idFamille_produit == idFamille_produit;
  }

  @override
  int get hashCode {
    return code_famille_produit.hashCode ^
      nom_famille_produit.hashCode ^
      affichage_ecran.hashCode ^
      etat.hashCode ^
      idPersonnel.hashCode ^
      modifier_le.hashCode ^
      date_enregistrement.hashCode ^
      modifier_par.hashCode ^
      idFamille_produit.hashCode;
  }
}
