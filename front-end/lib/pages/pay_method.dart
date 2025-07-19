import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/colors.dart';
import '../components/footer.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:al_insan_app_front/pages/home.dart';

class PayMethodPage extends StatefulWidget {
  final double userAmount;
  const PayMethodPage({Key? key, required this.userAmount}) : super(key: key);

  @override
  State<PayMethodPage> createState() => _PayMethodPageState();
}

class _PayMethodPageState extends State<PayMethodPage> {
  int selectedIndex = -1;
  final List<_PayMethod> payMethods = [
    _PayMethod(
      label: 'Edahabia Card',
      icon: SvgPicture.asset(
        'assets/icons/credit-card.svg',
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(Color(0xFF6B7280), BlendMode.srcIn),
      ),
    ),
    _PayMethod(
      label: 'PayPal',
      icon: SvgPicture.asset(
        'assets/icons/paypal.svg',
        width: 18,
        height: 18,
      ),
    ),
    _PayMethod(
      label: 'BaridiMob',
      icon: Image.asset(
        'assets/icons/ccp.png',
        width: 55,
        height: 55,
      ),
    ),
    _PayMethod(
      label: 'DonaPay',
      icon: SizedBox(width: 24, height: 24),
    ),
  ];

  XFile? _pickedProofImage;
  final ImagePicker _proofPicker = ImagePicker();
  bool _isLoading = false;
  String? _resultStatus; // 'success', 'error', or null
  Map<String, dynamic>? _lastBackendData; // To store backend data for error message

  void _showSuccessPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.15),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'paiement réussie',
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
                        'Merci pour votre contribution !',
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
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    decoration: ShapeDecoration(
                      color: Color(0xFF4B935E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Revenir à l’accueil',
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

  Future<void> _verifyPayment() async {
    if (_pickedProofImage == null) return;
    setState(() {
      _isLoading = true;
      _resultStatus = null;
      _lastBackendData = null; // Clear previous data
    });
    try {
      final uri = Uri.parse('http://192.168.1.173:8000/compare-total');
      print('Sending user_amount:  [32m [1m [4m${widget.userAmount} [0m');
      final request = http.MultipartRequest('POST', uri)
        ..fields['user_amount'] = widget.userAmount.toString()
        ..files.add(await http.MultipartFile.fromPath('receipt', _pickedProofImage!.path));
      final response = await request.send();
      final respStr = await response.stream.bytesToString();
      print('Backend response: $respStr');
      if (response.statusCode == 200) {
        final data = json.decode(respStr);
        print('Backend detected: ${data['detected']} | user: ${data['user']} | detected_int: ${data['detected_int']} | user_int: ${data['user_int']}');
        _lastBackendData = data; // Store backend data
        if (data['match'] == true) {
          _showSuccessPopup();
        } else {
          setState(() {
            _resultStatus = 'error';
          });
        }
      } else {
        setState(() {
          _resultStatus = 'error';
        });
      }
    } catch (e) {
      setState(() {
        _resultStatus = 'error';
      });
      print('API error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top section with white background (Aide container)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3FE4E4E7),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: SizedBox(
                        width: 294,
                        child: Text(
                          'Aider',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF09090B),
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 1.20,
                            letterSpacing: -0.20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Chevron left icon
              Padding(
                padding: const EdgeInsets.only(top: 19, left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Icon(
                      Icons.chevron_left,
                      color: Color(0xFF09090B),
                      size: 31,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 23),
              Center(
                child: SizedBox(
                  width: 290,
                  child: Text(
                    'Sélectionnez votre méthode de paiement préférée.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 1.87,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    for (int i = 0; i < payMethods.length; i++) ...[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = i;
                          });
                        },
                        child: Container(
                          width: 381,
                          // Remove fixed height, use only padding
                          padding: const EdgeInsets.only(left: 4, right: 10, top: 8, bottom: 8),
                          decoration: ShapeDecoration(
                            color: selectedIndex == i ? const Color(0xFFE5FFE2) : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: selectedIndex == i ? 1.2 : 1,
                                color: selectedIndex == i ? const Color(0xFF326942) : const Color(0xFFE5E7EB),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x051D293D),
                                blurRadius: 0.50,
                                offset: Offset(0, 1),
                                spreadRadius: 0.05,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 164,
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 148,
                                      child: Text(
                                        payMethods[i].label,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: i == 2 ? 40 : 42, // BaridiMob bigger
                                height: i == 2 ? 40 : 42,
                                alignment: Alignment.center,
                                child: payMethods[i].icon,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (i != payMethods.length - 1) const SizedBox(height: 9),
                      if (selectedIndex == 2 && i == 2) ...[
                        const SizedBox(height: 10),
                        // Ajouter une preuve section with file upload logic
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Ajouter une preuve',
                                    style: TextStyle(
                                      color: Color(0xFF1F2420),
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color: Color(0xFFE5E7EB),
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        shadows: [
                                          BoxShadow(
                                            color: Color(0x051D293D),
                                            blurRadius: 0.50,
                                            offset: Offset(0, 1),
                                            spreadRadius: 0.05,
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          _pickedProofImage != null
                                              ? Row(
                                                  children: [
                                                    Image.file(
                                                      File(_pickedProofImage!.path),
                                                      width: 40,
                                                      height: 40,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    SizedBox(
                                                      width: 140,
                                                      child: Text(
                                                        _pickedProofImage!.name,
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
                                      // Show bottom sheet to choose camera or gallery (as in sign_up page)
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
                                                    final XFile? image = await _proofPicker.pickImage(
                                                      source: ImageSource.camera,
                                                      imageQuality: 85,
                                                    );
                                                    if (image != null) {
                                                      setState(() {
                                                        _pickedProofImage = image;
                                                      });
                                                    }
                                                  },
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons.photo_library),
                                                  title: const Text('Choisir depuis la galerie'),
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    final XFile? image = await _proofPicker.pickImage(
                                                      source: ImageSource.gallery,
                                                      imageQuality: 85,
                                                    );
                                                    if (image != null) {
                                                      setState(() {
                                                        _pickedProofImage = image;
                                                      });
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      decoration: ShapeDecoration(
                                        color: Color(0xFF4B935E),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        shadows: [
                                          BoxShadow(
                                            color: Color(0x051D293D),
                                            blurRadius: 0.50,
                                            offset: Offset(0, 1),
                                            spreadRadius: 0.05,
                                          )
                                        ],
                                      ),
                                      child: Text(
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
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Merci d’envoyer une capture de votre reçu pour valider votre contribution.',
                                style: TextStyle(
                                  color: Color(0xFF1F2420),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  height: 1.67,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : _resultStatus == 'error'
                        ? Column(
                            children: [
                              Text(
                                'Erreur: le montant ne correspond pas au reçu.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFC70036),
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (_lastBackendData != null) ...[
                                SizedBox(height: 8),
                                Text(
                                  'Montant reçu: ${_lastBackendData!['detected']} | Montant entré: ${_lastBackendData!['user']}',
                                  style: TextStyle(fontSize: 14, color: Colors.black54),
                                ),
                              ],
                              SizedBox(height: 12),
                              GestureDetector(
                                onTap: () => setState(() => _resultStatus = null),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFC70036),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    'Réessayer',
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
                          )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF4B935E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: InkWell(
                          onTap: _verifyPayment,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Payer',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomFooter(selectedIndex: 1),
    );
  }
}

class _PayMethod {
  final String label;
  final Widget icon;
  const _PayMethod({required this.label, required this.icon});
}
