import 'package:flutter/material.dart';
import '../data/livres_data.dart';
import '../widgets/livre_card.dart';
import 'detail_screen.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              return GestureDetector(
                onTap: () {
                  // Q4.7 : Ouvrir l'écran de détail au clic sur une nouveauté
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(livre: livre),
                    ),
                  );
                },
                child: Container(
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
                ),
              );
            },
          ),
        ),

        const Divider(height: 30),

        // --- Section Tout le catalogue (ListView standard au lieu de separated car la Card gère les marges) ---
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            'Tout le catalogue',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: livres.length,
            itemBuilder: (context, index) {
              final livre = livres[index];
              // Q4.4 & Q4.7 : Utilisation de LivreCard et navigation vers DetailScreen
              return LivreCard(
                livre: livre,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(livre: livre),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
