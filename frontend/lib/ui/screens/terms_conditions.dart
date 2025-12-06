import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Privacy & Terms',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'DZ'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
      ),
      home: const NavigationPage(),
    );
  }
}

class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('اختر الصفحة'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  'سياسة حماية بيانات المستخدمين',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TermsAndConditionsPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  'الشروط والأحكام',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'سياسة حماية بيانات المستخدمين',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildSectionTitle('أنواع البيانات لي نجمعوها'),
              const SizedBox(height: 12),
              _buildSectionContent(
                'كيما تعرفوا، نجمعوا شوية معلومات (اللباصة، الاسم، رقم الهاتف، نوع المساعدة) باش نضمنوا وصول المساعدة في الوقت المناسب. هذه المعلومات ضرورية باش نخدموا التطبيق.',
              ),
              const SizedBox(height: 30),
              _buildSectionTitle('كيفاش نستعملوا بياناتك الشخصية'),
              const SizedBox(height: 12),
              _buildSectionContent(
                'هذه البيانات نستعملوها غير باش نخدموا نظام الإنقاذ (تحديد بلاصة النداء، إرسال إشعار للمتطوع). مانشاركوش بياناتك مع أي طرف آخر إلا إذا كان الأمر ضروري لإنقاذ حياة (كيما الحماية المدنية 14).',
              ),
              const SizedBox(height: 30),
              _buildSectionTitle('إفصاح البيانات الشخصية'),
              const SizedBox(height: 12),
              _buildSectionContent(
                'مانبيعوش ولا نوزعوا معلوماتك. الإفصاح يصير فقط إذا طلبتوا العدالة ولا كان لازم باش نحموا حياة الضحايا أو المتطوعين. راناا ملتزمين بالحفاظ على سرية معلوماتكم كاملة.',
              ),
              const SizedBox(height: 60),
              Center(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.3),
                            spreadRadius: 10,
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.red[400],
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم النقر على زر الطوارئ')),
                            );
                          },
                          child: const SizedBox(
                            width: 80,
                            height: 80,
                            child: Icon(
                              Icons.front_hand,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'كاين خطر ! محتاج نجدة؟',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[700],
        height: 1.8,
      ),
      textAlign: TextAlign.justify,
    );
  }
}

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'الشروط والأحكام',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildSectionTitle('استخدام التطبيق'),
              const SizedBox(height: 12),
              _buildSectionContent(
                'باستخدامك لهذا التطبيق، أنت توافق على هذه الشروط والأحكام. التطبيق مصمم لتوفير خدمات الطوارئ والإنقاذ السريع. يجب عليك استخدام التطبيق بمسؤولية وعدم إساءة استخدام خدمات الطوارئ.',
              ),
              const SizedBox(height: 30),
              _buildSectionTitle('مسؤوليات المستخدم'),
              const SizedBox(height: 12),
              _buildSectionContent(
                'يلتزم المستخدم بتقديم معلومات صحيحة ودقيقة عند استخدام التطبيق. أي استخدام خاطئ أو متعمد لخدمات الطوارئ قد يؤدي إلى اتخاذ إجراءات قانونية. يجب على المستخدمين احترام المتطوعين وفرق الإنقاذ.',
              ),
              const SizedBox(height: 30),
              _buildSectionTitle('خصوصية البيانات'),
              const SizedBox(height: 12),
              _buildSectionContent(
                'نحن نلتزم بحماية خصوصيتك وبياناتك الشخصية وفقًا لسياسة الخصوصية الخاصة بنا. يتم استخدام بياناتك فقط لأغراض توفير خدمات الطوارئ ولن يتم مشاركتها مع أطراف ثالثة إلا في حالات الضرورة القصوى.',
              ),
              const SizedBox(height: 30),
              _buildSectionTitle('إخلاء المسؤولية'),
              const SizedBox(height: 12),
              _buildSectionContent(
                'التطبيق يهدف إلى تسهيل الوصول لخدمات الطوارئ، لكننا لا نضمن وقت الاستجابة أو النتائج. في حالات الطوارئ الحرجة، يُنصح بالاتصال مباشرة بخدمات الطوارئ الرسمية. نحن غير مسؤولين عن أي تأخير أو مشاكل تقنية قد تحدث.',
              ),
              const SizedBox(height: 30),
              _buildSectionTitle('التعديلات على الشروط'),
              const SizedBox(height: 12),
              _buildSectionContent(
                'نحتفظ بالحق في تعديل هذه الشروط والأحكام في أي وقت. سيتم إعلامك بأي تغييرات جوهرية عبر التطبيق. استمرارك في استخدام التطبيق بعد التعديلات يعني موافقتك على الشروط الجديدة.',
              ),
              const SizedBox(height: 60),
              Center(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.3),
                            spreadRadius: 10,
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.red[400],
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم النقر على زر الطوارئ')),
                            );
                          },
                          child: const SizedBox(
                            width: 80,
                            height: 80,
                            child: Icon(
                              Icons.front_hand,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'كاين خطر ! محتاج نجدة؟',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[700],
        height: 1.8,
      ),
      textAlign: TextAlign.justify,
    );
  }
}