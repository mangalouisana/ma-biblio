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
      backgroundColor: const Color(0xFFFDFBF7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // --- SECTION HAUTE : En-tête & Illustration des 3 icônes de livres ---
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
                            color: Color(0xFF6D4C41),
                          ),
                        ),
                        const Icon(
                          Icons.menu_book_rounded,
                          color: Color(0xFF6D4C41),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Bienvenue sur Book Shop',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Boîte contenant les 3 icônes de livres de l'image de gauche
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFEBE9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.menu_book,
                            size: 30,
                            color: Color(0xFF6D4C41),
                          ),
                          SizedBox(width: 25),
                          Icon(
                            Icons.library_books,
                            size: 35,
                            color: Color(0xFF4E342E),
                          ),
                          SizedBox(width: 25),
                          Icon(
                            Icons.auto_stories,
                            size: 30,
                            color: Color(0xFF8D6E63),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // --- SECTION BASSE : Grand conteneur Moka/Brun avec Formulaire ---
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF6D4C41),
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
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Serif',
                        ),
                      ),
                      const SizedBox(height: 18),

                      // 1. Nom complet
                      _buildTextField(
                        controller: _nameController,
                        label: 'Nom complet',
                        hint: 'Nom complet',
                        icon: Icons.person_outline,
                        validatorMsg: 'Veuillez entrer votre nom',
                      ),
                      const SizedBox(height: 14),

                      // 2. E-mail
                      _buildTextField(
                        controller: _emailController,
                        label: 'E-mail',
                        hint: 'E-mail',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validatorMsg: 'Veuillez entrer un email valide',
                      ),
                      const SizedBox(height: 14),

                      // 3. Mot de passe
                      _buildTextField(
                        controller: _passwordController,
                        label: 'Mot de passe',
                        hint: 'Mot de passe',
                        icon: Icons.lock_outline,
                        obscureText: _obscurePassword,
                        isPassword: true,
                        onChanged: _verifierMotDePasse,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white70,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        validatorMsg: 'Mot de passe requis',
                      ),
                      const SizedBox(height: 6),

                      // Indicateur dynamique compact sous le mot de passe
                      Row(
                        children: [
                          Icon(
                            (_hasMinLength &&
                                    _hasUppercase &&
                                    _hasLowercase &&
                                    _hasDigit)
                                ? Icons.check
                                : Icons.close,
                            color:
                                (_hasMinLength &&
                                    _hasUppercase &&
                                    _hasLowercase &&
                                    _hasDigit)
                                ? Colors.greenAccent
                                : Colors.white60,
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            '8 caractères  ·  Une lettre et un chiffre',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // 4. Niveau
                      _buildTextField(
                        controller: _niveauController,
                        label: 'Niveau (4-8 car. alphanumériques)',
                        hint: 'Niveau (4-8 car. alphanumériques)',
                        icon: Icons.security,
                        maxLength: 8,
                      ),
                      const SizedBox(height: 6),

                      // 5. Se souvenir de moi
                      Row(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              value: _seSouvenirDeMoi,
                              activeColor: Colors.white,
                              checkColor: const Color(0xFF6D4C41),
                              onChanged: (val) {
                                setState(() {
                                  _seSouvenirDeMoi = val ?? false;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Se souvenir de moi',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Bouton Suivant
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD7CCC8),
                          foregroundColor: const Color(0xFF3E2723),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 2,
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      const SizedBox(height: 16),

                      // Redirection Connexion
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Déjà un compte ? ',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
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
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    bool isPassword = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    String? validatorMsg,
    int? maxLength,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLength: maxLength,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54, fontSize: 13),
        prefixIcon: Icon(icon, color: Colors.white70, size: 18),
        suffixIcon: suffixIcon,
        counterText: '',
        filled: true,
        fillColor: Colors.white.withOpacity(0.12),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 1.2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMsg ?? 'Ce champ est obligatoire';
        }
        return null;
      },
    );
  }
}
