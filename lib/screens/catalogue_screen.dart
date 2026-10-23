import 'package:flutter/material.dart';
import '../data/livres_data.dart';
import '../models/livre.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Q2.7 : Filtrer les livres qui sont des nouveautés
    final livresNouveautes = livres.where((l) => l.nouveaute).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Section Nouveautés (ListView horizontal) ---
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Nouveautés',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: livresNouveautes.length,
            itemBuilder: (context, index) {
              final livre = livresNouveautes[index];
              return Container(
                width: 110,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: livre.couleur,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                child: Text(
                  livre.titre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),

        const Divider(height: 30),

        // --- Section Tout le catalogue (ListView.separated vertical) ---
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            'Tout le catalogue',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          // Q2.8 : Expanded obligatoire dans une Column pour un ListView vertical
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: livres.length,
            separatorBuilder: (context, index) =>
                const Divider(indent: 72), // Q2.6 : Divider indenté
            itemBuilder: (context, index) {
              final livre = livres[index];
              return livreTileForCatalog(
                livre,
              ); // Utilisation d'une fonction de tuile
            },
          ),
        ),
      ],
    );
  }

  // Petite fonction locale pour afficher un livre dans le catalogue
  Widget livreTileForCatalog(Livre livre) {
    return ListTile(
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
      title: Text(livre.titre),
      subtitle: Text('${livre.auteur} – ${livre.annee}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            livre.note.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.star, color: Colors.amber, size: 20),
        ],
      ),
    );
  }
}
