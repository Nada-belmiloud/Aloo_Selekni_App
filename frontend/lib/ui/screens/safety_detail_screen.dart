import 'package:flutter/material.dart';
import '../../ui/widgets/custom_bottom_navbar.dart';


class SafetyDetailScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final String imagePath;

  const SafetyDetailScreen({
    Key? key,
    required this.title,
    required this.icon,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final safetyInstructions = _getSafetyInstructions(title);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: const Color(0xFFE57373),
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
                              const Color(0xFFE57373),
                              const Color(0xFFE57373).withOpacity(0.7),
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'ماذا تفعل أثناء الحادث',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE57373),
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFFE57373).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.health_and_safety_outlined,
                                  color: Color(0xFFE57373),
                                  size: 32,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),
                          ...safetyInstructions.asMap().entries.map((entry) {
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
                                      color: const Color(0xFFE57373),
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE57373).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE57373).withOpacity(0.3),
                      ),
                    ),
                    child: const Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Color(0xFFE57373),
                          size: 24,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'حافظ على هدوئك واتبع هذه التعليمات بدقة لضمان سلامتك.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFFB71C1C),
                              height: 1.5,
                            ),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
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

  List<String> _getSafetyInstructions(String accidentType) {
    switch (accidentType) {
      case 'حريق':
        return [
          'اخرج من المبنى فوراً واتبع مسار الإخلاء المحدد',
          'لا تحاول إطفاء حريق كبير بنفسك - اتصل بالإطفاء',
          'إذا كان هناك دخان، ازحف على الأرض حيث الهواء أنظف',
          'أغلق الأبواب خلفك لإبطاء انتشار النار',
          'لا تستخدم المصعد أبداً - استخدم السلالم فقط',
          'تحسس الأبواب قبل فتحها - إذا كانت ساخنة لا تفتحها',
          'اتجه إلى نقطة التجمع المحددة ولا تعد إلى المبنى',
        ];
      case 'حادث مروري':
        return [
          'أوقف السيارة في مكان آمن بعيداً عن حركة المرور',
          'شغّل أضواء التحذير وضع المثلث العاكس خلف السيارة',
          'لا تحرك المصابين إلا في حالة خطر شديد',
          'اتصل بالإسعاف والشرطة فوراً',
          'ابق هادئاً ولا تتشاجر مع الطرف الآخر',
          'وثق الحادث بالصور وتبادل المعلومات مع الطرف الآخر',
          'انتظر وصول الجهات المختصة ولا تغادر موقع الحادث',
        ];
      case 'زلزال':
        return [
          'انبطح على الأرض، احتمِ تحت طاولة قوية، وتمسك بها',
          'ابتعد عن النوافذ والمرايا والأشياء التي قد تسقط',
          'إذا كنت بالخارج، ابتعد عن المباني والأشجار وخطوط الكهرباء',
          'لا تستخدم المصاعد وابق حيث أنت حتى يتوقف الاهتزاز',
          'إذا كنت في السيارة، أوقفها في مكان آمن وابق بداخلها',
          'احمِ رأسك ورقبتك بيديك أو وسادة',
          'كن مستعداً للهزات الارتدادية',
        ];
      case 'فيضان':
        return [
          'اصعد فوراً إلى أعلى نقطة في المبنى',
          'لا تمشِ أو تقود في المياه المتدفقة - 15 سم قد تسقطك',
          'ابتعد عن الأسلاك الكهربائية المكشوفة',
          'أوقف مصادر الكهرباء والغاز إذا أمكن',
          'لا تشرب من مياه الفيضان - قد تكون ملوثة',
          'استمع لتعليمات السلطات واتبع أوامر الإخلاء',
          'خذ معك حقيبة الطوارئ والوثائق المهمة',
        ];
      case 'انهيار مبنى':
        return [
          'أخلِ المبنى فوراً إذا شعرت بأي اهتزاز أو سمعت أصواتاً غريبة',
          'لا تستخدم المصاعد - استخدم السلالم فقط',
          'احمِ رأسك ورقبتك بيديك أو حقيبة',
          'ابتعد عن المبنى إلى مسافة آمنة',
          'لا تحاول الدخول لإنقاذ أحد - اترك ذلك للمختصين',
          'اتصل بخدمات الطوارئ فوراً',
          'حذر الآخرين من الاقتراب من المبنى',
        ];
      case 'حادث كهربائي':
        return [
          'لا تلمس الشخص المصاب مباشرة - قد تُصعق أنت أيضاً',
          'افصل مصدر الكهرباء من القاطع الرئيسي',
          'استخدم عصا خشبية جافة لإبعاد السلك عن المصاب',
          'قف على سطح جاف وعازل (مطاط، خشب)',
          'لا تستخدم الماء لإطفاء حريق كهربائي',
          'اتصل بالإسعاف فوراً',
          'ابدأ الإنعاش القلبي الرئوي إذا توقف التنفس',
        ];
      case 'إصابات':
        return [
          'قيّم الموقف وتأكد من سلامة المكان قبل الاقتراب',
          'اتصل بالإسعاف للإصابات الخطيرة',
          'لا تحرك المصاب إذا اشتبهت بإصابة العمود الفقري',
          'اضغط مباشرة على الجروح النازفة بقماش نظيف',
          'حافظ على المصاب دافئاً ومرتاحاً',
          'ثبّت الكسور قبل أي تحريك',
          'راقب العلامات الحيوية حتى وصول المساعدة',
        ];
      case 'غرق':
        return [
          'اتصل بالإسعاف فوراً',
          'أخرج الشخص من الماء بأمان - مدّ له عصا أو حبل',
          'لا تقفز في الماء للإنقاذ إلا إذا كنت مدرباً',
          'افحص التنفس والنبض فور إخراجه',
          'ابدأ الإنعاش القلبي الرئوي إذا لم يتنفس',
          'ضع الشخص على جانبه إذا كان يتنفس ولكنه فاقد للوعي',
          'حافظ على دفء المصاب بأغطية',
        ];
      case 'تسمم':
        return [
          'اتصل بمركز السموم أو الإسعاف فوراً',
          'حدد نوع المادة السامة وكميتها إن أمكن',
          'لا تجبر المصاب على التقيؤ دون استشارة طبية',
          'أبعد المصاب عن مصدر التسمم',
          'إذا كان التسمم بالاستنشاق، انقل المصاب للهواء الطلق',
          'احتفظ بعينة من المادة المشتبه بها',
          'راقب التنفس والوعي حتى وصول المساعدة',
        ];
      case 'اختناق':
        return [
          'اسأل الشخص: "هل أنت مختنق؟" إذا أومأ برأسه، ساعده فوراً',
          'قف خلف الشخص وضع قبضتك فوق السرة',
          'اضغط بقوة وبسرعة نحو الداخل والأعلى (مناورة هيمليك)',
          'كرر الضغط 5 مرات أو حتى يخرج الجسم الغريب',
          'للرضع: اقلبه على وجهه واضرب ظهره 5 مرات',
          'إذا فقد الوعي، ابدأ الإنعاش القلبي الرئوي',
          'اتصل بالإسعاف فوراً',
        ];
      default:
        return ['معلومات السلامة غير متوفرة حالياً'];
    }
  }
}
