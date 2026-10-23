import 'package:flutter/material.dart';
import '../models/livre.dart';

class LivreCard extends StatelessWidget {
  final Livre livre;
  final VoidCallback onTap; // Callback pour gérer le clic sur la carte

  const LivreCard({super.key, required this.livre, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Q4.2 : Élévation de la carte
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Q4.2 : Coins arrondis
      ),
      clipBehavior: Clip
          .antiAlias, // Q4.5 : Permet à l'effet d'encre (InkWell) de respecter les coins arrondis
      child: InkWell(
        onTap: onTap, // Q4.5 : Rendre la carte cliquable
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: livre.couleur,
              child: Text(
                livre.titre[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              livre.titre,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${livre.auteur} – ${livre.annee}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Q4.8 : Affichage d'une icône de favori si le livre est favori
                if (livre.favori)
                  const Icon(Icons.favorite, color: Colors.red, size: 20),
                const SizedBox(width: 8),
                Text(
                  livre.note.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.star, color: Colors.amber, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
