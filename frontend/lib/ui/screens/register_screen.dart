import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../l10n/app_localizations.dart';
import '../../logic/cubit/volunteer_registration_cubit.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import '../widgets/page_header.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../../logic/states/volunteer_registration_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _selectedState;
  String? _selectedGender;
  bool _acceptTerms = false;
  File? _certificateFile;
String? _certificateName;
  final ImagePicker _picker = ImagePicker();

  final List<String> _genders = ['ذكر', 'أنثى'];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickDocument() async {
    final loc = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(loc.pickFromGallery),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
  setState(() {
    _certificateFile = File(image.path);
    _certificateName = image.name;
  });

  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${loc.fileUploaded}: ${image.name}'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(loc.takePhoto),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.camera);
                 if (image != null) {
  setState(() {
    _certificateFile = File(image.path);
    _certificateName = image.name;
  });

  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${loc.fileUploaded}: ${image.name}'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleRegister() {
    final cubit = context.read<VolunteerRegistrationCubit>();
    final loc = AppLocalizations.of(context)!;

    if (_formKey.currentState!.validate()) {
      if (!_acceptTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.acceptTermsWarning),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_certificateFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.uploadCertificateWarning),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      cubit.registerVolunteer(
  name: _nameController.text,
  phone: _phoneController.text,
  email: _emailController.text,
  password: _passwordController.text, // ✅ ADD THIS
  address: _addressController.text,
  wilaya: _selectedState!,
  gender: _selectedGender!,
 certificateFile: _certificateFile!,
);

    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final List<String> _states = [
      loc.wilaya_adrar,
      loc.wilaya_chlef,
      loc.wilaya_laghouat,
      loc.wilaya_oum_el_bouaghi,
      loc.wilaya_batna,
      loc.wilaya_bejaia,
      loc.wilaya_biskra,
      loc.wilaya_bechar,
      loc.wilaya_blida,
      loc.wilaya_bouira,
      loc.wilaya_tamanrasset,
      loc.wilaya_tbessa,
      loc.wilaya_tlemcen,
      loc.wilaya_tiaret,
      loc.wilaya_tizi_ouzou,
      loc.wilaya_algiers,
      loc.wilaya_djelfa,
      loc.wilaya_jijel,
      loc.wilaya_setif,
      loc.wilaya_saida,
      loc.wilaya_skikda,
      loc.wilaya_sidi_bel_abbes,
      loc.wilaya_annaba,
      loc.wilaya_guelma,
      loc.wilaya_constantine,
      loc.wilaya_medea,
      loc.wilaya_mostaganem,
      loc.wilaya_mila,
      loc.wilaya_msila,
      loc.wilaya_mascara,
      loc.wilaya_ouargla,
      loc.wilaya_oran,
      loc.wilaya_el_bayadh,
      loc.wilaya_illizi,
      loc.wilaya_bordj_bou_arreridj,
      loc.wilaya_boumerdes,
      loc.wilaya_el_tarf,
      loc.wilaya_tindouf,
      loc.wilaya_tissemsilt,
      loc.wilaya_el_oued,
      loc.wilaya_khenchela,
      loc.wilaya_souk_ahras,
      loc.wilaya_tipaza,
      loc.wilaya_mila2,
      loc.wilaya_ain_defla,
      loc.wilaya_naama,
      loc.wilaya_ain_temouchent,
      loc.wilaya_ghardaia,
      loc.wilaya_relizane,
      loc.wilaya_timimoun,
      loc.wilaya_bordj_baji_mokhtar,
      loc.wilaya_ouled_jellal,
      loc.wilaya_beni_abbes,
      loc.wilaya_ain_saleh,
      loc.wilaya_ain_guezzam,
      loc.wilaya_touggourt,
      loc.wilaya_djanet,
      loc.wilaya_el_meghier,
      loc.wilaya_el_meniaa,
    ];

    return BlocListener<VolunteerRegistrationCubit, VolunteerRegistrationState>(
      listener: (context, state) async {
        final loc = AppLocalizations.of(context)!;

        if (state.status == RegistrationStatus.success &&
            state.registeredVolunteer != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(
              'currentVolunteerId', state.registeredVolunteer!.id);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage ?? loc.registerSuccess),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ProfilePage(volunteer: state.registeredVolunteer!),
            ),
          );
        } else if (state.status == RegistrationStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'حدث خطأ'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const PageHeader(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/volunteer.jpg',
                      height: 150,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.volunteer_activism,
                            size: 80,
                            color: Colors.blue,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    loc.registerTitle,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    loc.registerSubtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  // Name
                  TextFormField(
                    controller: _nameController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: loc.nameHint,
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon:
                          const Icon(Icons.person_outline, color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return loc.nameValidator;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Phone
                  TextFormField(
                    controller: _phoneController,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: loc.phoneHint,
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon:
                          const Icon(Icons.phone_outlined, color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return loc.phoneValidator;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Email
                  TextFormField(
                    controller: _emailController,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: loc.emailHint,
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon:
                          const Icon(Icons.email_outlined, color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return loc.emailValidator;
                      }
                      if (!value.contains('@')) {
                        return loc.emailValidator;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Password
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: loc.passwordHint,
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon:
                          const Icon(Icons.lock_outline, color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return loc.passwordValidator;
                      }
                      if (value.length < 6) {
                        return loc.passwordLengthValidator;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Address
                  TextFormField(
                    controller: _addressController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: loc.addressHint,
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.location_on_outlined,
                          color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return loc.addressValidator;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Gender & State Dropdowns
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedGender,
                          decoration: InputDecoration(
                            hintText: loc.genderHint,
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          items: _genders.map((gender) {
                            return DropdownMenuItem<String>(
                              value: gender,
                              child: Text(
                                gender,
                                textAlign: TextAlign.right,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          validator: (value) =>
                              value == null ? loc.genderValidator : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedState,
                          decoration: InputDecoration(
                            hintText: loc.stateHint,
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          items: _states.map((state) {
                            return DropdownMenuItem<String>(
                              value: state,
                              child: Text(
                                state,
                                textAlign: TextAlign.right,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedState = value;
                            });
                          },
                          validator: (value) =>
                              value == null ? loc.stateValidator : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // File upload
                  InkWell(
                    onTap: _pickDocument,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.upload_file,
                            color: _certificateFile != null
                                ? Colors.green
                                : Colors.grey,
                          ),
                          Expanded(
                            child: Text(
                              _certificateName  ?? loc.uploadCertificateHint,
                              style: TextStyle(
                                color: _certificateFile != null
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Terms checkbox
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _acceptTerms = !_acceptTerms;
                            });
                          },
                          child: Text(
                            loc.termsText,
                            style: const TextStyle(
                              color: Color(0xFFFF6B6B),
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                      Checkbox(
                        value: _acceptTerms,
                        onChanged: (value) {
                          setState(() {
                            _acceptTerms = value ?? false;
                          });
                        },
                        activeColor: const Color(0xFFFF6B6B),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Register button
                  ElevatedButton(
                    onPressed: _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B6B),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.arrow_back, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          loc.registerButton,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        ),
                        child: Text(
                          loc.loginButton,
                          style: const TextStyle(
                            color: Color(0xFFFF6B6B),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        loc.haveAccount,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentVolunteer: null,
          onEmergencyTap: () async {
            final Uri phoneUri = Uri.parse('tel:14');
            if (await canLaunchUrl(phoneUri)) {
              await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text(AppLocalizations.of(context)!.cannotOpenPhoneApp),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
