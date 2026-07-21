import 'package:flutter/material.dart';

// 1. نظام حماية المفاتيح المشفرة والأدمن
class AppConfig {
  static const String aiApiKey = String.fromEnvironment('AI_API_KEY', defaultValue: 'PROTECTED_KEY');
  static const String adminPasscode = 'ADMIN2026';
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SherkoSuperApp());
}

class SherkoSuperApp extends StatelessWidget {
  const SherkoSuperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SHERKO SUPER AI',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF090D16),
        primaryColor: const Color(0xFF00E5FF),
        cardColor: const Color(0xFF131B2E),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E5FF),
          secondary: Color(0xFF00FF88),
          surface: Color(0xFF131B2E),
        ),
      ),
      home: const SubscriptionCheckScreen(),
    );
  }
}

// 2. شاشة الاشتراك والتحقق + وضع الأدمن الخفي
class SubscriptionCheckScreen extends StatefulWidget {
  const SubscriptionCheckScreen({super.key});

  @override
  State<SubscriptionCheckScreen> createState() => _SubscriptionCheckScreenState();
}

class _SubscriptionCheckScreenState extends State<SubscriptionCheckScreen> {
  bool isSubscribed = false;
  int _adminClickCount = 0;
  final TextEditingController _adminController = TextEditingController();

  void _checkAdminCode(String code) {
    if (code == AppConfig.adminPasscode) {
      setState(() => isSubscribed = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🔓 تم تفعيل وضع الأدمن المالك (Admin Access) بنجاح!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isSubscribed) {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF090D16), Color(0xFF131B2E)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _adminClickCount++;
                  if (_adminClickCount >= 3) {
                    _showAdminDialog();
                    _adminClickCount = 0;
                  }
                },
                child: const Icon(Icons.stars_rounded, size: 100, color: Color(0xFF00E5FF)),
              ),
              const SizedBox(height: 20),
              const Text('اشترك في SHERKO VIP', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              const Text(
                'احصل على المساعد الذكي، توليد الأسئلة MCQ، محرر المحاضرات الفائق، والروبوت العائم لمدة 6 أشهر',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 30),
              Card(
                color: const Color(0xFF1E2A3E),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text('خطة 6 أشهر المتكاملة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text('\$10.00 / 6 أشهر', style: TextStyle(fontSize: 26, color: Color(0xFF00FF88), fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text('تجديد تلقائي - إلغاء في أي وقت', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E5FF),
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () => setState(() => isSubscribed = true),
                child: const Text('اشترك الآن 🚀', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      );
    }
    return const LanguageAndDialectScreen();
  }

  void _showAdminDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF131B2E),
        title: const Text('دخول المالك / Admin Access'),
        content: TextField(
          controller: _adminController,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'أدخل كود الأدمن السري',
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E5FF))),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _checkAdminCode(_adminController.text);
              Navigator.pop(context);
            },
            child: const Text('تفعيل', style: TextStyle(color: Color(0xFF00FF88))),
          ),
        ],
      ),
    );
  }
}

// 3. شاشة اختيار اللهجات واللغة (بينها اللهجة العراقية 🇮🇶)
class LanguageAndDialectScreen extends StatefulWidget {
  const LanguageAndDialectScreen({super.key});

  @override
  State<LanguageAndDialectScreen> createState() => _LanguageAndDialectScreenState();
}

class _LanguageAndDialectScreenState extends State<LanguageAndDialectScreen> {
  String selectedDialect = 'العراقية 🇮🇶';

