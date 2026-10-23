import 'package:flutter/material.dart';
import '../data/livres_data.dart';
import '../widgets/livre_card.dart';
import '../widgets/livre_grid_item.dart';
import 'detail_screen.dart';

class GalerieScreen extends StatefulWidget {
  const GalerieScreen({super.key});

  @override
  State<GalerieScreen> createState() => _GalerieScreenState();
}

class _GalerieScreenState extends State<GalerieScreen> {
  bool _isGridView = true; // Q6.6 : État pour basculer entre grille et liste

  @override
  Widget build(BuildContext context) {
    // Q6.4 : Grille responsive basée sur la largeur de l'écran
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    if (screenWidth > 900) {
      crossAxisCount = 4;
    } else if (screenWidth >= 600) {
      crossAxisCount = 3;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie & Catalogue'),
        actions: [
          // Q6.7 : Bouton de tri par note décroissante
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: 'Trier par note',
            onPressed: () {
              setState(() {
                livres.sort((a, b) => b.note.compareTo(a.note));
              });
            },
          ),
          // Q6.6 : Bouton de bascule grille / liste
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            tooltip: 'Changer d\'affichage',
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: _isGridView
          ? GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: livres.length,
              // Q6.1 & Q6.3 : GridView.builder avec délégué
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount, // Q6.4 : Colonnes dynamiques
                childAspectRatio: 0.7,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final livre = livres[index];
                return LivreGridItem(
                  livre: livre,
                  onTap: () async {
                    // Q6.5 : Ouvrir les détails et rafraîchir l'écran au retour
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(livre: livre),
                      ),
                    );
                    setState(() {});
                  },
                );
              },
            )
          : ListView.builder(
              itemCount: livres.length,
              itemBuilder: (context, index) {
                final livre = livres[index];
                return LivreCard(
                  livre: livre,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(livre: livre),
                      ),
                    );
                    setState(() {});
                  },
                );
              },
            ),
    );
  }
}
