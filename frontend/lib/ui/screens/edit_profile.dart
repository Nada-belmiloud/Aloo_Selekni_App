import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../../l10n/app_localizations.dart';
import '../../data/models/volunteer.dart';

class ProfileEditPage extends StatefulWidget {
  final Volunteer volunteer; // ✅ Required

  const ProfileEditPage({Key? key, required this.volunteer}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedWilayaCode;
  String? _selectedGenderCode;

  final List<String> _wilayaCodes = [
    'adrar',
    'chlef',
    'laghouat',
    'oum_el_bouaghi',
    'batna',
    'bejaia',
    'biskra',
    'béchar',
    'blida',
    'bouira',
    'tamanrasset',
    'tbessa',
    'tlemcen',
    'tilioust',
    'tizi_ouzou',
    'algiers',
    'djelfa',
    'jijel',
    'setif',
    'saida',
    'skikda',
    'sidi_bel_abbes',
    'annaba',
    'guelma',
    'constantine',
    'médéa',
    'mostaganem',
    'mila',
    'msila',
    'maskara',
    'ouargla',
    'oran',
    'el_bayadh',
    'illizi',
    'borg_bouarreridj',
    'boumerdes',
    'el_tarf',
    'tindouf',
    'tissemsilt',
    'el_oued',
    'khenchela',
    'soukh_ahras',
    'tipaza',
    'mila2',
    'ain_defla',
    'naama',
    'ain_temouchent',
    'ghardaia',
    'relizane',
    'timimoun',
    'bordj_baji_mokhtar',
    'ouled_jellal',
    'bni_abbes',
    'ain_saleh',
    'ain_guezzam',
    'touggourt',
    'djanet',
    'el_meghier',
    'el_meniaa'
  ];

  final List<String> _genderCodes = ['male', 'female'];

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final t = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            t.updatedSuccessfully,
            textAlign: TextAlign.right,
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Map<String, String> _wilayaLabels(AppLocalizations t) => {
        // ... same as your list above ...
      };

  Map<String, String> _genderLabels(AppLocalizations t) => {
        'male': t.gender_male,
        'female': t.gender_female,
      };

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final wilayaLabels = _wilayaLabels(t);
    final genderLabels = _genderLabels(t);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    t.editInfo,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildTextField(
                      controller: _nameController,
                      hintText: t.fullName,
                      keyboardType: TextInputType.name),
                  const SizedBox(height: 16),
                  _buildTextField(
                      controller: _emailController,
                      hintText: t.email,
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: _buildAlgeriaFlag(),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            textAlign: TextAlign.right,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: t.phone,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdown(
                          value: _selectedWilayaCode,
                          hint: t.wilaya,
                          itemsCodes: _wilayaCodes,
                          itemLabel: (code) => wilayaLabels[code] ?? code,
                          onChanged: (value) =>
                              setState(() => _selectedWilayaCode = value),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDropdown(
                          value: _selectedGenderCode,
                          hint: t.gender,
                          itemsCodes: _genderCodes,
                          itemLabel: (code) => genderLabels[code] ?? code,
                          onChanged: (value) =>
                              setState(() => _selectedGenderCode = value),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                      controller: _addressController,
                      hintText: t.address,
                      keyboardType: TextInputType.streetAddress),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[500],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: Text(
                        t.update,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentVolunteer: widget.volunteer, // ✅ Pass volunteer here
          onEmergencyTap: () async {
            final Uri phoneUri = Uri.parse('tel:14');
            if (await canLaunchUrl(phoneUri)) {
              await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(t.cannotOpenPhoneApp),
                      backgroundColor: Colors.red),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String hintText,
      TextInputType? keyboardType}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.right,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildDropdown(
      {required String? value,
      required String hint,
      required List<String> itemsCodes,
      required String Function(String) itemLabel,
      required Function(String?) onChanged}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, textAlign: TextAlign.right),
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          items: itemsCodes
              .map((code) => DropdownMenuItem<String>(
                    value: code,
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(itemLabel(code), textAlign: TextAlign.right),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildAlgeriaFlag() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(color: Colors.grey[300]!)),
      child: ClipOval(
        child: Row(
          children: [
            Expanded(child: Container(color: Colors.green[700])),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(color: Colors.white),
                  Icon(Icons.star, color: Colors.red[700], size: 20),
                ],
              ),
            ),
            Expanded(child: Container(color: Colors.red[700])),
          ],
        ),
      ),
    );
  }
}
