// lib/ui/screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../logic/cubit/volunteer_registration_cubit.dart';
import '../../logic/states/volunteer_registration_state.dart';
import 'login_screen.dart';
import 'profile_screen.dart';

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
  
  String? _selectedState;
  String? _selectedGender;
  bool _acceptTerms = false;
  String? _uploadedFileName;
  String? _uploadedFilePath;
  final ImagePicker _picker = ImagePicker();

  // All 58 Algerian wilayas in Arabic (matching your geolocation_repository)
  final List<String> _states = [
    'أدرار',
    'الشلف',
    'الأغواط',
    'أم البواقي',
    'باتنة',
    'بجاية',
    'بسكرة',
    'بشار',
    'البليدة',
    'البويرة',
    'تمنراست',
    'تبسة',
    'تلمسان',
    'تيارت',
    'تيزي وزو',
    'الجزائر',
    'الجلفة',
    'جيجل',
    'سطيف',
    'سعيدة',
    'سكيكدة',
    'سيدي بلعباس',
    'عنابة',
    'قالمة',
    'قسنطينة',
    'المدية',
    'مستغانم',
    'المسيلة',
    'معسكر',
    'ورقلة',
    'وهران',
    'البيض',
    'إليزي',
    'برج بوعريريج',
    'بومرداس',
    'الطارف',
    'تندوف',
    'تيسمسيلت',
    'الوادي',
    'خنشلة',
    'سوق أهراس',
    'تيبازة',
    'ميلة',
    'عين الدفلى',
    'النعامة',
    'عين تموشنت',
    'غرداية',
    'غليزان',
  ];

  final List<String> _genders = ['ذكر', 'أنثى'];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickDocument() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('اختيار من المعرض'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    setState(() {
                      _uploadedFileName = image.name;
                      _uploadedFilePath = image.path;
                    });
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تم تحميل الملف: ${image.name}'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('التقاط صورة'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (image != null) {
                    setState(() {
                      _uploadedFileName = image.name;
                      _uploadedFilePath = image.path;
                    });
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تم تحميل الملف: ${image.name}'),
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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يجب الموافقة على الشروط والأحكام'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_uploadedFilePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يجب تحميل شهادة الاعتماد'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Register volunteer using Cubit
    context.read<VolunteerRegistrationCubit>().registerVolunteer(
          name: _nameController.text.trim(),
          phone: _phoneController.text.trim(),
          email: _emailController.text.trim(),
          address: _addressController.text.trim(),
          wilaya: _selectedState!,
          gender: _selectedGender!,
          certificatePath: _uploadedFilePath,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: BlocListener<VolunteerRegistrationCubit, VolunteerRegistrationState>(
        listener: (context, state) {
          if (state.status == RegistrationStatus.success) {
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage ?? 'تم التسجيل بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
            
            // Navigate to ProfilePage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          } else if (state.status == RegistrationStatus.error) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'حدث خطأ'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<VolunteerRegistrationCubit, VolunteerRegistrationState>(
          builder: (context, state) {
            final isLoading = state.status == RegistrationStatus.loading;

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Volunteer illustration
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
                          
                          // Title
                          const Text(
                            'باش تكون متطوع معانا',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'نحتاج معلوماتك الأساسية باش نتواصلو عليك',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          
                          // Name field
                          TextFormField(
                            controller: _nameController,
                            textAlign: TextAlign.right,
                            enabled: !isLoading,
                            decoration: InputDecoration(
                              hintText: 'اللقب والاسم',
                              hintStyle: const TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال اللقب والاسم';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          // Phone field
                          TextFormField(
                            controller: _phoneController,
                            textAlign: TextAlign.right,
                            keyboardType: TextInputType.phone,
                            enabled: !isLoading,
                            decoration: InputDecoration(
                              hintText: 'رقم الهاتف',
                              hintStyle: const TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.phone_outlined, color: Colors.grey),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال رقم الهاتف';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          // Email field
                          TextFormField(
                            controller: _emailController,
                            textAlign: TextAlign.right,
                            keyboardType: TextInputType.emailAddress,
                            enabled: !isLoading,
                            decoration: InputDecoration(
                              hintText: 'البريد الالكتروني',
                              hintStyle: const TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال البريد الإلكتروني';
                              }
                              if (!value.contains('@')) {
                                return 'يرجى إدخال بريد إلكتروني صحيح';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          // Address field
                          TextFormField(
                            controller: _addressController,
                            textAlign: TextAlign.right,
                            enabled: !isLoading,
                            decoration: InputDecoration(
                              hintText: 'العنوان الكامل',
                              hintStyle: const TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.location_on_outlined, color: Colors.grey),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال العنوان الكامل';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          // State and Gender dropdowns
                          Row(
                            children: [
                              // Gender dropdown
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedGender,
                                  decoration: InputDecoration(
                                    hintText: 'الجنس',
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
                                    return DropdownMenuItem(
                                      value: gender,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        gender,
                                        textAlign: TextAlign.right,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: isLoading
                                      ? null
                                      : (value) {
                                          setState(() {
                                            _selectedGender = value;
                                          });
                                        },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'اختر الجنس';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              // State dropdown
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedState,
                                  decoration: InputDecoration(
                                    hintText: 'الولاية',
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
                                    return DropdownMenuItem(
                                      value: state,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        state,
                                        textAlign: TextAlign.right,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: isLoading
                                      ? null
                                      : (value) {
                                          setState(() {
                                            _selectedState = value;
                                          });
                                        },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'اختر الولاية';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          // File upload button
                          InkWell(
                            onTap: isLoading ? null : _pickDocument,
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
                                    color: _uploadedFileName != null ? Colors.green : Colors.grey,
                                  ),
                                  Expanded(
                                    child: Text(
                                      _uploadedFileName ?? 'تحميل شهادة الاعتماد الخاصة بك',
                                      style: TextStyle(
                                        color: _uploadedFileName != null ? Colors.green : Colors.grey,
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
                                  onTap: isLoading
                                      ? null
                                      : () {
                                          setState(() {
                                            _acceptTerms = !_acceptTerms;
                                          });
                                        },
                                  child: const Text(
                                    'راني موافق على الشروط والأحكام',
                                    style: TextStyle(
                                      color: Color(0xFFFF6B6B),
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                              Checkbox(
                                value: _acceptTerms,
                                onChanged: isLoading
                                    ? null
                                    : (value) {
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
                            onPressed: isLoading ? null : _handleRegister,
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
                                if (isLoading)
                                  const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                else
                                  const Icon(Icons.arrow_back, color: Colors.white),
                                const SizedBox(width: 8),
                                Text(
                                  isLoading ? 'جاري التسجيل...' : 'انشاء حساب',
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
                                onPressed: isLoading
                                    ? null
                                    : () => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const LoginScreen(),
                                          ),
                                        ),
                                child: const Text(
                                  'تسجيل الدخول',
                                  style: TextStyle(
                                    color: Color(0xFFFF6B6B),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const Text(
                                'لديك حساب مسبق؟',
                                style: TextStyle(
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
              ],
            );
          },
        ),
      ),
    );
  }
}