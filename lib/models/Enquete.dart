// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Enquete {
    String? marche;
    int? collecteur;
    String? statut;
    String? date_enquete;
    String? observation;
    int? id_enquete;

  Enquete({
    this.marche,
    this.collecteur,
    this.statut,
    this.date_enquete,
    this.observation,
    this.id_enquete,
  });


  Enquete copyWith({
    String? marche,
    int? collecteur,
    String? statut,
    String? date_enquete,
    String? observation,
    int? id_enquete,
  }) {
    return Enquete(
      marche: marche ?? this.marche,
      collecteur: collecteur ?? this.collecteur,
      statut: statut ?? this.statut,
      date_enquete: date_enquete ?? this.date_enquete,
      observation: observation ?? this.observation,
      id_enquete: id_enquete ?? this.id_enquete,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'marche': marche,
      'collecteur': collecteur,
      'statut': statut,
      'date_enquete': date_enquete,
      'observation': observation,
      'id_enquete': id_enquete,
    };
  }

  factory Enquete.fromMap(Map<String, dynamic> map) {
    return Enquete(
      marche: map['marche'] != null ? map['marche'] as String : null,
      collecteur: map['collecteur'] != null ? map['collecteur'] as int : null,
      statut: map['statut'] != null ? map['statut'] as String : null,
      date_enquete: map['date_enquete'] != null ? map['date_enquete'] as String : null,
      observation: map['observation'] != null ? map['observation'] as String : null,
      id_enquete: map['id_enquete'] != null ? map['id_enquete'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Enquete.fromJson(String source) => Enquete.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Enquete(marche: $marche, collecteur: $collecteur, statut: $statut, date_enquete: $date_enquete, observation: $observation, id_enquete: $id_enquete)';
  }

  @override
  bool operator ==(covariant Enquete other) {
    if (identical(this, other)) return true;
  
    return 
      other.marche == marche &&
      other.collecteur == collecteur &&
      other.statut == statut &&
      other.date_enquete == date_enquete &&
      other.observation == observation &&
      other.id_enquete == id_enquete;
  }

  @override
  int get hashCode {
    return marche.hashCode ^
      collecteur.hashCode ^
      statut.hashCode ^
      date_enquete.hashCode ^
      observation.hashCode ^
      id_enquete.hashCode;
  }
 }