  final List<String> dialects = [
    'العراقية 🇮🇶',
    'الفصحى 🌐',
    'المصرية 🇪🇬',
    'الخليجية 🇸🇦',
    'English 🇺🇸',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تخصيص لغة SHERKO AI')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('اختر اللهجة التي يكلمك بها المساعد والروبوت:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: dialects.length,
                itemBuilder: (context, index) {
                  final dialect = dialects[index];
                  return RadioListTile<String>(
                    title: Text(dialect, style: const TextStyle(fontSize: 16)),
                    value: dialect,
                    groupValue: selectedDialect,
                    activeColor: const Color(0xFF00E5FF),
                    onChanged: (value) => setState(() => selectedDialect = value!),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00FF88),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainNotesDashboard()),
                );
              },
              child: const Text('دخول للنظام الأكاديمي ➔', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// 4. لوحة الملاحظات وإدارة المجلدات الحصرية (Sherko Studio Workspace)
class MainNotesDashboard extends StatefulWidget {
  const MainNotesDashboard({super.key});

  @override
  State<MainNotesDashboard> createState() => _MainNotesDashboardState();
}

class _MainNotesDashboardState extends State<MainNotesDashboard> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // الشريط الجانبي الأنيق
          Container(
            width: 260,
            color: const Color(0xFF131B2E),
            child: Column(
              children: [
                const SizedBox(height: 50),
                const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFF00E5FF),
                    child: Icon(Icons.person, color: Colors.black),
                  ),
                  title: Text('Dr. Student', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('SHERKO VIP Active', style: TextStyle(color: Color(0xFF00FF88), fontSize: 11)),
                ),
                const Divider(color: Colors.white24, height: 30),
                ListTile(
                  leading: const Icon(Icons.description, color: Color(0xFF00E5FF)),
                  title: const Text('الملاحظات والمحاضرات'),
                  selected: _selectedNavIndex == 0,
                  onTap: () => setState(() => _selectedNavIndex = 0),
                ),
                ListTile(
                  leading: const Icon(Icons.folder_special, color: Colors.amberAccent),
                  title: const Text('المجلدات والصفوف'),
                  selected: _selectedNavIndex == 1,
                  onTap: () => setState(() => _selectedNavIndex = 1),
                ),
                ListTile(
                  leading: const Icon(Icons.auto_awesome, color: Color(0xFF00FF88)),
                  title: const Text('مولد الاختبارات الذكي'),
                  onTap: () {},
                ),
                const Spacer(),
                ListTile(
                  leading: const Icon(Icons.delete_sweep, color: Colors.redAccent),
                  title: const Text('سلة المهملات'),
                  onTap: () {},
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // منطقة عرض الملفات والمجلدات
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('استوديو الملاحظات الأكاديمي', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00E5FF),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AdvancedLectureReaderScreen()),
                          );
                        },
                        icon: const Icon(Icons.note_add_rounded),
                        label: const Text('فتح محاضرة جديدة (PDF/Note)', style: TextStyle(fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        _buildCard('المرحلة الأولى - داء الليشمانيات', '106 ملاحظة ومحاضرة', Icons.folder, Colors.amberAccent, true),
                        _buildCard('Parasitology Lecture 1', 'تم التعديل اليوم', Icons.picture_as_pdf, const Color(0xFF00E5FF), false),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, IconData icon, Color color, bool isFolder) {
    return Card(
      color: const Color(0xFF131B2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdvancedLectureReaderScreen()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60, color: color),
              const SizedBox(height: 15),
              Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 5),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

// 5. قارئ ومحرر المحاضرات الفائق (تفوق على Jnotes بشرائط الأدوات العائمة الاحترافية)
class AdvancedLectureReaderScreen extends StatefulWidget {
  const AdvancedLectureReaderScreen({super.key});

  @override
  State<AdvancedLectureReaderScreen> createState() => _AdvancedLectureReaderScreenState();
}

class _AdvancedLectureReaderScreenState extends State<AdvancedLectureReaderScreen> {
  Color _selectedColor = const Color(0xFF00FF88);
  String _selectedTool = 'Pen';

  final List<Color> _palette = [
    const Color(0xFF00E5FF),
    const Color(0xFF00FF88),
    Colors.amberAccent,
    Colors.pinkAccent,
    Colors.purpleAccent,
    Colors.white,
    Colors.redAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF131B2E),
        title: const Text('Parasitology - Leishmaniasis (Lecture 1)'),
        centerTitle: false,
        actions: [
          // ذكاء اصطناعي 1: توليد 3-4 صور واستخراجها
          IconButton(
            icon: const Icon(Icons.add_photo_alternate_rounded, color: Color(0xFF00E5FF)),
            tooltip: 'استخراج/توليد صور توضيحية بالذكاء الاصطناعي',
            onPressed: () => _generateImagesDialog(),
          ),
          // ذكاء اصطناعي 2: توليد 20 سؤال MCQ
          IconButton(
            icon: const Icon(Icons.quiz_rounded, color: Color(0xFF00FF88)),
            tooltip: 'توليد 20 سؤال MCQ من المحاضرة',
            onPressed: () => _generateMCQsDialog(),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Stack(
        children: [
          // مساحة عرض المحاضرة والتعديل عليها
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(40),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 10)],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Leishmaniasis in humans is caused by more than 20 species of Leishmania.',
                      style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'داء الليشمانيات في البشر سببه أكثر من 20 نوعاً من الليشمانيا.',
                      style: TextStyle(fontSize: 17, color: Colors.deepPurple, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Risk factors include poverty, malnutrition, deforestation and urbanization.',
                      style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'وتشمل عوامل الخطر الفقر وسوء التغذية وإزالة الغابات والتحضر.',
                      style: TextStyle(fontSize: 17, color: Colors.deepPurple, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // شريط أدوات تحرير عائم ومستقل (Custom Glassmorphism Toolbar - متطور كلياً عن Jnotes)
          Positioned(
            left: 20,
            top: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF131B2E).withOpacity(0.95),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.4)),
                boxShadow: const [BoxShadow(color: Colors.black80, blurRadius: 15)],
              ),
              child: Column(
                children: [
                  _buildToolButton(Icons.edit_rounded, 'Pen'),
                  _buildToolButton(Icons.border_color_rounded, 'Highlighter'),
                  _buildToolButton(Icons.select_all_rounded, 'Lasso'),
                  _buildToolButton(Icons.cleaning_services_rounded, 'Eraser'),
                  _buildToolButton(Icons.text_fields_rounded, 'Text'),
                  _buildToolButton(Icons.mic_rounded, 'AudioNote'),
                  const Divider(color: Colors.white24, height: 20),
                  // لوحة اختيار الألوان الشاملة
                  ..._palette.map((color) => _buildColorDot(color)).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton(IconData icon, String toolName) {
    bool isSelected = _selectedTool == toolName;
    return IconButton(
      icon: Icon(icon, color: isSelected ? const Color(0xFF00E5FF) : Colors.white70),
      onPressed: () => setState(() => _selectedTool = toolName),
    );
  }

  Widget _buildColorDot(Color color) {
    bool isSelected = _selectedColor == color;
    return GestureDetector(
      onTap: () => setState(() => _selectedColor = color),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: isSelected ? Colors.white : Colors.transparent, width: 2.5),
        ),
      ),
    );
  }

  void _generateImagesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF131B2E),
        title: const Text('🖼️ توليد واستخراج الصور (Visual AI)'),
        content: const Text('يقوم الذكاء الاصطناعي باستخراج الرسوم أو توليد 3 إلى 4 صور توضيحية لربطها بالملاحظة.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم توليد 4 صور توضيحية للمحاضرة بنجاح!')),
              );
            },
            child: const Text('توليد الصور الآن ⚡', style: TextStyle(color: Color(0xFF00E5FF))),
          )
        ],
      ),
    );
  }

  void _generateMCQsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF131B2E),
        title: const Text('🧠 إنشاء أسئلة MCQ بالذكاء

        content: const Text('هل تريد تحليل نص هذه المحاضرة وتوليد 20 سؤال MCQ باللغة المختارة مع الإجابات النموذجية؟'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('جاري تحليل المحاضرة وصياغة 20 سؤال MCQ...')),
              );
            },
            child: const Text('توليد 20 سؤال 🚀', style: TextStyle(color: Color(0xFF00FF88))),
          )
        ],
      ),
    );
  }
}
