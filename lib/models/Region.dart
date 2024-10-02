// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Region {
    String? code_region;
    String? nom_region;
    String? abrege_region;
    int? region_raturelle;
    String? couleur;
    String? id_personnel;
    String? date_enregistrement;
    String? etat;
    String? modifier_par;
    String? modifier_le;
    int? layoutId;
    int? ownerId;
    String? name;
    int? width;
    int? height;
    int? top;
    int? left;
    int? zIndex;
    int? duration;
    int? id_region;

    Region({
         this.code_region,
         this.nom_region,
         this.abrege_region,
         this.region_raturelle,
         this.couleur,
         this.id_personnel,
         this.date_enregistrement,
         this.etat,
         this.modifier_par,
         this.modifier_le,
         this.layoutId,
         this.ownerId,
         this.name,
         this.width,
         this.height,
         this.top,
         this.left,
         this.zIndex,
         this.duration,
         this.id_region,
    });



  Region copyWith({
    String? code_region,
    String? nom_region,
    String? abrege_region,
    int? region_raturelle,
    String? couleur,
    String? id_personnel,
    String? date_enregistrement,
    String? etat,
    String? modifier_par,
    String? modifier_le,
    int? layoutId,
    int? ownerId,
    String? name,
    int? width,
    int? height,
    int? top,
    int? left,
    int? zIndex,
    int? duration,
    int? id_region,
  }) {
    return Region(
      code_region: code_region ?? this.code_region,
      nom_region: nom_region ?? this.nom_region,
      abrege_region: abrege_region ?? this.abrege_region,
      region_raturelle: region_raturelle ?? this.region_raturelle,
      couleur: couleur ?? this.couleur,
      id_personnel: id_personnel ?? this.id_personnel,
      date_enregistrement: date_enregistrement ?? this.date_enregistrement,
      etat: etat ?? this.etat,
      modifier_par: modifier_par ?? this.modifier_par,
      modifier_le: modifier_le ?? this.modifier_le,
      layoutId: layoutId ?? this.layoutId,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      width: width ?? this.width,
      height: height ?? this.height,
      top: top ?? this.top,
      left: left ?? this.left,
      zIndex: zIndex ?? this.zIndex,
      duration: duration ?? this.duration,
      id_region: id_region ?? this.id_region,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code_region': code_region,
      'nom_region': nom_region,
      'abrege_region': abrege_region,
      'region_raturelle': region_raturelle,
      'couleur': couleur,
      'id_personnel': id_personnel,
      'date_enregistrement': date_enregistrement,
      'etat': etat,
      'modifier_par': modifier_par,
      'modifier_le': modifier_le,
      'layoutId': layoutId,
      'ownerId': ownerId,
      'name': name,
      'width': width,
      'height': height,
      'top': top,
      'left': left,
      'zIndex': zIndex,
      'duration': duration,
      'id_region': id_region,
    };
  }

  factory Region.fromMap(Map<String, dynamic> map) {
    return Region(
      code_region: map['code_region'] != null ? map['code_region'] as String : null,
      nom_region: map['nom_region'] != null ? map['nom_region'] as String : null,
      abrege_region: map['abrege_region'] != null ? map['abrege_region'] as String : null,
      region_raturelle: map['region_raturelle'] != null ? map['region_raturelle'] as int : null,
      couleur: map['couleur'] != null ? map['couleur'] as String : null,
      id_personnel: map['id_personnel'] != null ? map['id_personnel'] as String : null,
      date_enregistrement: map['date_enregistrement'] != null ? map['date_enregistrement'] as String : null,
      etat: map['etat'] != null ? map['etat'] as String : null,
      modifier_par: map['modifier_par'] != null ? map['modifier_par'] as String : null,
      modifier_le: map['modifier_le'] != null ? map['modifier_le'] as String : null,
      layoutId: map['layoutId'] != null ? map['layoutId'] as int : null,
      ownerId: map['ownerId'] != null ? map['ownerId'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      width: map['width'] != null ? map['width'] as int : null,
      height: map['height'] != null ? map['height'] as int : null,
      top: map['top'] != null ? map['top'] as int : null,
      left: map['left'] != null ? map['left'] as int : null,
      zIndex: map['zIndex'] != null ? map['zIndex'] as int : null,
      duration: map['duration'] != null ? map['duration'] as int : null,
      id_region: map['id_region'] != null ? map['id_region'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Region.fromJson(String source) => Region.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Region(code_region: $code_region, nom_region: $nom_region, abrege_region: $abrege_region, region_raturelle: $region_raturelle, couleur: $couleur, id_personnel: $id_personnel, date_enregistrement: $date_enregistrement, etat: $etat, modifier_par: $modifier_par, modifier_le: $modifier_le, layoutId: $layoutId, ownerId: $ownerId, name: $name, width: $width, height: $height, top: $top, left: $left, zIndex: $zIndex, duration: $duration, id_region: $id_region)';
  }

  @override
  bool operator ==(covariant Region other) {
    if (identical(this, other)) return true;
  
    return 
      other.code_region == code_region &&
      other.nom_region == nom_region &&
      other.abrege_region == abrege_region &&
      other.region_raturelle == region_raturelle &&
      other.couleur == couleur &&
      other.id_personnel == id_personnel &&
      other.date_enregistrement == date_enregistrement &&
      other.etat == etat &&
      other.modifier_par == modifier_par &&
      other.modifier_le == modifier_le &&
      other.layoutId == layoutId &&
      other.ownerId == ownerId &&
      other.name == name &&
      other.width == width &&
      other.height == height &&
      other.top == top &&
      other.left == left &&
      other.zIndex == zIndex &&
      other.duration == duration &&
      other.id_region == id_region;
  }

  @override
  int get hashCode {
    return code_region.hashCode ^
      nom_region.hashCode ^
      abrege_region.hashCode ^
      region_raturelle.hashCode ^
      couleur.hashCode ^
      id_personnel.hashCode ^
      date_enregistrement.hashCode ^
      etat.hashCode ^
      modifier_par.hashCode ^
      modifier_le.hashCode ^
      layoutId.hashCode ^
      ownerId.hashCode ^
      name.hashCode ^
      width.hashCode ^
      height.hashCode ^
      top.hashCode ^
      left.hashCode ^
      zIndex.hashCode ^
      duration.hashCode ^
      id_region.hashCode;
  }
}
