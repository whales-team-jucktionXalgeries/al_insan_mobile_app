import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:al_insan_app_front/components/big_buttons.dart';
import 'package:al_insan_app_front/components/date_selection.dart';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  XFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  String? _docType; // 'passeport' or 'carte'

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEFB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
            child: Center(
              child: Container(
                width: 374,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back icon at the very top, does not affect layout
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new,
                            size: 24, color: Color(0xFF101828)),
                        onPressed: () {
                          Navigator.of(context).maybePop();
                        },
                      ),
                    ),
                    SizedBox(
                        height:
                            16), // Space between back icon and Nom field (adjust as needed)
                    // Main form content
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nom (only letters)
                          _inputField(
                            label: 'Nom',
                            controller: _nomController,
                            required: true,
                            hint: 'Nom',
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-ZÀ-ÿ\s]')),
                            ],
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Champ requis';
                              if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(value))
                                return 'Lettres uniquement';
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          // Prenom (only letters)
                          _inputField(
                            label: 'Prenom',
                            controller: _prenomController,
                            required: true,
                            hint: 'Prenom',
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-ZÀ-ÿ\s]')),
                            ],
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Champ requis';
                              if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(value))
                                return 'Lettres uniquement';
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          // Numero de telephone (only numbers)
                          _inputField(
                            label: 'Numero de telephone',
                            controller: _phoneController,
                            required: true,
                            hint: '+0000000',
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.phone,
                            labelRich: true,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Champ requis';
                              if (!RegExp(r'^[0-9]+$').hasMatch(value))
                                return 'Chiffres uniquement';
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          // Date de naissance (popup picker)
                          GestureDetector(
                            onTap: () async {
                              // Show the custom date picker dialog
                              final selectedDate = await showDialog<String>(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) {
                                  return Center(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 6, sigmaY: 6),
                                      child: Dialog(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        insetPadding: const EdgeInsets.all(24),
                                        child: DateSelectionDialog(
                                          onDateSelected: (date) {
                                            Navigator.of(context).pop(date);
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                              if (selectedDate != null) {
                                setState(() {
                                  _dobController.text = selectedDate;
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: _inputField(
                                label: 'Date de naissance',
                                controller: _dobController,
                                required: true,
                                hint: 'dd/mm/yy',
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return 'Champ requis';
                                  // Optionally add date validation here
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          // Mot de passe (any chars, obscured)
                          _inputField(
                            label: 'Mot de passe',
                            controller: _passwordController,
                            required: true,
                            hint: '*********',
                            obscure: true,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Champ requis';
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          // Confirmation de Mot de passe (any chars, obscured)
                          _inputField(
                            label: 'Confirmation de Mot de passe',
                            controller: _confirmPasswordController,
                            required: true,
                            hint: '*********',
                            obscure: true,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Champ requis';
                              if (value != _passwordController.text)
                                return 'Les mots de passe ne correspondent pas';
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          _fileUploadField(),
                          const SizedBox(height: 10),
                          Row(
                            children: const [
                              Flexible(
                                child: Text(
                                  'Veuiller ajouter une photo de carte d identite ou passeport',
                                  style: TextStyle(
                                    color: Color(0xFF1F2420),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 1.67,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 54),
                          // Confirm button
                          PrimaryButton(
                            label: 'Confirmer',
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                // Show success popup
                                _showSuccessPopup();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool required = false,
    bool obscure = false,
    bool labelRich = false,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            labelRich
                ? RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: label.substring(0, 1),
                          style: const TextStyle(
                            color: Color(0xFF1F2420),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: label.substring(1),
                          style: const TextStyle(
                            color: Color(0xFF1F2420),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 1.43,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF1F2420),
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            if (required)
              const Text(
                '*',
                style: TextStyle(
                  color: Color(0xFFC70036),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFE5E7EB),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x051D293D),
                blurRadius: 0.5,
                offset: Offset(0, 1),
                spreadRadius: 0.05,
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 348,
                child: TextFormField(
                  controller: controller,
                  obscureText: obscure,
                  inputFormatters: inputFormatters,
                  keyboardType: keyboardType,
                  validator: validator,
                  style: TextStyle(
                    color: const Color(0xFF1F2420),
                    fontSize: obscure ? 15 : 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: obscure ? 1.33 : 1.43,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: const Color(0xFF919592),
                      fontSize: obscure ? 15 : 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: obscure ? 1.33 : 1.43,
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _fileUploadField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: Color(0xFFE5E7EB),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x051D293D),
                  blurRadius: 0.5,
                  offset: Offset(0, 1),
                  spreadRadius: 0.05,
                ),
              ],
            ),
            child: Row(
              children: [
                _pickedImage != null
                    ? Row(
                        children: [
                          Image.file(
                            File(_pickedImage!.path),
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 140,
                            child: Text(
                              _pickedImage!.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xFF919592),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 1.43,
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(
                        width: 198,
                        child: Text(
                          'Aucun fichier',
                          style: TextStyle(
                            color: Color(0xFF919592),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            // Step 1: Ask for document type
            final docType = await showModalBottomSheet<String>(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) {
                return SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.badge_outlined),
                        title: const Text('Carte d\'identité'),
                        onTap: () => Navigator.pop(context, 'carte'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.book_outlined),
                        title: const Text('Passeport'),
                        onTap: () => Navigator.pop(context, 'passeport'),
                      ),
                    ],
                  ),
                );
              },
            );
            if (docType != null) {
              setState(() {
                _docType = docType;
              });
              // Step 2: Show photo picker
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text('Prendre une photo'),
                          onTap: () async {
                            Navigator.pop(context);
                            final XFile? image = await _picker.pickImage(
                              source: ImageSource.camera,
                              imageQuality: 85,
                            );
                            if (image != null) {
                              setState(() {
                                _pickedImage = image;
                              });
                            }
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text('Choisir depuis la galerie'),
                          onTap: () async {
                            Navigator.pop(context);
                            final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 85,
                            );
                            if (image != null) {
                              setState(() {
                                _pickedImage = image;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: ShapeDecoration(
              color: const Color(0xFF4B935E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x051D293D),
                  blurRadius: 0.5,
                  offset: Offset(0, 1),
                  spreadRadius: 0.05,
                ),
              ],
            ),
            child: const Text(
              'Ajouter fichier',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.43,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showSuccessPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor:
          Colors.black.withOpacity(0.15), // Slightly grey, dim background
      builder: (context) {
        return Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: Color(0xFFE5E7EB),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x0C000000),
                  blurRadius: 6,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 15,
                  offset: Offset(0, 10),
                  spreadRadius: -3,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 310,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'Inscription réussie',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF4B935E),
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 1.87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Bienvenue! Votre compte a bien été créé',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1F2420),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 21),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 12),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF4B935E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Continuer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DateSelectionDialog extends StatelessWidget {
  final void Function(String date) onDateSelected;
  const DateSelectionDialog({Key? key, required this.onDateSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // You can customize this to return the selected date string
    return DateSelection(); // Replace with a stateful version if you want to return a real date
  }
}
