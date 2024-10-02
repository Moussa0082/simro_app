// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class RegionNaturelle {
    String? nom_region_naturelle;
    int? id_region_naturelle;

    RegionNaturelle({
         this.nom_region_naturelle,
         this.id_region_naturelle,
    });


  RegionNaturelle copyWith({
    String? nom_region_naturelle,
    int? id_region_naturelle,
  }) {
    return RegionNaturelle(
      nom_region_naturelle: nom_region_naturelle ?? this.nom_region_naturelle,
      id_region_naturelle: id_region_naturelle ?? this.id_region_naturelle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nom_region_naturelle': nom_region_naturelle,
      'id_region_naturelle': id_region_naturelle,
    };
  }

  factory RegionNaturelle.fromMap(Map<String, dynamic> map) {
    return RegionNaturelle(
      nom_region_naturelle: map['nom_region_naturelle'] != null ? map['nom_region_naturelle'] as String : null,
      id_region_naturelle: map['id_region_naturelle'] != null ? map['id_region_naturelle'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegionNaturelle.fromJson(String source) => RegionNaturelle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RegionNaturelle(nom_region_naturelle: $nom_region_naturelle, id_region_naturelle: $id_region_naturelle)';

  @override
  bool operator ==(covariant RegionNaturelle other) {
    if (identical(this, other)) return true;
  
    return 
      other.nom_region_naturelle == nom_region_naturelle &&
      other.id_region_naturelle == id_region_naturelle;
  }

  @override
  int get hashCode => nom_region_naturelle.hashCode ^ id_region_naturelle.hashCode;
}
