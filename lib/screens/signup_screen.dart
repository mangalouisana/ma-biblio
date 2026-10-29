import 'package:flutter/material.dart';
import 'signin_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _niveauController = TextEditingController();

  bool _seSouvenirDeMoi = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  // Variables pour le suivi dynamique du mot de passe
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasDigit = false;

  void _verifierMotDePasse(String password) {
    setState(() {
      _hasMinLength = password.length >= 6;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasLowercase = password.contains(RegExp(r'[a-z]'));
      _hasDigit = password.contains(RegExp(r'[0-9]'));
    });
  }

  void _validerInscription() {
    if (_formKey.currentState!.validate() &&
        _hasMinLength &&
        _hasUppercase &&
        _hasLowercase &&
        _hasDigit) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Inscription validée avec succès ! Bienvenue.'),
            backgroundColor: Color(0xFF6D4C41),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Veuillez respecter toutes les conditions du mot de passe.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7), // Fond parchemin chaleureux
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // --- SECTION HAUTE : En-tête & Illustration ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: Color(0xFF6D4C41),
                            ),
                            SizedBox(width: 4),
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: Color(0xFFA1887F),
                            ),
                            SizedBox(width: 4),
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: Color(0xFFD7CCC8),
                            ),
                          ],
                        ),
                        const Text(
                          'Book Shop',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Serif',
                            color: Color(
                              0xFF6D4C41,
                            ), // Même couleur que le bloc de connexion
                          ),
                        ),
                        const Icon(
                          Icons.menu_book_rounded,
                          color: Color(0xFF6D4C41),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Bienvenue sur Book Shop',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Lot de livres stylisé au milieu
                    Container(
                      height: 110,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFEBE9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.menu_book,
                              size: 40,
                              color: Color(0xFF6D4C41),
                            ),
                            SizedBox(width: 12),
                            Icon(
                              Icons.library_books,
                              size: 48,
                              color: Color(0xFF4E342E),
                            ),
                            SizedBox(width: 12),
                            Icon(
                              Icons.auto_stories,
                              size: 40,
                              color: Color(0xFF8D6E63),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // --- SECTION BASSE : Conteneur Moka/Brun avec Formulaire ---
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF6D4C41), // Marron terre chaleureux
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                padding: const EdgeInsets.all(28.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Inscription',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Serif',
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 1. Champ Nom
                      _buildTextField(
                        controller: _nameController,
                        label: 'Nom complet',
                        hint: 'Votre nom',
                        icon: Icons.person_outline,
                        validatorMsg: 'Veuillez entrer votre nom',
                      ),
                      const SizedBox(height: 16),

                      // 2. Champ Email
                      _buildTextField(
                        controller: _emailController,
                        label: 'E-mail',
                        hint: 'votre.email@domain.com',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validatorMsg: 'Veuillez entrer un email valide',
                      ),
                      const SizedBox(height: 16),

                      // 3. Champ Mot de passe avec vérification en direct
                      _buildTextField(
                        controller: _passwordController,
                        label: 'Mot de passe',
                        hint: '••••••••',
                        icon: Icons.lock_outline,
                        obscureText: _obscurePassword,
                        onChanged: _verifierMotDePasse,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        validatorMsg: 'Mot de passe requis',
                      ),
                      const SizedBox(height: 8),

                      // Indicateur dynamique de sécurité du mot de passe
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCritereLigne(
                              'Minimum 6 caractères',
                              _hasMinLength,
                            ),
                            _buildCritereLigne(
                              'Au moins une majuscule (A-Z)',
                              _hasUppercase,
                            ),
                            _buildCritereLigne(
                              'Au moins une minuscule (a-z)',
                              _hasLowercase,
                            ),
                            _buildCritereLigne(
                              'Au moins un chiffre (0-9)',
                              _hasDigit,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 4. Champ Niveau (4 à 8 caractères alphanumériques)
                      _buildTextField(
                        controller: _niveauController,
                        label: 'Niveau (4-8 car. alphanumériques)',
                        hint: 'Ex: A123',
                        icon: Icons.security,
                        maxLength: 8,
                      ),
                      const SizedBox(height: 8),

                      // 5. Zone "Se souvenir de moi"
                      Row(
                        children: [
                          Checkbox(
                            value: _seSouvenirDeMoi,
                            activeColor: Colors.white,
                            checkColor: const Color(0xFF6D4C41),
                            onChanged: (val) {
                              setState(() {
                                _seSouvenirDeMoi = val ?? false;
                              });
                            },
                          ),
                          const Text(
                            'Se souvenir de moi',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Bouton "Suivant" en français
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD7CCC8),
                          foregroundColor: const Color(0xFF3E2723),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 3,
                        ),
                        onPressed: _isLoading ? null : _validerInscription,
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Suivant',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),

                      // 6. Lien de redirection vers Connexion (Sign in)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Déjà un compte ? ',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SigninScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Se connecter',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCritereLigne(String texte, bool respecte) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(
            respecte ? Icons.check_circle : Icons.cancel,
            color: respecte ? Colors.greenAccent : Colors.white54,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            texte,
            style: TextStyle(
              color: respecte ? Colors.white : Colors.white60,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    String? validatorMsg,
    int? maxLength,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLength: maxLength,
          onChanged: onChanged,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white30),
            prefixIcon: Icon(icon, color: Colors.white70, size: 20),
            suffixIcon: suffixIcon,
            counterText: '',
            filled: true,
            fillColor: Colors.white.withOpacity(0.12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.white, width: 1.5),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validatorMsg ?? 'Ce champ est obligatoire';
            }
            if (maxLength != null &&
                (value.length < 4 || value.length > maxLength)) {
              return 'Doit contenir entre 4 et 8 caractères';
            }
            return null;
          },
        ),
      ],
    );
  }
}
