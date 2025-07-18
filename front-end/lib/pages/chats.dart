import 'package:al_insan_app_front/theme/colors.dart';
import 'package:flutter/material.dart';
import '../../components/footer.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top section with white background (messagerie container)
            Container(
              width: 414,
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
                        'Messagerie',
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
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: ShapeDecoration(
                      color: Colors.white /* white */,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFFE5E7EB) /* colors-border-border-base-medium */,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: Icon(
                            Icons.search,
                            size: 16,
                            color: const Color(0xFF6A7282),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                color: const Color(0xFF6A7282) /* colors-text-text-body-subtle */,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 1.43,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                            ),
                            style: TextStyle(
                              color: const Color(0xFF09090B),
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
                ],
              ),
            ),
            
            Expanded(
              child: Center(
                child: Container(
                  width: 393,
                  height: 201,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 115.50,
                        top: 0,
                        child: Container(
                          width: 162,
                          height: 121,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 2,
                                top: 0.83,
                                child: Container(
                                  width: 160,
                                  padding: const EdgeInsets.symmetric(horizontal: 10.67, vertical: 5.33),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFFAFAFA) /* Color-Background-Color-Background2 */,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: const Color(0xFFF5F5F5) /* Color-Border-Color-Border-Light */,
                                      ),
                                      borderRadius: BorderRadius.circular(10.67),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 10.67,
                                    children: [
                                      Text(
                                        'SF',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white /* Color-Button-Color-Primary-Button-Icon---SW */,
                                          fontSize: 10.67,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Container(
                                        width: 101.33,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 5.33,
                                          children: [],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 22,
                                top: 42.83,
                                child: Container(
                                  width: 160,
                                  padding: const EdgeInsets.symmetric(horizontal: 10.67, vertical: 5.33),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFFAFAFA) /* Color-Background-Color-Background2 */,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: const Color(0xFFF5F5F5) /* Color-Border-Color-Border-Light */,
                                      ),
                                      borderRadius: BorderRadius.circular(10.67),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 10.67,
                                    children: [
                                      Text(
                                        'VN',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white /* Color-Button-Color-Primary-Button-Icon---SW */,
                                          fontSize: 10.67,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Container(
                                        width: 101.33,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 5.33,
                                          children: [],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: -8,
                                top: 84.83,
                                child: Container(
                                  width: 160,
                                  padding: const EdgeInsets.symmetric(horizontal: 10.67, vertical: 5.33),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFFAFAFA) /* Color-Background-Color-Background2 */,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: const Color(0xFFF5F5F5) /* Color-Border-Color-Border-Light */,
                                      ),
                                      borderRadius: BorderRadius.circular(10.67),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 10.67,
                                    children: [
                                      Text(
                                        'MS',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white /* Color-Button-Color-Primary-Button-Icon---SW */,
                                          fontSize: 10.67,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Container(
                                        width: 101.33,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 5.33,
                                          children: [],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 141,
                        child: Container(
                          width: 393,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 4,
                            children: [
                              SizedBox(
                                width: 280,
                                child: Text(
                                  'Aucune conversation',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF141414) /* Color-Text-Color-Text-Primary */,
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 1.87,
                                  ),
                                ),
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
          ],
        ),
      ),
      bottomNavigationBar: CustomFooter(selectedIndex: 2),
    );
  }
}