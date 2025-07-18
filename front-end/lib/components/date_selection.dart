import 'package:flutter/material.dart';

class DateSelection extends StatelessWidget {
  const DateSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      clipBehavior: Clip.antiAlias,
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 24,
              children: [
                const SizedBox(width: 24),
                SizedBox(
                  width: 126,
                  child: Text(
                    'Juin 2025',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF101828),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 1.43,
                    ),
                  ),
                ),
                const SizedBox(width: 24),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              spacing: 6,
              runSpacing: 6,
              children: [
                _dateItem('2015', selected: false),
                _dateItem('March', selected: false),
                _dateItem('15', selected: false),
                _dateItem('2016', selected: true),
                _dateItem('April', selected: true),
                _dateItem('16', selected: true),
                _dateItem('2017', selected: false),
                _dateItem('May', selected: false),
                _dateItem('17', selected: false),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: ShapeDecoration(
              color: const Color(0xFF4B935E),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: Color(0xFFE5E7EB),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: [
                BoxShadow(
                  color: const Color(0x051D293D),
                  blurRadius: 0.50,
                  offset: const Offset(0, 1),
                  spreadRadius: 0.05,
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 6,
              children: [
                Text(
                  'Ajouter',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.43,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateItem(String label, {bool selected = false}) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 57),
      child: Container(
        height: 36,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            side: selected
                ? const BorderSide(width: 1, color: Color(0xFF4B935E))
                : BorderSide.none,
            borderRadius: BorderRadius.circular(selected ? 8 : 16),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? const Color(0xFF101828) : const Color(0xFF4A5565),
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            height: 1.33,
          ),
        ),
      ),
    );
  }
}
