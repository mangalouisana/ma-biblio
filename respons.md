# Réponses aux questions du TP MaBiblio

## Tableau comparatif (Partie 06)

| Constructeur | Nombre de colonnes (fixe / adaptatif) | Génération des éléments (tous / à la demande) | Cas d'usage conseillé |
| :--- | :--- | :--- | :--- |
| **`GridView.count`** | **Fixe** (défini par `crossAxisCount`) | **Tous** (générés en une seule fois) | Petites listes statiques de taille connue (ex. menu d'accueil). |
| **`GridView.extent`** | **Adaptatif** (basé sur une largeur max `maxCrossAxisExtent`) | **Tous** (générés en une seule fois) | Grilles simples où les éléments s'adaptent à la largeur de l'écran. |
| **`GridView.builder`** | **Variable** (selon le délégué choisi) | **À la demande** (*lazy loading*) | Grands ensembles de données dynamiques pour des performances optimales. |