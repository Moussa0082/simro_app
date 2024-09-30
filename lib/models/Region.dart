// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Region {
    String? codeRegion;
    String? nomRegion;
    String? abregeRegion;
    int? regionNaturelle;
    String? couleur;
    String? idPersonnel;
    DateTime? dateEnregistrement;
    String? etat;
    String? modifierPar;
    DateTime? modifierLe;
    int? layoutId;
    int? ownerId;
    String? name;
    int? width;
    int? height;
    int? top;
    int? left;
    int? zIndex;
    int? duration;
    int? idRegion;

    Region({
         this.codeRegion,
         this.nomRegion,
         this.abregeRegion,
         this.regionNaturelle,
         this.couleur,
         this.idPersonnel,
         this.dateEnregistrement,
         this.etat,
         this.modifierPar,
         this.modifierLe,
         this.layoutId,
         this.ownerId,
         this.name,
         this.width,
         this.height,
         this.top,
         this.left,
         this.zIndex,
         this.duration,
         this.idRegion,
    });


    Region copyWith({
    String? codeRegion,
    String? nomRegion,
    String? abregeRegion,
    int? regionNaturelle,
    String? couleur,
    String? idPersonnel,
    DateTime? dateEnregistrement,
    String? etat,
    String? modifierPar,
    DateTime? modifierLe,
    int? layoutId,
    int? ownerId,
    String? name,
    int? width,
    int? height,
    int? top,
    int? left,
    int? zIndex,
    int? duration,
    int? idRegion,
  }) {
    return Region(
      codeRegion: codeRegion ?? this.codeRegion,
      nomRegion: nomRegion ?? this.nomRegion,
      abregeRegion: abregeRegion ?? this.abregeRegion,
      regionNaturelle: regionNaturelle ?? this.regionNaturelle,
      couleur: couleur ?? this.couleur,
      idPersonnel: idPersonnel ?? this.idPersonnel,
      dateEnregistrement: dateEnregistrement ?? this.dateEnregistrement,
      etat: etat ?? this.etat,
      modifierPar: modifierPar ?? this.modifierPar,
      modifierLe: modifierLe ?? this.modifierLe,
      layoutId: layoutId ?? this.layoutId,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      width: width ?? this.width,
      height: height ?? this.height,
      top: top ?? this.top,
      left: left ?? this.left,
      zIndex: zIndex ?? this.zIndex,
      duration: duration ?? this.duration,
      idRegion: idRegion ?? this.idRegion,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codeRegion': codeRegion,
      'nomRegion': nomRegion,
      'abregeRegion': abregeRegion,
      'regionNaturelle': regionNaturelle,
      'couleur': couleur,
      'idPersonnel': idPersonnel,
      'dateEnregistrement': dateEnregistrement?.millisecondsSinceEpoch,
      'etat': etat,
      'modifierPar': modifierPar,
      'modifierLe': modifierLe?.millisecondsSinceEpoch,
      'layoutId': layoutId,
      'ownerId': ownerId,
      'name': name,
      'width': width,
      'height': height,
      'top': top,
      'left': left,
      'zIndex': zIndex,
      'duration': duration,
      'idRegion': idRegion,
    };
  }

  factory Region.fromMap(Map<String, dynamic> map) {
    return Region(
      codeRegion: map['codeRegion'] != null ? map['codeRegion'] as String : null,
      nomRegion: map['nomRegion'] != null ? map['nomRegion'] as String : null,
      abregeRegion: map['abregeRegion'] != null ? map['abregeRegion'] as String : null,
      regionNaturelle: map['regionNaturelle'] != null ? map['regionNaturelle'] as int : null,
      couleur: map['couleur'] != null ? map['couleur'] as String : null,
      idPersonnel: map['idPersonnel'] != null ? map['idPersonnel'] as String : null,
      dateEnregistrement: map['dateEnregistrement'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateEnregistrement'] as int) : null,
      etat: map['etat'] != null ? map['etat'] as String : null,
      modifierPar: map['modifierPar'] != null ? map['modifierPar'] as String : null,
      modifierLe: map['modifierLe'] != null ? DateTime.fromMillisecondsSinceEpoch(map['modifierLe'] as int) : null,
      layoutId: map['layoutId'] != null ? map['layoutId'] as int : null,
      ownerId: map['ownerId'] != null ? map['ownerId'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      width: map['width'] != null ? map['width'] as int : null,
      height: map['height'] != null ? map['height'] as int : null,
      top: map['top'] != null ? map['top'] as int : null,
      left: map['left'] != null ? map['left'] as int : null,
      zIndex: map['zIndex'] != null ? map['zIndex'] as int : null,
      duration: map['duration'] != null ? map['duration'] as int : null,
      idRegion: map['idRegion'] != null ? map['idRegion'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Region.fromJson(String source) => Region.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Region(codeRegion: $codeRegion, nomRegion: $nomRegion, abregeRegion: $abregeRegion, regionNaturelle: $regionNaturelle, couleur: $couleur, idPersonnel: $idPersonnel, dateEnregistrement: $dateEnregistrement, etat: $etat, modifierPar: $modifierPar, modifierLe: $modifierLe, layoutId: $layoutId, ownerId: $ownerId, name: $name, width: $width, height: $height, top: $top, left: $left, zIndex: $zIndex, duration: $duration, idRegion: $idRegion)';
  }

  @override
  bool operator ==(covariant Region other) {
    if (identical(this, other)) return true;
  
    return 
      other.codeRegion == codeRegion &&
      other.nomRegion == nomRegion &&
      other.abregeRegion == abregeRegion &&
      other.regionNaturelle == regionNaturelle &&
      other.couleur == couleur &&
      other.idPersonnel == idPersonnel &&
      other.dateEnregistrement == dateEnregistrement &&
      other.etat == etat &&
      other.modifierPar == modifierPar &&
      other.modifierLe == modifierLe &&
      other.layoutId == layoutId &&
      other.ownerId == ownerId &&
      other.name == name &&
      other.width == width &&
      other.height == height &&
      other.top == top &&
      other.left == left &&
      other.zIndex == zIndex &&
      other.duration == duration &&
      other.idRegion == idRegion;
  }

  @override
  int get hashCode {
    return codeRegion.hashCode ^
      nomRegion.hashCode ^
      abregeRegion.hashCode ^
      regionNaturelle.hashCode ^
      couleur.hashCode ^
      idPersonnel.hashCode ^
      dateEnregistrement.hashCode ^
      etat.hashCode ^
      modifierPar.hashCode ^
      modifierLe.hashCode ^
      layoutId.hashCode ^
      ownerId.hashCode ^
      name.hashCode ^
      width.hashCode ^
      height.hashCode ^
      top.hashCode ^
      left.hashCode ^
      zIndex.hashCode ^
      duration.hashCode ^
      idRegion.hashCode;
  }
}
