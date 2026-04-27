import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Personal Details
  final _emailCtrl   = TextEditingController(text: 'user@velura.com');
  final _passCtrl    = TextEditingController(text: '••••••••••••');

  // Business Address
  final _pinCtrl     = TextEditingController(text: '450116');
  final _addrCtrl    = TextEditingController(text: '216 St Paul\'s Rd,');
  final _cityCtrl    = TextEditingController(text: 'London');
  final _stateCtrl   = TextEditingController(text: 'N1 2LL,');
  final _countryCtrl = TextEditingController(text: 'United Kingdom');

  // Bank Details
  final _bankAccCtrl  = TextEditingController(text: '204356XXXXXXXX');
  final _holderCtrl   = TextEditingController(text: 'Velura User');
  final _ifscCtrl     = TextEditingController(text: 'SBIN00428');

  bool _isSaving = false;

  @override
  void dispose() {
    _emailCtrl.dispose(); _passCtrl.dispose();
    _pinCtrl.dispose(); _addrCtrl.dispose(); _cityCtrl.dispose();
    _stateCtrl.dispose(); _countryCtrl.dispose();
    _bankAccCtrl.dispose(); _holderCtrl.dispose(); _ifscCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isSaving = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(children: [
          Icon(Icons.check_circle, color: AppColors.success),
          SizedBox(width: 8),
          Text('Profile saved successfully!'),
        ]),
        backgroundColor: AppColors.card,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background, elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.danger),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Avatar ────────────────────────────────────────────
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100, height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2),
                      color: AppColors.card,
                    ),
                    child: const Icon(Icons.person, color: AppColors.primary, size: 56),
                  ),
                  Positioned(
                    bottom: 0, right: 0,
                    child: Container(
                      width: 30, height: 30,
                      decoration: const BoxDecoration(
                        color: AppColors.primary, shape: BoxShape.circle),
                      child: const Icon(Icons.edit, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // ── Personal Details ──────────────────────────────────
            _sectionTitle('Personal Details'),
            const SizedBox(height: 14),
            _fieldLabel('Email Address'),
            _inputField(_emailCtrl, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 14),
            _fieldLabel('Password'),
            _inputField(_passCtrl, obscure: true),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Change Password',
                    style: TextStyle(color: AppColors.danger, fontSize: 13)),
              ),
            ),
            const Divider(color: AppColors.border, height: 28),

            // ── Business Address ──────────────────────────────────
            _sectionTitle('Business Address Details'),
            const SizedBox(height: 14),
            _fieldLabel('Pincode'),
            _inputField(_pinCtrl, keyboardType: TextInputType.number),
            const SizedBox(height: 14),
            _fieldLabel('Address'),
            _inputField(_addrCtrl),
            const SizedBox(height: 14),
            _fieldLabel('City'),
            _inputField(_cityCtrl),
            const SizedBox(height: 14),
            _fieldLabel('State'),
            _dropdownField(_stateCtrl),
            const SizedBox(height: 14),
            _fieldLabel('Country'),
            _inputField(_countryCtrl),
            const Divider(color: AppColors.border, height: 28),

            // ── Bank Account ──────────────────────────────────────
            _sectionTitle('Bank Account Details'),
            const SizedBox(height: 14),
            _fieldLabel('Bank Account Number'),
            _inputField(_bankAccCtrl, keyboardType: TextInputType.number),
            const SizedBox(height: 14),
            _fieldLabel('Account Holder\'s Name'),
            _inputField(_holderCtrl),
            const SizedBox(height: 14),
            _fieldLabel('IFSC Code'),
            _inputField(_ifscCtrl),
            const SizedBox(height: 28),

            // ── Save Button ───────────────────────────────────────
            CustomButton(label: 'Save', isLoading: _isSaving, onPressed: _save),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Text(title,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700));

  Widget _fieldLabel(String label) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(label, style: const TextStyle(color: AppColors.hint, fontSize: 12)),
  );

  Widget _inputField(TextEditingController ctrl,
      {bool obscure = false, TextInputType keyboardType = TextInputType.text}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: TextField(
        controller: ctrl,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
        decoration: InputDecoration(
          filled: true, fillColor: AppColors.card,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
        ),
      ),
    );
  }

  Widget _dropdownField(TextEditingController ctrl) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(child: Text(ctrl.text,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 14))),
          const Icon(Icons.keyboard_arrow_down, color: AppColors.hint),
        ],
      ),
    );
  }
}