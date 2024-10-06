// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class PrixInfo {
    String? famille_produit;
    String? code_produit;
    String? produit;
    String? image;
    String? unite;
    double? prix_moy;
    double? prix_min;
    double? prix_max;
    int? nb_marche;
    String? dernier_date;

    PrixInfo({
         this.famille_produit,
         this.code_produit,
         this.produit,
         this.image,
         this.unite,
         this.prix_moy,
         this.prix_min,
         this.prix_max,
         this.nb_marche,
         this.dernier_date,
    });



  PrixInfo copyWith({
    String? famille_produit,
    String? code_produit,
    String? produit,
    String? image,
    String? unite,
    double? prix_moy,
    double? prix_min,
    double? prix_max,
    int? nb_marche,
    String? dernier_date,
  }) {
    return PrixInfo(
      famille_produit: famille_produit ?? this.famille_produit,
      code_produit: code_produit ?? this.code_produit,
      produit: produit ?? this.produit,
      image: image ?? this.image,
      unite: unite ?? this.unite,
      prix_moy: prix_moy ?? this.prix_moy,
      prix_min: prix_min ?? this.prix_min,
      prix_max: prix_max ?? this.prix_max,
      nb_marche: nb_marche ?? this.nb_marche,
      dernier_date: dernier_date ?? this.dernier_date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'famille_produit': famille_produit,
      'code_produit': code_produit,
      'produit': produit,
      'image': image,
      'unite': unite,
      'prix_moy': prix_moy,
      'prix_min': prix_min,
      'prix_max': prix_max,
      'nb_marche': nb_marche,
      'dernier_date': dernier_date,
    };
  }

  factory PrixInfo.fromMap(Map<String, dynamic> map) {
    return PrixInfo(
      famille_produit: map['famille_produit'] != null ? map['famille_produit'] as String : null,
      code_produit: map['code_produit'] != null ? map['code_produit'] as String : null,
      produit: map['produit'] != null ? map['produit'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      unite: map['unite'] != null ? map['unite'] as String : null,
      prix_moy: map['prix_moy'] != null ? map['prix_moy'] as double : null,
      prix_min: map['prix_min'] != null ? map['prix_min'] as double : null,
      prix_max: map['prix_max'] != null ? map['prix_max'] as double : null,
      nb_marche: map['nb_marche'] != null ? map['nb_marche'] as int : null,
      dernier_date: map['dernier_date'] != null ? map['dernier_date'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PrixInfo.fromJson(String source) => PrixInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PrixInfo(famille_produit: $famille_produit, code_produit: $code_produit, produit: $produit, image: $image, unite: $unite, prix_moy: $prix_moy, prix_min: $prix_min, prix_max: $prix_max, nb_marche: $nb_marche, dernier_date: $dernier_date)';
  }

  @override
  bool operator ==(covariant PrixInfo other) {
    if (identical(this, other)) return true;
  
    return 
      other.famille_produit == famille_produit &&
      other.code_produit == code_produit &&
      other.produit == produit &&
      other.image == image &&
      other.unite == unite &&
      other.prix_moy == prix_moy &&
      other.prix_min == prix_min &&
      other.prix_max == prix_max &&
      other.nb_marche == nb_marche &&
      other.dernier_date == dernier_date;
  }

  @override
  int get hashCode {
    return famille_produit.hashCode ^
      code_produit.hashCode ^
      produit.hashCode ^
      image.hashCode ^
      unite.hashCode ^
      prix_moy.hashCode ^
      prix_min.hashCode ^
      prix_max.hashCode ^
      nb_marche.hashCode ^
      dernier_date.hashCode;
  }
 }
