import 'package:flutter/material.dart';
import '../models/livre.dart';

class DetailScreen extends StatefulWidget {
  final Livre livre;

  const DetailScreen({super.key, required this.livre});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final livre = widget.livre;

    return Scaffold(
      appBar: AppBar(title: Text(livre.titre)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Q4.6 : En-tête coloré de 200 px avec le titre en grand
            Container(
              height: 200,
              width: double.infinity,
              color: livre.couleur,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: Text(
                livre.titre,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Q4.6 : Trois ListTile pour les informations principales
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Auteur'),
              subtitle: Text(livre.auteur),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Année de parution'),
              subtitle: Text(livre.annee.toString()),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Genre'),
              subtitle: Text(livre.genre),
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Note'),
              subtitle: Text('${livre.note} / 5'),
            ),

            const SizedBox(height: 24),

            // Q4.6 & Q4.8 : OverflowBar avec boutons d'action (Favoris et Lu)
            OverflowBar(
              alignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      livre.favori =
                          !livre.favori; // Q4.8 : Bascule l'état favori
                    });
                  },
                  icon: Icon(
                    livre.favori ? Icons.favorite : Icons.favorite_border,
                    color: livre.favori ? Colors.red : null,
                  ),
                  label: Text(
                    livre.favori
                        ? 'Retirer des favoris'
                        : 'Ajouter aux favoris',
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      livre.lu = !livre.lu; // Bascule l'état lu
                    });
                  },
                  icon: Icon(
                    livre.lu ? Icons.check_box : Icons.check_box_outline_blank,
                  ),
                  label: Text(
                    livre.lu ? 'Marquer comme non lu' : 'Marquer comme lu',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
