// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Produit {
    String? codeProduit;
    int? affichageEcran;
    String? filiere;
    String? image;
    String? nomProduit;
    int? familleProduit;
    int? formeProduit;
    int? origineProduit;
    int? categorieProduit;
    DateTime? dateEnregistrement;
    String? idPersonnel;
    String? etat;
    DateTime? modifierLe;
    String? modifierPar;
    int? idProduit;

    Produit({
         this.codeProduit,
         this.affichageEcran,
         this.filiere,
         this.image,
         this.nomProduit,
         this.familleProduit,
         this.formeProduit,
         this.origineProduit,
         this.categorieProduit,
         this.dateEnregistrement,
         this.idPersonnel,
         this.etat,
         this.modifierLe,
         this.modifierPar,
         this.idProduit,
    });



  Produit copyWith({
    String? codeProduit,
    int? affichageEcran,
    String? filiere,
    String? image,
    String? nomProduit,
    int? familleProduit,
    int? formeProduit,
    int? origineProduit,
    int? categorieProduit,
    DateTime? dateEnregistrement,
    String? idPersonnel,
    String? etat,
    DateTime? modifierLe,
    String? modifierPar,
    int? idProduit,
  }) {
    return Produit(
      codeProduit: codeProduit ?? this.codeProduit,
      affichageEcran: affichageEcran ?? this.affichageEcran,
      filiere: filiere ?? this.filiere,
      image: image ?? this.image,
      nomProduit: nomProduit ?? this.nomProduit,
      familleProduit: familleProduit ?? this.familleProduit,
      formeProduit: formeProduit ?? this.formeProduit,
      origineProduit: origineProduit ?? this.origineProduit,
      categorieProduit: categorieProduit ?? this.categorieProduit,
      dateEnregistrement: dateEnregistrement ?? this.dateEnregistrement,
      idPersonnel: idPersonnel ?? this.idPersonnel,
      etat: etat ?? this.etat,
      modifierLe: modifierLe ?? this.modifierLe,
      modifierPar: modifierPar ?? this.modifierPar,
      idProduit: idProduit ?? this.idProduit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codeProduit': codeProduit,
      'affichageEcran': affichageEcran,
      'filiere': filiere,
      'image': image,
      'nomProduit': nomProduit,
      'familleProduit': familleProduit,
      'formeProduit': formeProduit,
      'origineProduit': origineProduit,
      'categorieProduit': categorieProduit,
      'dateEnregistrement': dateEnregistrement?.millisecondsSinceEpoch,
      'idPersonnel': idPersonnel,
      'etat': etat,
      'modifierLe': modifierLe?.millisecondsSinceEpoch,
      'modifierPar': modifierPar,
      'idProduit': idProduit,
    };
  }

  factory Produit.fromMap(Map<String, dynamic> map) {
    return Produit(
      codeProduit: map['codeProduit'] != null ? map['codeProduit'] as String : null,
      affichageEcran: map['affichageEcran'] != null ? map['affichageEcran'] as int : null,
      filiere: map['filiere'] != null ? map['filiere'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      nomProduit: map['nomProduit'] != null ? map['nomProduit'] as String : null,
      familleProduit: map['familleProduit'] != null ? map['familleProduit'] as int : null,
      formeProduit: map['formeProduit'] != null ? map['formeProduit'] as int : null,
      origineProduit: map['origineProduit'] != null ? map['origineProduit'] as int : null,
      categorieProduit: map['categorieProduit'] != null ? map['categorieProduit'] as int : null,
      dateEnregistrement: map['dateEnregistrement'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateEnregistrement'] as int) : null,
      idPersonnel: map['idPersonnel'] != null ? map['idPersonnel'] as String : null,
      etat: map['etat'] != null ? map['etat'] as String : null,
      modifierLe: map['modifierLe'] != null ? DateTime.fromMillisecondsSinceEpoch(map['modifierLe'] as int) : null,
      modifierPar: map['modifierPar'] != null ? map['modifierPar'] as String : null,
      idProduit: map['idProduit'] != null ? map['idProduit'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Produit.fromJson(String source) => Produit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Produit(codeProduit: $codeProduit, affichageEcran: $affichageEcran, filiere: $filiere, image: $image, nomProduit: $nomProduit, familleProduit: $familleProduit, formeProduit: $formeProduit, origineProduit: $origineProduit, categorieProduit: $categorieProduit, dateEnregistrement: $dateEnregistrement, idPersonnel: $idPersonnel, etat: $etat, modifierLe: $modifierLe, modifierPar: $modifierPar, idProduit: $idProduit)';
  }

  @override
  bool operator ==(covariant Produit other) {
    if (identical(this, other)) return true;
  
    return 
      other.codeProduit == codeProduit &&
      other.affichageEcran == affichageEcran &&
      other.filiere == filiere &&
      other.image == image &&
      other.nomProduit == nomProduit &&
      other.familleProduit == familleProduit &&
      other.formeProduit == formeProduit &&
      other.origineProduit == origineProduit &&
      other.categorieProduit == categorieProduit &&
      other.dateEnregistrement == dateEnregistrement &&
      other.idPersonnel == idPersonnel &&
      other.etat == etat &&
      other.modifierLe == modifierLe &&
      other.modifierPar == modifierPar &&
      other.idProduit == idProduit;
  }

  @override
  int get hashCode {
    return codeProduit.hashCode ^
      affichageEcran.hashCode ^
      filiere.hashCode ^
      image.hashCode ^
      nomProduit.hashCode ^
      familleProduit.hashCode ^
      formeProduit.hashCode ^
      origineProduit.hashCode ^
      categorieProduit.hashCode ^
      dateEnregistrement.hashCode ^
      idPersonnel.hashCode ^
      etat.hashCode ^
      modifierLe.hashCode ^
      modifierPar.hashCode ^
      idProduit.hashCode;
  }
}
