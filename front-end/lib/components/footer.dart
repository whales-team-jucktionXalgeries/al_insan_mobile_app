import 'package:al_insan_app_front/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../pages/chats_full.dart';
import '../pages/help.dart';
import '../pages/profile_page.dart';

class CustomFooter extends StatefulWidget {
  final int selectedIndex;
  const CustomFooter({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  _CustomFooterState createState() => _CustomFooterState();
}

class _CustomFooterState extends State<CustomFooter> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex;
  }

  final List<String> _titles = ['Accueil', 'Aider', 'Messagerie', 'Profile'];

  final List<String> _iconsUnselected = [
    'assets/icons/home-green.svg',
    'assets/icons/handshake.svg',
    'assets/icons/message-green.svg',
    'assets/icons/user-green.svg',
  ];

  final List<String> _iconsSelected = [
    'assets/icons/home_full.svg',
    'assets/icons/handshake_full.svg',
    'assets/icons/message-full.svg',
    'assets/icons/user_full.svg',
  ];

  void _onItemTapped(int index) {
    if (index == _currentIndex) return;
    if (index == 1) {
      // Aider tab
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HelpPage()),
      );
    }
    if (index == 2) {
      // Messagerie tab
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ChatsFull()),
      );
    }
    if (index == 3) {
      // Profile tab
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFFEFB),
          border: const Border(
            top: BorderSide(width: 1, color: Color(0xFFE5E7EB)),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.primary,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
          elevation: 0,
          iconSize: 32,
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          items: List.generate(_titles.length, (index) {
            return BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _currentIndex == index
                    ? _iconsSelected[index]
                    : _iconsUnselected[index],
              ),
              label: _titles[index],
            );
          }),
        ),
      ),
    );
  }
}
