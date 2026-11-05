import 'package:flutter/material.dart';
import 'signin_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs de formulaire
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _niveauController = TextEditingController();

  // États de l'interface
  bool _seSouvenirDeMoi = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  // Validation dynamique du mot de passe
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasDigit = false;

  // Animation pour l'apparition du contenu
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _niveauController.dispose();
    super.dispose();
  }

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
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 10),
                Text('Inscription validée avec succès ! Bienvenue.'),
              ],
            ),
            backgroundColor: const Color(0xFF6D4C41),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Veuillez respecter toutes les conditions du mot de passe.',
                ),
              ),
            ],
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isPasswordValid =
        _hasMinLength && _hasUppercase && _hasLowercase && _hasDigit;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7), // Coloris Parchemin
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                            'Papyrus Pro',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Serif',
                              color: Color(0xFF6D4C41),
                              letterSpacing: 0.5,
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
                        'Bienvenue sur Papyrus Pro',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Boîte élégante avec effet d'ombre douce
                      Container(
                        height: 85,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFEBE9),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.menu_book,
                              size: 32,
                              color: Color(0xFF6D4C41),
                            ),
                            SizedBox(width: 25),
                            Icon(
                              Icons.library_books,
                              size: 38,
                              color: Color(0xFF4E342E),
                            ),
                            SizedBox(width: 25),
                            Icon(
                              Icons.auto_stories,
                              size: 32,
                              color: Color(0xFF8D6E63),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // --- SECTION BASSE : Formulaire Moka ---
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6D4C41),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: Offset(0, -5),
                      ),
                    ],
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
                        const SizedBox(height: 20),

                        // 1. Nom complet
                        _buildStyledTextField(
                          controller: _nameController,
                          label: 'Nom complet',
                          hint: 'Nom complet',
                          icon: Icons.person_outline,
                          validatorMsg: 'Veuillez entrer votre nom',
                        ),
                        const SizedBox(height: 14),

                        // 2. E-mail
                        _buildStyledTextField(
                          controller: _emailController,
                          label: 'E-mail',
                          hint: 'E-mail',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validatorMsg: 'Veuillez entrer un email valide',
                        ),
                        const SizedBox(height: 14),

                        // 3. Mot de passe
                        _buildStyledTextField(
                          controller: _passwordController,
                          label: 'Mot de passe',
                          hint: 'Mot de passe',
                          icon: Icons.lock_outline,
                          obscureText: _obscurePassword,
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
                        const SizedBox(height: 8),

                        // Indicateur dynamique de sécurité
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isPasswordValid
                                ? Colors.green.withOpacity(0.2)
                                : Colors.black.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isPasswordValid
                                    ? Icons.check_circle
                                    : Icons.info_outline,
                                color: isPasswordValid
                                    ? Colors.greenAccent
                                    : Colors.white60,
                                size: 15,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '6 caractères  ·  Une majuscule, minuscule et chiffre',
                                  style: TextStyle(
                                    color: isPasswordValid
                                        ? Colors.greenAccent
                                        : Colors.white70,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),

                        // 4. Niveau
                        _buildStyledTextField(
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
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
                        const SizedBox(height: 22),

                        // Bouton principal Suivant animé
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD7CCC8),
                              foregroundColor: const Color(0xFF3E2723),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 3,
                            ),
                            onPressed: _isLoading ? null : _validerInscription,
                            child: _isLoading
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF3E2723),
                                      ),
                                    ),
                                  )
                                : const Text(
                                    'Suivant',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Redirection Connexion
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
                                  fontSize: 13,
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
      ),
    );
  }

  // Widget champ de texte stylisé & nettoyé
  Widget _buildStyledTextField({
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
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLength: maxLength,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54, fontSize: 13),
        prefixIcon: Icon(icon, color: Colors.white70, size: 20),
        suffixIcon: suffixIcon,
        counterText: '',
        filled: true,
        fillColor: Colors.white.withOpacity(0.12),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFD7CCC8), width: 1.5),
        ),
        errorStyle: const TextStyle(color: Colors.yellowAccent, fontSize: 11),
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
