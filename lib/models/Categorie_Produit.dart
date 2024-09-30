// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';



class CategorieProduit {
    String? codeCategorieProduit;
    String? nomCategorieProduit;
    String? familleProduit;
    int? idCategorieProduit;

    CategorieProduit({
         this.codeCategorieProduit,
         this.nomCategorieProduit,
         this.familleProduit,
         this.idCategorieProduit,
    });


  CategorieProduit copyWith({
    String? codeCategorieProduit,
    String? nomCategorieProduit,
    String? familleProduit,
    int? idCategorieProduit,
  }) {
    return CategorieProduit(
      codeCategorieProduit: codeCategorieProduit ?? this.codeCategorieProduit,
      nomCategorieProduit: nomCategorieProduit ?? this.nomCategorieProduit,
      familleProduit: familleProduit ?? this.familleProduit,
      idCategorieProduit: idCategorieProduit ?? this.idCategorieProduit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codeCategorieProduit': codeCategorieProduit,
      'nomCategorieProduit': nomCategorieProduit,
      'familleProduit': familleProduit,
      'idCategorieProduit': idCategorieProduit,
    };
  }

  factory CategorieProduit.fromMap(Map<String, dynamic> map) {
    return CategorieProduit(
      codeCategorieProduit: map['codeCategorieProduit'] != null ? map['codeCategorieProduit'] as String : null,
      nomCategorieProduit: map['nomCategorieProduit'] != null ? map['nomCategorieProduit'] as String : null,
      familleProduit: map['familleProduit'] != null ? map['familleProduit'] as String : null,
      idCategorieProduit: map['idCategorieProduit'] != null ? map['idCategorieProduit'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategorieProduit.fromJson(String source) => CategorieProduit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategorieProduit(codeCategorieProduit: $codeCategorieProduit, nomCategorieProduit: $nomCategorieProduit, familleProduit: $familleProduit, idCategorieProduit: $idCategorieProduit)';
  }

  @override
  bool operator ==(covariant CategorieProduit other) {
    if (identical(this, other)) return true;
  
    return 
      other.codeCategorieProduit == codeCategorieProduit &&
      other.nomCategorieProduit == nomCategorieProduit &&
      other.familleProduit == familleProduit &&
      other.idCategorieProduit == idCategorieProduit;
  }

  @override
  int get hashCode {
    return codeCategorieProduit.hashCode ^
      nomCategorieProduit.hashCode ^
      familleProduit.hashCode ^
      idCategorieProduit.hashCode;
  }
}
