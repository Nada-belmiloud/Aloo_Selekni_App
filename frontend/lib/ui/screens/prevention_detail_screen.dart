import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navbar.dart';


class PreventionDetailScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final String imagePath;

  const PreventionDetailScreen({
    Key? key,
    required this.title,
    required this.icon,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preventionMethods = _getPreventionMethods(title);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: const Color(0xFF4A8BB3),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF4A8BB3),
                              const Color(0xFF4A8BB3).withOpacity(0.7),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Prevention Methods Section
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Section Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'طرق الوقاية',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4A8BB3),
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF4A8BB3).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.shield_outlined,
                                  color: Color(0xFF4A8BB3),
                                  size: 32,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),
                          // Prevention Items
                          ...preventionMethods.asMap().entries.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                textDirection: TextDirection.rtl,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.only(top: 6, left: 12),
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4A8BB3),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${entry.key + 1}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      entry.value,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        height: 1.7,
                                        color: Colors.black87,
                                      ),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Info Note
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A8BB3).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF4A8BB3).withOpacity(0.3),
                      ),
                    ),
                    child: const Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Color(0xFF4A8BB3),
                          size: 24,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'الوقاية خير من العلاج. اتبع هذه الإرشادات لتجنب الحوادث.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF2C5F7A),
                              height: 1.5,
                            ),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
     bottomNavigationBar: const CustomBottomNavBar(
        // optional: handle emergency button
        // onEmergencyTap: () { ... },
      ),
    );
  }

  List<String> _getPreventionMethods(String accidentType) {
    switch (accidentType) {
      case 'حريق':
        return [
          'تركيب أجهزة إنذار الحريق في المنزل والعمل والتأكد من عملها بشكل دوري',
          'عدم ترك الشموع أو المدافئ أو أي مصدر حراري مشتعل دون مراقبة مستمرة',
          'فحص الأسلاك والتوصيلات الكهربائية بشكل دوري واستبدال التالف منها فوراً',
          'الاحتفاظ بطفاية حريق صالحة للاستخدام في مكان يسهل الوصول إليه',
          'عدم التدخين في السرير وإبعاد مواد الاشتعال عن مصادر الحرارة',
          'تعليم جميع أفراد الأسرة كيفية استخدام طفاية الحريق',
          'تجنب تحميل المقابس الكهربائية بشكل زائد',
        ];
      case 'حادث مروري':
        return [
          'الالتزام الصارم بحدود السرعة المقررة وقواعد المرور',
          'استخدام حزام الأمان دائماً لجميع ركاب السيارة',
          'عدم استخدام الهاتف المحمول أثناء القيادة نهائياً',
          'الحفاظ على مسافة آمنة لا تقل عن 3 ثوانٍ من السيارة الأمامية',
          'فحص وصيانة السيارة بشكل دوري (الفرامل، الإطارات، الأنوار)',
          'عدم القيادة في حالة التعب أو النعاس الشديد',
          'تجنب القيادة العدوانية واحترام السائقين الآخرين',
        ];
      case 'زلزال':
        return [
          'تثبيت الأثاث الثقيل والأجهزة الكبيرة على الجدران بشكل آمن',
          'تخزين المواد الكيميائية والأغراض القابلة للكسر في أماكن منخفضة ومؤمنة',
          'معرفة أماكن إيقاف مصادر الغاز والكهرباء والماء في المنزل',
          'تجهيز حقيبة طوارئ تحتوي على الإسعافات الأولية والماء والطعام',
          'وضع خطة إخلاء عائلية وتحديد نقاط التجمع الآمنة',
          'تعزيز البناء وفحص المبنى من قبل مهندس متخصص',
          'المشاركة في تدريبات الزلازل والاستعداد الدائم',
        ];
      case 'فيضان':
        return [
          'معرفة مناطق الفيضانات المحتملة في منطقتك ومستوى الخطر',
          'تركيب صمامات فحص لمنع ارتداد مياه الصرف الصحي',
          'رفع الأجهزة الكهربائية والمعدات الثمينة عن مستوى الأرض',
          'إنشاء نظام تصريف جيد حول المنزل لتوجيه المياه بعيداً',
          'الاشتراك في التأمين ضد أضرار الفيضانات',
          'الاحتفاظ بمعلومات الطوارئ والوثائق المهمة في مكان آمن',
          'متابعة نشرات الطقس والتحذيرات من الجهات المختصة',
        ];
      case 'انهيار مبنى':
        return [
          'فحص المباني القديمة بانتظام من قبل مهندسين مختصين',
          'عدم إجراء أي تعديلات إنشائية دون ترخيص من الجهات المختصة',
          'مراقبة ظهور أي تشققات أو تصدعات في الجدران والأسقف',
          'الالتزام التام بمعايير البناء والأكواد الإنشائية',
          'عدم التحميل الزائد على الأسقف والهياكل الإنشائية',
          'إجراء الصيانة الدورية للمباني وإصلاح أي ضرر فوراً',
          'التحقق من سلامة التربة قبل البناء',
        ];
      case 'حادث كهربائي':
        return [
          'عدم لمس الأجهزة الكهربائية أو المفاتيح بأيدي مبللة أو رطبة',
          'فحص الأسلاك والتوصيلات الكهربائية بانتظام واستبدال التالف',
          'استخدام قواطع التيار الكهربائي (Circuit Breakers) في المنزل',
          'عدم التحميل الزائد على المقابس الكهربائية',
          'إبعاد الأسلاك والأجهزة الكهربائية عن مصادر المياه',
          'استخدام أجهزة حماية من الصعق الكهربائي (GFCI)',
          'الاستعانة بكهربائي مؤهل لأي أعمال كهربائية',
        ];
      case 'إصابات':
        return [
          'ارتداء معدات الحماية الشخصية المناسبة عند العمل أو الرياضة',
          'استخدام السلالم بحذر والتأكد من ثباتها قبل الصعود',
          'إبعاد الأدوات الحادة والخطرة عن متناول الأطفال',
          'ممارسة الرياضة بشكل صحيح مع الإحماء والتمدد',
          'تجنب الأرضيات الزلقة والحفاظ على نظافة الممرات',
          'استخدام الأحذية المناسبة لكل نشاط',
          'الحفاظ على إضاءة جيدة في جميع أنحاء المنزل',
        ];
      case 'غرق':
        return [
          'تعلم السباحة وتعليم الأطفال في سن مبكرة',
          'عدم السباحة بمفردك أبداً والسباحة مع شخص آخر دائماً',
          'ارتداء سترة النجاة عند ركوب القوارب أو الزوارق',
          'احترام علامات التحذير والأعلام في الشواطئ',
          'مراقبة الأطفال باستمرار بالقرب من المياه',
          'تجنب السباحة في المياه العميقة أو التيارات القوية',
          'عدم السباحة بعد تناول الطعام مباشرة',
        ];
      case 'تسمم':
        return [
          'حفظ جميع المواد الكيميائية والأدوية في عبواتها الأصلية المغلقة',
          'إبعاد الأدوية والمنظفات عن متناول الأطفال في خزائن مقفلة',
          'قراءة الملصقات والتعليمات بعناية قبل استخدام أي مادة',
          'عدم خلط مواد التنظيف المختلفة مع بعضها',
          'التحقق من تاريخ صلاحية الأطعمة والأدوية',
          'تخزين المواد السامة في أماكن منفصلة عن الطعام',
          'وضع ملصقات تحذيرية واضحة على المواد الخطرة',
        ];
      case 'اختناق':
        return [
          'مضغ الطعام جيداً وببطء وعدم الاستعجال في تناول الطعام',
          'عدم التحدث أو الضحك أثناء مضغ وبلع الطعام',
          'إبعاد الأشياء الصغيرة والألعاب ذات القطع الصغيرة عن الأطفال',
          'تقطيع طعام الأطفال إلى قطع صغيرة ومناسبة',
          'تجنب إعطاء الأطفال دون 4 سنوات طعاماً صلباً أو دائرياً',
          'تناول الطعام جالساً وليس مستلقياً أو أثناء المشي',
          'مراقبة الأطفال الصغار أثناء تناول الطعام',
        ];
      default:
        return ['معلومات الوقاية غير متوفرة حالياً'];
    }
  }
}
