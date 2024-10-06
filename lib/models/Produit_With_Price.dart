// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:simro/models/Produit.dart';
import 'package:simro/models/Produit_Info.dart';

class ProduitAvecPrix {
 Produit  produit;
 PrixInfo prixInfo;

  ProduitAvecPrix({
   required this.produit,
   required this.prixInfo,
  });
  



  ProduitAvecPrix copyWith({
    Produit? produit,
    PrixInfo? prixInfo,
  }) {
    return ProduitAvecPrix(
      produit: produit ?? this.produit,
      prixInfo: prixInfo ?? this.prixInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'produit': produit.toMap(),
      'prixInfo': prixInfo.toMap(),
    };
  }

  factory ProduitAvecPrix.fromMap(Map<String, dynamic> map) {
    return ProduitAvecPrix(
      produit: Produit.fromMap(map['produit'] as Map<String,dynamic>),
      prixInfo: PrixInfo.fromMap(map['prixInfo'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProduitAvecPrix.fromJson(String source) => ProduitAvecPrix.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProduitAvecPrix(produit: $produit, prixInfo: $prixInfo)';

  @override
  bool operator ==(covariant ProduitAvecPrix other) {
    if (identical(this, other)) return true;
  
    return 
      other.produit == produit &&
      other.prixInfo == prixInfo;
  }

  @override
  int get hashCode => produit.hashCode ^ prixInfo.hashCode;
}
