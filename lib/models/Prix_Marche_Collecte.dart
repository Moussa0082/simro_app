// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class PrixMarcheCollecte {
    int? enquete;
    String? produit;
    int? unite;
    int? poidsUnitaire;
    int? montantAchat;
    int? prixFgKg;
    String? localiteOrigine;
    int? distanceOrigineMarche;
    int? montantTransport;
    String? etatRoute;
    int? quantiteCollecte;
    int? clientPrincipal;
    int? fournisseurPrincipal;
    int? niveauApprovisionement;
    int? appMobile;
    String? observation;
    int? statut;
    String? idPersonnel;
    DateTime? dateEnregistrement;
    DateTime? modifierLe;
    String? modifierPar;
    int? idFiche;

    PrixMarcheCollecte({
         this.enquete,
         this.produit,
         this.unite,
         this.poidsUnitaire,
         this.montantAchat,
         this.prixFgKg,
         this.localiteOrigine,
         this.distanceOrigineMarche,
         this.montantTransport,
         this.etatRoute,
         this.quantiteCollecte,
         this.clientPrincipal,
         this.fournisseurPrincipal,
         this.niveauApprovisionement,
         this.appMobile,
         this.observation,
         this.statut,
         this.idPersonnel,
         this.dateEnregistrement,
         this.modifierLe,
         this.modifierPar,
         this.idFiche,
    });

    

  PrixMarcheCollecte copyWith({
    int? enquete,
    String? produit,
    int? unite,
    int? poidsUnitaire,
    int? montantAchat,
    int? prixFgKg,
    String? localiteOrigine,
    int? distanceOrigineMarche,
    int? montantTransport,
    String? etatRoute,
    int? quantiteCollecte,
    int? clientPrincipal,
    int? fournisseurPrincipal,
    int? niveauApprovisionement,
    int? appMobile,
    String? observation,
    int? statut,
    String? idPersonnel,
    DateTime? dateEnregistrement,
    DateTime? modifierLe,
    String? modifierPar,
    int? idFiche,
  }) {
    return PrixMarcheCollecte(
      enquete: enquete ?? this.enquete,
      produit: produit ?? this.produit,
      unite: unite ?? this.unite,
      poidsUnitaire: poidsUnitaire ?? this.poidsUnitaire,
      montantAchat: montantAchat ?? this.montantAchat,
      prixFgKg: prixFgKg ?? this.prixFgKg,
      localiteOrigine: localiteOrigine ?? this.localiteOrigine,
      distanceOrigineMarche: distanceOrigineMarche ?? this.distanceOrigineMarche,
      montantTransport: montantTransport ?? this.montantTransport,
      etatRoute: etatRoute ?? this.etatRoute,
      quantiteCollecte: quantiteCollecte ?? this.quantiteCollecte,
      clientPrincipal: clientPrincipal ?? this.clientPrincipal,
      fournisseurPrincipal: fournisseurPrincipal ?? this.fournisseurPrincipal,
      niveauApprovisionement: niveauApprovisionement ?? this.niveauApprovisionement,
      appMobile: appMobile ?? this.appMobile,
      observation: observation ?? this.observation,
      statut: statut ?? this.statut,
      idPersonnel: idPersonnel ?? this.idPersonnel,
      dateEnregistrement: dateEnregistrement ?? this.dateEnregistrement,
      modifierLe: modifierLe ?? this.modifierLe,
      modifierPar: modifierPar ?? this.modifierPar,
      idFiche: idFiche ?? this.idFiche,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'enquete': enquete,
      'produit': produit,
      'unite': unite,
      'poidsUnitaire': poidsUnitaire,
      'montantAchat': montantAchat,
      'prixFgKg': prixFgKg,
      'localiteOrigine': localiteOrigine,
      'distanceOrigineMarche': distanceOrigineMarche,
      'montantTransport': montantTransport,
      'etatRoute': etatRoute,
      'quantiteCollecte': quantiteCollecte,
      'clientPrincipal': clientPrincipal,
      'fournisseurPrincipal': fournisseurPrincipal,
      'niveauApprovisionement': niveauApprovisionement,
      'appMobile': appMobile,
      'observation': observation,
      'statut': statut,
      'idPersonnel': idPersonnel,
      'dateEnregistrement': dateEnregistrement?.millisecondsSinceEpoch,
      'modifierLe': modifierLe?.millisecondsSinceEpoch,
      'modifierPar': modifierPar,
      'idFiche': idFiche,
    };
  }

  factory PrixMarcheCollecte.fromMap(Map<String, dynamic> map) {
    return PrixMarcheCollecte(
      enquete: map['enquete'] != null ? map['enquete'] as int : null,
      produit: map['produit'] != null ? map['produit'] as String : null,
      unite: map['unite'] != null ? map['unite'] as int : null,
      poidsUnitaire: map['poidsUnitaire'] != null ? map['poidsUnitaire'] as int : null,
      montantAchat: map['montantAchat'] != null ? map['montantAchat'] as int : null,
      prixFgKg: map['prixFgKg'] != null ? map['prixFgKg'] as int : null,
      localiteOrigine: map['localiteOrigine'] != null ? map['localiteOrigine'] as String : null,
      distanceOrigineMarche: map['distanceOrigineMarche'] != null ? map['distanceOrigineMarche'] as int : null,
      montantTransport: map['montantTransport'] != null ? map['montantTransport'] as int : null,
      etatRoute: map['etatRoute'] != null ? map['etatRoute'] as String : null,
      quantiteCollecte: map['quantiteCollecte'] != null ? map['quantiteCollecte'] as int : null,
      clientPrincipal: map['clientPrincipal'] != null ? map['clientPrincipal'] as int : null,
      fournisseurPrincipal: map['fournisseurPrincipal'] != null ? map['fournisseurPrincipal'] as int : null,
      niveauApprovisionement: map['niveauApprovisionement'] != null ? map['niveauApprovisionement'] as int : null,
      appMobile: map['appMobile'] != null ? map['appMobile'] as int : null,
      observation: map['observation'] != null ? map['observation'] as String : null,
      statut: map['statut'] != null ? map['statut'] as int : null,
      idPersonnel: map['idPersonnel'] != null ? map['idPersonnel'] as String : null,
      dateEnregistrement: map['dateEnregistrement'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateEnregistrement'] as int) : null,
      modifierLe: map['modifierLe'] != null ? DateTime.fromMillisecondsSinceEpoch(map['modifierLe'] as int) : null,
      modifierPar: map['modifierPar'] != null ? map['modifierPar'] as String : null,
      idFiche: map['idFiche'] != null ? map['idFiche'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PrixMarcheCollecte.fromJson(String source) => PrixMarcheCollecte.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PrixMarcheCollecte(enquete: $enquete, produit: $produit, unite: $unite, poidsUnitaire: $poidsUnitaire, montantAchat: $montantAchat, prixFgKg: $prixFgKg, localiteOrigine: $localiteOrigine, distanceOrigineMarche: $distanceOrigineMarche, montantTransport: $montantTransport, etatRoute: $etatRoute, quantiteCollecte: $quantiteCollecte, clientPrincipal: $clientPrincipal, fournisseurPrincipal: $fournisseurPrincipal, niveauApprovisionement: $niveauApprovisionement, appMobile: $appMobile, observation: $observation, statut: $statut, idPersonnel: $idPersonnel, dateEnregistrement: $dateEnregistrement, modifierLe: $modifierLe, modifierPar: $modifierPar, idFiche: $idFiche)';
  }

  @override
  bool operator ==(covariant PrixMarcheCollecte other) {
    if (identical(this, other)) return true;
  
    return 
      other.enquete == enquete &&
      other.produit == produit &&
      other.unite == unite &&
      other.poidsUnitaire == poidsUnitaire &&
      other.montantAchat == montantAchat &&
      other.prixFgKg == prixFgKg &&
      other.localiteOrigine == localiteOrigine &&
      other.distanceOrigineMarche == distanceOrigineMarche &&
      other.montantTransport == montantTransport &&
      other.etatRoute == etatRoute &&
      other.quantiteCollecte == quantiteCollecte &&
      other.clientPrincipal == clientPrincipal &&
      other.fournisseurPrincipal == fournisseurPrincipal &&
      other.niveauApprovisionement == niveauApprovisionement &&
      other.appMobile == appMobile &&
      other.observation == observation &&
      other.statut == statut &&
      other.idPersonnel == idPersonnel &&
      other.dateEnregistrement == dateEnregistrement &&
      other.modifierLe == modifierLe &&
      other.modifierPar == modifierPar &&
      other.idFiche == idFiche;
  }

  @override
  int get hashCode {
    return enquete.hashCode ^
      produit.hashCode ^
      unite.hashCode ^
      poidsUnitaire.hashCode ^
      montantAchat.hashCode ^
      prixFgKg.hashCode ^
      localiteOrigine.hashCode ^
      distanceOrigineMarche.hashCode ^
      montantTransport.hashCode ^
      etatRoute.hashCode ^
      quantiteCollecte.hashCode ^
      clientPrincipal.hashCode ^
      fournisseurPrincipal.hashCode ^
      niveauApprovisionement.hashCode ^
      appMobile.hashCode ^
      observation.hashCode ^
      statut.hashCode ^
      idPersonnel.hashCode ^
      dateEnregistrement.hashCode ^
      modifierLe.hashCode ^
      modifierPar.hashCode ^
      idFiche.hashCode;
  }
}
