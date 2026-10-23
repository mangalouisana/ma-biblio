import 'package:flutter/material.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: Column(
        children: [
          // Q1.1 & Q1.2 : Un ListTile simple avec onTap
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Mon profil'),
            subtitle: const Text('Nom, e-mail, mot de passe'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Q1.2 : Affiche un SnackBar au clic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profil sélectionné')),
              );
            },
          ),

          // Q1.3 & Q1.5 : Notifications avec personnalisation (tileColor, iconColor, textColor, shape)
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Gérer les alertes de rappels'),
            trailing: const Icon(Icons.chevron_right),
            tileColor: Colors.indigo.withOpacity(0.05),
            iconColor: Colors.indigo,
            textColor: Colors.indigo[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: () {},
          ),

          // Q1.3 : Langue
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Langue'),
            subtitle: const Text('Français'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          // Q1.3 & Q1.4 : À propos (tests de dense, isThreeLine, enabled)
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('À propos'),
            subtitle: const Text(
              'Version 1.0.0\nApplication MaBiblio pour la bibliothèque de quartier.',
            ),
            trailing: const Icon(Icons.chevron_right),
            dense: true, // Réduit la hauteur du ListTile
            isThreeLine:
                true, // Permet d'avoir un sous-titre sur plusieurs lignes
            enabled: true, // Mettez à false pour voir l'effet grisé/désactivé
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
