class Utilisateur {
  final String id;              // Identifiant unique (ex: UID Firebase ou BDD Node.js)[cite: 7]
  final String nomComplet;      // Nom et prénom du client pour la personnalisation
  final String email;           // Adresse email de connexion
  final String? telephone;      // Numéro de téléphone (optionnel, pour la livraison)
  final int niveau;             // Niveau/Rôle requis pour votre validation (4-8 car. alpha cryptés)
  final int pointsFidelite;     // Système de points de fidélité pour le côté pro[cite: 7]
  final List<String> adresses;  // Liste des adresses de livraison enregistrées[cite: 6, 7]
  final bool estActif;          // Statut du compte (actif/bloqué)

  Utilisateur({
    required this.id,
    required this.nomComplet,
    required this.email,
    this.telephone,
    required this.niveau,
    this.pointsFidelite = 0,
    this.adresses = const [],
    this.estActif = true,
  });

  // Convertir un objet JSON (Map) provenant de l'API Node.js en instance d'Utilisateur
  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      id: json['uid'] ?? '',
      nomComplet: json['nom'] ?? '',
      email: json['email'] ?? '',
      telephone: json['telephone'],
      niveau: json['niveau'] ?? 1,
      pointsFidelite: json['pointsFidelite'] ?? 0,
      adresses: List<String>.from(json['adresses'] ?? []),
      estActif: json['estActif'] ?? true,
    );
  }

  // Convertir l'instance d'Utilisateur en Map pour l'envoyer à l'API Node.js
  Map<String, dynamic> toJson() {
    return {
      'uid': id,
      'nom': nomComplet,
      'email': email,
      'telephone': telephone,
      'niveau': niveau,
      'pointsFidelite': pointsFidelite,
      'adresses': adresses,
      'estActif': estActif,
    };
  }
}