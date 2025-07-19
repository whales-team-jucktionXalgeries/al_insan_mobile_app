import 'package:flutter/material.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  bool _notificationsEnabled = true; // State for notification toggle

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 529,
      padding: const EdgeInsets.only(top: 20, left: 20, right: 10, bottom: 20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFE5E7EB)),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Compte Section
          SizedBox(
            width: 330,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 330,
                  child: Text(
                    'Compte',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Modifier profile
                _settingsRow(
                  context,
                  icon: Icons.person_outline,
                  label: 'Modifier profile',
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
                const SizedBox(height: 20),
                // Notifications
                _settingsRow(
                  context,
                  icon: Icons.notifications_none,
                  label: 'Notifications',
                  trailing: _notificationSwitch(),
                ),
                const SizedBox(height: 20),
                // Securite
                _settingsRow(
                  context,
                  icon: Icons.lock_outline,
                  label: 'Securite',
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
                const SizedBox(height: 20),
                // Confidentialité
                _settingsRow(
                  context,
                  icon: Icons.privacy_tip_outlined,
                  label: 'Confidentialité',
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          // Support Section
          SizedBox(
            width: 330,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 330,
                  child: Text(
                    'Support ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Payement
                _settingsRow(
                  context,
                  icon: Icons.payment,
                  label: 'Payement',
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
                const SizedBox(height: 20),
                // Aide est Support
                _settingsRow(
                  context,
                  icon: Icons.help_outline,
                  label: 'Aide est Support',
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
                const SizedBox(height: 20),
                // Dashboard
                _settingsRow(
                  context,
                  icon: Icons.dashboard_outlined,
                  label: 'Dashboard',
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
                const SizedBox(height: 20),
                // se déconnecter
                _settingsRow(
                  context,
                  icon: Icons.logout,
                  label: 'se déconnecter',
                  isLogout: true, // Special flag for logout styling
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Widget trailing,
    bool isLogout = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: isLogout ? Colors.red : const Color(0xFF4B935E),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                color: isLogout ? Colors.red : const Color(0xFF1F2420),
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ],
        ),
        trailing,
      ],
    );
  }

  Widget _notificationSwitch() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _notificationsEnabled = !_notificationsEnabled;
        });
      },
      child: Container(
        width: 41.68,
        height: 23.16,
        decoration: ShapeDecoration(
          color:
              _notificationsEnabled
                  ? const Color(0xFF4B935E)
                  : const Color(0xFFE5E7EB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11577.79),
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: _notificationsEnabled ? 20.68 : 1.44,
              top: 1.58,
              child: Container(
                width: 19.56,
                height: 19.56,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48.89),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x051D293D),
                      blurRadius: 0.61,
                      offset: Offset(0, 1.22),
                      spreadRadius: 0.06,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
