import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../components/footer.dart';
import 'pay_method.dart'; // Added import for PayMethodPage

class PayPartielPage extends StatefulWidget {
  const PayPartielPage({Key? key}) : super(key: key);

  @override
  State<PayPartielPage> createState() => _PayPartielPageState();
}

class _PayPartielPageState extends State<PayPartielPage> {
  String selectedAmount = '4000 DA';
  bool isDropdownOpen = false;
  final TextEditingController _amountController = TextEditingController();
  
  final List<String> predefinedAmounts = [
    '1000 DA',
    '2000 DA',
    '3000 DA',
    '4000 DA',
    '5000 DA',
    '6000 DA',
    '7000 DA',
    '8000 DA',
    '9000 DA',
    '10000 DA',
  ];

  @override
  void initState() {
    super.initState();
    _amountController.text = selectedAmount;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
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
              SizedBox(
                width: 290,
                child: Text(
                  'Choisissez le montant de votre contribution',
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
              const SizedBox(height: 30),
              // Amount selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: 374,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'm',
                                      style: TextStyle(
                                        color: const Color(0xFF1F2420),
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'ontant',
                                      style: TextStyle(
                                        color: const Color(0xFF1F2420),
                                        fontSize: 15,
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
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                              color: Color(0x051D293D),
                              blurRadius: 0.50,
                              offset: Offset(0, 1),
                              spreadRadius: 0.05,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _amountController,
                                    enabled: true,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedAmount = value;
                                      });
                                    },
                                    style: TextStyle(
                                      color: selectedAmount.isNotEmpty && selectedAmount != '0000,00 DA' 
                                          ? Colors.black 
                                          : const Color(0xFF919592),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 1.43,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '0000,00 DA',
                                      hintStyle: TextStyle(
                                        color: const Color(0xFF919592),
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 1.43,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isDropdownOpen = !isDropdownOpen;
                                    });
                                  },
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    child: Icon(
                                      isDropdownOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                      color: Color(0xFF6B7280),
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Dropdown list
                            if (isDropdownOpen)
                              Container(
                                constraints: BoxConstraints(maxHeight: 200),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: predefinedAmounts.length,
                                  itemBuilder: (context, index) {
                                    final amount = predefinedAmounts[index];
                                    final isSelected = amount == selectedAmount;
                                    
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedAmount = amount;
                                          _amountController.text = amount;
                                          isDropdownOpen = false;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        decoration: BoxDecoration(
                                          color: isSelected ? Color(0xFFF3F4F6) : Colors.transparent,
                                        ),
                                        child: Text(
                                          amount,
                                          style: TextStyle(
                                            color: Color(0xFF374151),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                            height: 1.43,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Continue button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () {
                    // Navigate to pay_method page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PayMethodPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
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
                          'Continuer',
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
                ),
              ),
              // No content in the center
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
        bottomNavigationBar: CustomFooter(selectedIndex: 1),
      ),
    );
  }
}
