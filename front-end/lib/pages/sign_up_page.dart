import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEFB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 22, left: 0, right: 0, bottom: 0),
            child: Center(
              child: Container(
                width: 374,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 31,
                            height: 31,
                            decoration: const BoxDecoration(),
                            // TODO: Add logo/icon if needed
                          ),
                          const SizedBox(height: 30),
                          _formField(
                            label: 'Nom',
                            hint: 'Nom',
                            required: true,
                          ),
                          const SizedBox(height: 15),
                          _formField(
                            label: 'Prenom',
                            hint: 'Prenom',
                            required: true,
                          ),
                          const SizedBox(height: 15),
                          _formField(
                            label: 'Numero de telephone',
                            hint: '+0000000',
                            required: true,
                            labelRich: true,
                          ),
                          const SizedBox(height: 15),
                          _formField(
                            label: 'Date de naissance',
                            hint: 'dd/mm/yy',
                            required: true,
                          ),
                          const SizedBox(height: 15),
                          _formField(
                            label: 'Mot de passe',
                            hint: '*********',
                            required: true,
                            obscure: true,
                          ),
                          const SizedBox(height: 15),
                          _formField(
                            label: 'Confirmation de Mot de passe',
                            hint: '*********',
                            required: true,
                            obscure: true,
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 54),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF4B935E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Confirmer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
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

  Widget _formField({
    required String label,
    required String hint,
    bool required = false,
    bool obscure = false,
    bool labelRich = false,
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
                child: Text(
                  hint,
                  style: TextStyle(
                    color: const Color(0xFF919592),
                    fontSize: obscure ? 15 : 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: obscure ? 1.33 : 1.43,
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
              children: const [
                SizedBox(
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
        Container(
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
      ],
    );
  }
}
