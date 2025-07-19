import 'package:al_insan_app_front/theme/colors.dart';
import 'package:flutter/material.dart';
import '../../components/footer.dart';

class ChevrePage extends StatelessWidget {
  const ChevrePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top section with white background (Mouton container)
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
                    // Title
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
              const SizedBox(height: 19),
              // Mouton details container
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFE5E7EB),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x0C000000),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                        spreadRadius: -2,
                      ),
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 6,
                        offset: Offset(0, 4),
                        spreadRadius: -1,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 169,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/chevre.jpg"),
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 19),
                      Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            'Don de Chèvre',
                                            style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize: 22,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              height: 1.87,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            'Ce mouton sera sacrifié selon le rite halal, et sa viande distribuée à des familles nécessiteuses.',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 1.50,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Container(
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Origine : ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15.95,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.87,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'Algérie (région : Tiaret, Djelfa, etc.)',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.33,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 2.66),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Âge estimé :',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.87,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' 1 an',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.25,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 2.66),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Poids moyen : ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15.95,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.87,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '45 kg',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.33,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 2.66),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Distribution : ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15.95,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.87,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'Orphelins, familles précaires, centres sociaux',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.33,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 2.66),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Durée de livraison :',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15.95,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.87,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13.30,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.50,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '2 à 4 jours après paiement',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.33,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                '40,000 DA',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: const Color(0xFF4B935E),
                                  fontSize: 23,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  height: 1.87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 33),
              // Participation text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Vous souhaitez participer à ce don ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Participation button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF4B935E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Je prends en charge la totalité',
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
              const SizedBox(height: 20),
              // Second participation button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFFEFB),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.50,
                        color: const Color(0xFF4B935E),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Je contribue partiellement',
                        style: TextStyle(
                          color: const Color(0xFF4B935E),
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomFooter(selectedIndex: 1),
    );
  }
}
