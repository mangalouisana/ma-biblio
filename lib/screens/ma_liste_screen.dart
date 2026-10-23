import 'package:flutter/material.dart';
import '../data/livres_data.dart';
import '../models/livre.dart';

class MaListeScreen extends StatefulWidget {
  const MaListeScreen({super.key});

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  // Q3.2 : Variable pour afficher uniquement les nouveautés
  bool _nouveautesSeulement = false;

  // Q3.3 : Map des genres avec leur état (coché par défaut)
  final Map<String, bool> _genres = {
    'Roman': true,
    'Science': true,
    'Histoire': true,
    'Jeunesse': true,
    'Informatique': true,
  };

  // Q3.4 : Associer une icône à chaque genre
  IconData _getIconForGenre(String genre) {
    switch (genre) {
      case 'Roman':
        return Icons.book;
      case 'Science':
        return Icons.science;
      case 'Histoire':
        return Icons.history;
      case 'Jeunesse':
        return Icons.child_care;
      case 'Informatique':
        return Icons.computer;
      default:
        return Icons.category;
    }
  }

  // Q3.6 : État de la case « Tous » (tristate)
  // true = tous cochés, false = aucun coché, null = partiel
  bool? get _tousGenresEtat {
    if (_genres.values.every((val) => val)) return true;
    if (_genres.values.every((val) => !val)) return false;
    return null; // État indéterminé / tiret
  }

  @override
  Widget build(BuildContext context) {
    // Filtrer les livres selon les genres cochés et éventuellement les nouveautés
    final livresFiltres = livres.where((livre) {
      final matchGenre = _genres[livre.genre] ?? false;
      final matchNouveaute = _nouveautesSeulement ? livre.nouveaute : true;
      return matchGenre && matchNouveaute;
    }).toList();

    // Q3.8 : Calculer les livres lus parmi les livres affichés
    final int nbLus = livresFiltres.where((l) => l.lu).length;
    final int nbTotal = livresFiltres.length;

    return Scaffold(
      appBar: AppBar(title: Text('Ma liste (Lus : $nbLus / $nbTotal)')),
      body: Column(
        children: [
          // Filtre Nouveautés
          CheckboxListTile(
            title: const Text('Afficher uniquement les nouveautés'),
            value: _nouveautesSeulement,
            onChanged: (bool? value) {
              setState(() {
                _nouveautesSeulement = value ?? false;
              });
            },
          ),
          const Divider(height: 1),

          // Q3.6 : Case « Tous les genres » à 3 états (tristate)
          CheckboxListTile(
            title: const Text('Tous les genres'),
            value: _tousGenresEtat,
            tristate: true,
            onChanged: (bool? value) {
              setState(() {
                // Si la case est cliquée, si elle était true ou null, on décoche tout (false).
                // Si elle était false, on coche tout (true).
                final nouveauEtat = (value == true);
                _genres.updateAll((key, _) => nouveauEtat);
              });
            },
          ),
          const Divider(height: 1),

          // Q3.3 & Q3.4 & Q3.5 : CheckboxListTile pour chaque genre
          ExpansionTile(
            title: const Text('Filtrer par genres'),
            children: _genres.keys.map((genre) {
              final int count = livres.where((l) => l.genre == genre).length;
              return CheckboxListTile(
                controlAffinity:
                    ListTileControlAffinity.leading, // Q3.5 : Case à gauche
                secondary: Icon(_getIconForGenre(genre)),
                title: Text(genre),
                subtitle: Text('$count livres'),
                activeColor: Colors.indigo,
                value: _genres[genre],
                onChanged: (bool? value) {
                  setState(() {
                    _genres[genre] = value ?? false;
                  });
                },
              );
            }).toList(),
          ),
          const Divider(height: 4),

          // Q3.7 : Liste des livres filtrés avec CheckboxListTile (livre.lu)
          Expanded(
            child: ListView.separated(
              itemCount: livresFiltres.length,
              separatorBuilder: (context, index) =>
                  const Divider(indent: 16, endIndent: 16),
              itemBuilder: (context, index) {
                final livre = livresFiltres[index];
                return CheckboxListTile(
                  title: Text(
                    livre.titre,
                    style: TextStyle(
                      // Q3.7 : Titre barré si le livre est lu
                      decoration: livre.lu
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: livre.lu ? Colors.grey : Colors.black,
                    ),
                  ),
                  subtitle: Text('${livre.auteur} (${livre.genre})'),
                  secondary: CircleAvatar(
                    backgroundColor: livre.couleur,
                    child: Text(
                      livre.titre[0],
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  value: livre.lu,
                  onChanged: (bool? value) {
                    setState(() {
                      livre.lu = value ?? false;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
