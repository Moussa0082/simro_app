// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Produit {
    String? code_produit;
    int? affichage_ecran;
    String? filiere;
    String? image;
    String? nom_produit;
    int? famille_produit;
    int? forme_produit;
    int? origine_produit;
    int? categorie_produit;
    String? date_enregistrement;
    String? id_personnel;
    String? etat;
    String? modifier_le;
    String? modifier_par;
    int? id_produit;

    Produit({
         this.code_produit,
         this.affichage_ecran,
         this.filiere,
         this.image,
         this.nom_produit,
         this.famille_produit,
         this.forme_produit,
         this.origine_produit,
         this.categorie_produit,
         this.date_enregistrement,
         this.id_personnel,
         this.etat,
         this.modifier_le,
         this.modifier_par,
         this.id_produit,
    });



  Produit copyWith({
    String? code_produit,
    int? affichage_ecran,
    String? filiere,
    String? image,
    String? nom_produit,
    int? famille_produit,
    int? forme_produit,
    int? origine_produit,
    int? categorie_produit,
    String? date_enregistrement,
    String? id_personnel,
    String? etat,
    String? modifier_le,
    String? modifier_par,
    int? id_produit,
  }) {
    return Produit(
      code_produit: code_produit ?? this.code_produit,
      affichage_ecran: affichage_ecran ?? this.affichage_ecran,
      filiere: filiere ?? this.filiere,
      image: image ?? this.image,
      nom_produit: nom_produit ?? this.nom_produit,
      famille_produit: famille_produit ?? this.famille_produit,
      forme_produit: forme_produit ?? this.forme_produit,
      origine_produit: origine_produit ?? this.origine_produit,
      categorie_produit: categorie_produit ?? this.categorie_produit,
      date_enregistrement: date_enregistrement ?? this.date_enregistrement,
      id_personnel: id_personnel ?? this.id_personnel,
      etat: etat ?? this.etat,
      modifier_le: modifier_le ?? this.modifier_le,
      modifier_par: modifier_par ?? this.modifier_par,
      id_produit: id_produit ?? this.id_produit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code_produit': code_produit,
      'affichage_ecran': affichage_ecran,
      'filiere': filiere,
      'image': image,
      'nom_produit': nom_produit,
      'famille_produit': famille_produit,
      'forme_produit': forme_produit,
      'origine_produit': origine_produit,
      'categorie_produit': categorie_produit,
      'date_enregistrement': date_enregistrement,
      'id_personnel': id_personnel,
      'etat': etat,
      'modifier_le': modifier_le,
      'modifier_par': modifier_par,
      'id_produit': id_produit,
    };
  }

  factory Produit.fromMap(Map<String, dynamic> map) {
    return Produit(
      code_produit: map['code_produit'] != null ? map['code_produit'] as String : null,
      affichage_ecran: map['affichage_ecran'] != null ? map['affichage_ecran'] as int : null,
      filiere: map['filiere'] != null ? map['filiere'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      nom_produit: map['nom_produit'] != null ? map['nom_produit'] as String : null,
      famille_produit: map['famille_produit'] != null ? map['famille_produit'] as int : null,
      forme_produit: map['forme_produit'] != null ? map['forme_produit'] as int : null,
      origine_produit: map['origine_produit'] != null ? map['origine_produit'] as int : null,
      categorie_produit: map['categorie_produit'] != null ? map['categorie_produit'] as int : null,
      date_enregistrement: map['date_enregistrement'] != null ? map['date_enregistrement'] as String : null,
      id_personnel: map['id_personnel'] != null ? map['id_personnel'] as String : null,
      etat: map['etat'] != null ? map['etat'] as String : null,
      modifier_le: map['modifier_le'] != null ? map['modifier_le'] as String : null,
      modifier_par: map['modifier_par'] != null ? map['modifier_par'] as String : null,
      id_produit: map['id_produit'] != null ? map['id_produit'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Produit.fromJson(String source) => Produit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Produit(code_produit: $code_produit, affichage_ecran: $affichage_ecran, filiere: $filiere, image: $image, nom_produit: $nom_produit, famille_produit: $famille_produit, forme_produit: $forme_produit, origine_produit: $origine_produit, categorie_produit: $categorie_produit, date_enregistrement: $date_enregistrement, id_personnel: $id_personnel, etat: $etat, modifier_le: $modifier_le, modifier_par: $modifier_par, id_produit: $id_produit)';
  }

  @override
  bool operator ==(covariant Produit other) {
    if (identical(this, other)) return true;
  
    return 
      other.code_produit == code_produit &&
      other.affichage_ecran == affichage_ecran &&
      other.filiere == filiere &&
      other.image == image &&
      other.nom_produit == nom_produit &&
      other.famille_produit == famille_produit &&
      other.forme_produit == forme_produit &&
      other.origine_produit == origine_produit &&
      other.categorie_produit == categorie_produit &&
      other.date_enregistrement == date_enregistrement &&
      other.id_personnel == id_personnel &&
      other.etat == etat &&
      other.modifier_le == modifier_le &&
      other.modifier_par == modifier_par &&
      other.id_produit == id_produit;
  }

  @override
  int get hashCode {
    return code_produit.hashCode ^
      affichage_ecran.hashCode ^
      filiere.hashCode ^
      image.hashCode ^
      nom_produit.hashCode ^
      famille_produit.hashCode ^
      forme_produit.hashCode ^
      origine_produit.hashCode ^
      categorie_produit.hashCode ^
      date_enregistrement.hashCode ^
      id_personnel.hashCode ^
      etat.hashCode ^
      modifier_le.hashCode ^
      modifier_par.hashCode ^
      id_produit.hashCode;
  }
}
