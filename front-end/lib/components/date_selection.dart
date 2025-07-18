import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateSelection extends StatefulWidget {
  final void Function(String date)? onDateSelected;
  const DateSelection({Key? key, this.onDateSelected}) : super(key: key);

  @override
  State<DateSelection> createState() => _DateSelectionState();
}

class _DateSelectionState extends State<DateSelection> {
  final List<int> years = List.generate(
      100,
      (i) =>
          DateTime.now().year - 80 + i); // 80 years ago to 20 years in future
  final List<String> months = const [
    'Janvier',
    'Février',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Août',
    'Septembre',
    'Octobre',
    'Novembre',
    'Décembre'
  ];
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month - 1;
  int selectedDay = DateTime.now().day;

  List<int> get daysInMonth {
    int year = selectedYear;
    int month = selectedMonth + 1;
    int days = DateTime(year, month + 1, 0).day;
    return List.generate(days, (i) => i + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${months[selectedMonth]} $selectedYear',
            style: const TextStyle(
              color: Color(0xFF101828),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Year picker
                Expanded(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                        initialItem: years.indexOf(selectedYear)),
                    itemExtent: 36,
                    selectionOverlay: Container(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedYear = years[index];
                        if (selectedDay > daysInMonth.length) {
                          selectedDay = daysInMonth.length;
                        }
                      });
                    },
                    children: years
                        .map(
                            (y) => _pickerItem(y.toString(), y == selectedYear))
                        .toList(),
                  ),
                ),
                // Month picker
                Expanded(
                  child: CupertinoPicker(
                    scrollController:
                        FixedExtentScrollController(initialItem: selectedMonth),
                    itemExtent: 36,
                    selectionOverlay: Container(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedMonth = index;
                        if (selectedDay > daysInMonth.length) {
                          selectedDay = daysInMonth.length;
                        }
                      });
                    },
                    children: List.generate(months.length,
                        (i) => _pickerItem(months[i], i == selectedMonth)),
                  ),
                ),
                // Day picker
                Expanded(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                        initialItem: selectedDay - 1),
                    itemExtent: 36,
                    selectionOverlay: Container(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedDay = daysInMonth[index];
                      });
                    },
                    children: daysInMonth
                        .map((d) => _pickerItem(d.toString(), d == selectedDay))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4B935E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: () {
                final dateStr =
                    '${selectedDay.toString().padLeft(2, '0')}/${(selectedMonth + 1).toString().padLeft(2, '0')}/$selectedYear';
                if (widget.onDateSelected != null) {
                  widget.onDateSelected!(dateStr);
                }
                Navigator.of(context).pop(dateStr);
              },
              child: const Text(
                'Ajouter',
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
    );
  }

  Widget _pickerItem(String label, bool selected) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: selected
            ? BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFF4B935E), width: 1.5),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: Text(
          label,
          style: TextStyle(
            color: selected ? const Color(0xFF101828) : const Color(0xFF4A5565),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
