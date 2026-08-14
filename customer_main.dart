import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FixNowCustomerApp());
}

const navy = Color(0xFF0D2E4F);
const orange = Color(0xFFFF7900);
const bg = Color(0xFFF5F7FA);

class FixNowCustomerApp extends StatelessWidget {
  const FixNowCustomerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FixNow',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: orange, primary: orange, secondary: navy),
        scaffoldBackgroundColor: bg,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white, foregroundColor: navy, centerTitle: true),
        cardTheme: CardThemeData(color: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
        inputDecorationTheme: InputDecorationTheme(
          filled: true, fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        ),
      ),
      home: const CustomerSplash(),
    );
  }
}

class CustomerSplash extends StatelessWidget {
  const CustomerSplash({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: navy,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  width: 110, height: 110,
                  decoration: BoxDecoration(color: orange, borderRadius: BorderRadius.circular(28)),
                  child: const Icon(Icons.home_repair_service_rounded, size: 64, color: Colors.white),
                ),
                const SizedBox(height: 18),
                const Text('FixNow', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900, color: Colors.white)),
                const SizedBox(height: 10),
                const Text('صيانة منزلية عند الطلب', style: TextStyle(fontSize: 18, color: Colors.white70)),
                const Spacer(),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: orange, minimumSize: const Size.fromHeight(54)),
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CustomerLogin())),
                  child: const Text('ابدأ الآن', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerLogin extends StatelessWidget {
  const CustomerLogin({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('تسجيل الدخول')),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 28),
            const Icon(Icons.person_pin_circle_rounded, size: 82, color: orange),
            const SizedBox(height: 22),
            Text('أهلاً بك في FixNow', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 24),
            const TextField(keyboardType: TextInputType.phone, decoration: InputDecoration(labelText: 'رقم الجوال', prefixIcon: Icon(Icons.phone_android))),
            const SizedBox(height: 14),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CustomerShell())),
              child: const Text('إرسال رمز التحقق'),
            ),
            const SizedBox(height: 10),
            const Text('نسخة تجريبية: اضغط للمتابعة مباشرة.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black45)),
          ],
        ),
      ),
    );
  }
}

class CustomerShell extends StatefulWidget {
  const CustomerShell({super.key});
  @override
  State<CustomerShell> createState() => _CustomerShellState();
}

class _CustomerShellState extends State<CustomerShell> {
  int index = 0;
  final pages = const [CustomerHome(), CustomerOrders(), CustomerProfile()];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: pages[index],
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (v) => setState(() => index = v),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'طلباتي'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'حسابي'),
          ],
        ),
      ),
    );
  }
}

class CustomerHome extends StatelessWidget {
  const CustomerHome({super.key});

  static const services = [
    ('تكييف', Icons.ac_unit_rounded),
    ('سباكة', Icons.plumbing_rounded),
    ('كهرباء', Icons.electrical_services_rounded),
    ('نجارة', Icons.carpenter_rounded),
    ('أجهزة منزلية', Icons.kitchen_rounded),
    ('أقفال', Icons.lock_outline_rounded),
    ('دهان', Icons.format_paint_rounded),
    ('تنظيف', Icons.cleaning_services_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 23, backgroundColor: Color(0xFFFFE6CE), child: Icon(Icons.person, color: orange)),
              const SizedBox(width: 10),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('مرحباً أحمد 👋', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)), Text('جدة • الموقع الحالي', style: TextStyle(color: Colors.black54))])),
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded)),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: navy, borderRadius: BorderRadius.circular(22)),
            child: Row(
              children: [
                const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('تحتاج صيانة الآن؟', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 21)),
                  SizedBox(height: 6),
                  Text('اختر الخدمة واستقبل عدة عروض من فنيين قريبين.', style: TextStyle(color: Colors.white70)),
                ])),
                Container(width: 68, height: 68, decoration: BoxDecoration(color: orange, borderRadius: BorderRadius.circular(18)), child: const Icon(Icons.handyman_rounded, color: Colors.white, size: 38)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text('الخدمات', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          GridView.builder(
            itemCount: services.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.45, crossAxisSpacing: 12, mainAxisSpacing: 12),
            itemBuilder: (_, i) {
              final s = services[i];
              return InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RequestServicePage(service: s.$1, icon: s.$2))),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(children: [
                      Container(width: 48, height: 48, decoration: BoxDecoration(color: const Color(0xFFFFE8D4), borderRadius: BorderRadius.circular(14)), child: Icon(s.$2, color: orange)),
                      const SizedBox(width: 12),
                      Expanded(child: Text(s.$1, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
                    ]),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 18),
          Card(
            child: ListTile(
              leading: const CircleAvatar(backgroundColor: Color(0xFFE6F1FF), child: Icon(Icons.verified_user_outlined, color: navy)),
              title: const Text('فنيون موثقون', style: TextStyle(fontWeight: FontWeight.w700)),
              subtitle: const Text('نظام عروض، تقييمات، وتتبع لحالة الطلب'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class RequestServicePage extends StatefulWidget {
  final String service;
  final IconData icon;
  const RequestServicePage({super.key, required this.service, required this.icon});
  @override
  State<RequestServicePage> createState() => _RequestServicePageState();
}

class _RequestServicePageState extends State<RequestServicePage> {
  final desc = TextEditingController();
  bool photo = false;
  @override
  void dispose() { desc.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.service)),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Card(child: ListTile(leading: CircleAvatar(backgroundColor: const Color(0xFFFFE6CE), child: Icon(widget.icon, color: orange)), title: Text(widget.service, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: const Text('خدمة فورية الآن'))),
          const SizedBox(height: 14),
          Text('اشرح المشكلة', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          TextField(controller: desc, maxLines: 4, decoration: const InputDecoration(hintText: 'مثال: المكيف يعمل لكن التبريد ضعيف...')),
          const SizedBox(height: 12),
          OutlinedButton.icon(onPressed: () => setState(() => photo = !photo), icon: Icon(photo ? Icons.check_circle : Icons.add_a_photo_outlined), label: Text(photo ? 'تمت إضافة صورة' : 'إضافة صورة أو فيديو')),
          const SizedBox(height: 12),
          const Card(child: ListTile(leading: Icon(Icons.location_on_rounded, color: orange), title: Text('موقع الخدمة'), subtitle: Text('حي الروضة، جدة'), trailing: Text('تغيير', style: TextStyle(color: orange)))),
          const SizedBox(height: 24),
          FilledButton.icon(
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(54)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OffersSearching(service: widget.service))),
            icon: const Icon(Icons.flash_on_rounded),
            label: const Text('اطلب فني الآن', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          ),
        ],
      ),
    );
  }
}

class OffersSearching extends StatefulWidget {
  final String service;
  const OffersSearching({super.key, required this.service});
  @override
  State<OffersSearching> createState() => _OffersSearchingState();
}

class _OffersSearchingState extends State<OffersSearching> {
  int received = 0;
  int seconds = 10;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() { seconds--; if (received < 5 && seconds % 2 == 0) received++; });
      if (received >= 5 || seconds <= 0) {
        t.cancel();
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OffersList(service: widget.service)));
        });
      }
    });
  }
  @override
  void dispose() { timer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('جاري استقبال العروض')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Stack(alignment: Alignment.center, children: [
            SizedBox(width: 120, height: 120, child: CircularProgressIndicator(value: received / 5, strokeWidth: 8)),
            Text('$received / 5', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 24)),
          ]),
          const SizedBox(height: 28),
          const Text('نبحث عن أفضل الفنيين القريبين', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 21), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text('تم إرسال طلب ${widget.service} إلى الفنيين المتاحين.', textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 14),
          Text('الوقت التجريبي المتبقي: ${seconds.clamp(0, 10)} ث'),
        ]),
      ),
    );
  }
}

class Offer {
  final String name, note;
  final double rating;
  final int jobs, price, eta;
  const Offer(this.name, this.rating, this.jobs, this.price, this.eta, this.note);
}

const offers = [
  Offer('محمد الشهري', 4.9, 235, 150, 25, 'السعر يشمل الكشف والعمل البسيط'),
  Offer('أحمد السلمي', 4.8, 189, 120, 35, 'متاح الآن، قطع الغيار بعد المعاينة'),
  Offer('فهد الغامدي', 4.7, 142, 100, 40, 'عرض اقتصادي'),
  Offer('خالد الحربي', 4.9, 310, 170, 18, 'أسرع وصول'),
  Offer('سعد المطيري', 4.6, 96, 110, 30, 'خبرة في الأعطال المنزلية'),
];

class OffersList extends StatefulWidget {
  final String service;
  const OffersList({super.key, required this.service});
  @override
  State<OffersList> createState() => _OffersListState();
}

class _OffersListState extends State<OffersList> {
  String sort = 'المقترح';
  List<Offer> get list {
    final x = [...offers];
    if (sort == 'السعر') x.sort((a,b) => a.price.compareTo(b.price));
    if (sort == 'الوصول') x.sort((a,b) => a.eta.compareTo(b.eta));
    if (sort == 'التقييم') x.sort((a,b) => b.rating.compareTo(a.rating));
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عروض الفنيين')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('وصلت ${list.length} عروض', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'المقترح', label: Text('المقترح')),
              ButtonSegment(value: 'السعر', label: Text('السعر')),
              ButtonSegment(value: 'الوصول', label: Text('الوصول')),
              ButtonSegment(value: 'التقييم', label: Text('التقييم')),
            ],
            selected: {sort},
            onSelectionChanged: (v) => setState(() => sort = v.first),
          ),
          const SizedBox(height: 14),
          ...list.map((o) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(children: [
                Row(children: [
                  const CircleAvatar(radius: 26, child: Icon(Icons.person)),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(o.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                    Text('⭐ ${o.rating} • ${o.jobs} طلب مكتمل', style: const TextStyle(color: Colors.black54)),
                  ])),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text('${o.price} ر.س', style: const TextStyle(fontWeight: FontWeight.w900, color: orange, fontSize: 18)),
                    Text('${o.eta} دقيقة', style: const TextStyle(color: Colors.black54)),
                  ]),
                ]),
                const SizedBox(height: 10),
                Align(alignment: Alignment.centerRight, child: Text(o.note)),
                const SizedBox(height: 10),
                FilledButton(
                  style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(46)),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TrackingPage(offer: o))),
                  child: const Text('اختيار هذا الفني'),
                ),
              ]),
            ),
          )),
        ],
      ),
    );
  }
}

class TrackingPage extends StatelessWidget {
  final Offer offer;
  const TrackingPage({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تتبع الطلب')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            height: 245,
            decoration: BoxDecoration(color: const Color(0xFFE9F1F7), borderRadius: BorderRadius.circular(22)),
            child: Stack(children: [
              const Center(child: Icon(Icons.map_rounded, size: 160, color: Color(0xFFB6C9D8))),
              Positioned(right: 70, top: 80, child: Container(width: 20, height: 20, decoration: const BoxDecoration(color: orange, shape: BoxShape.circle))),
              Positioned(left: 80, bottom: 65, child: Container(width: 20, height: 20, decoration: const BoxDecoration(color: navy, shape: BoxShape.circle))),
            ]),
          ),
          const SizedBox(height: 14),
          Card(child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Row(children: [
                const CircleAvatar(radius: 27, child: Icon(Icons.person)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(offer.name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
                  Text('⭐ ${offer.rating} • في الطريق إليك'),
                ])),
                IconButton(onPressed: () {}, icon: const Icon(Icons.call_rounded, color: navy)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.chat_bubble_outline_rounded, color: navy)),
              ]),
              const Divider(height: 28),
              const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _StepDot(true, 'تم الاستلام'),
                _StepDot(true, 'في الطريق'),
                _StepDot(false, 'وصل'),
                _StepDot(false, 'اكتمل'),
              ]),
            ]),
          )),
          const SizedBox(height: 14),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(50)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CompletionPage(offer: offer))),
            child: const Text('محاكاة اكتمال الخدمة'),
          ),
        ],
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  final bool active;
  final String label;
  const _StepDot(this.active, this.label);
  @override
  Widget build(BuildContext context) => Column(children: [
    CircleAvatar(radius: 12, backgroundColor: active ? Colors.green : Colors.black12, child: Icon(active ? Icons.check : Icons.circle, size: 12, color: Colors.white)),
    const SizedBox(height: 5),
    Text(label, style: const TextStyle(fontSize: 11)),
  ]);
}

class CompletionPage extends StatefulWidget {
  final Offer offer;
  const CompletionPage({super.key, required this.offer});
  @override
  State<CompletionPage> createState() => _CompletionPageState();
}

class _CompletionPageState extends State<CompletionPage> {
  int rating = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تمت الخدمة')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const CircleAvatar(radius: 46, backgroundColor: Color(0xFFE5F6EA), child: Icon(Icons.check_rounded, color: Colors.green, size: 58)),
          const SizedBox(height: 18),
          const Text('تم إكمال الطلب بنجاح', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 23)),
          const SizedBox(height: 8),
          Text('الفني: ${widget.offer.name}'),
          const SizedBox(height: 20),
          Card(child: ListTile(title: const Text('الإجمالي'), trailing: Text('${widget.offer.price} ر.س', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: orange)))),
          const SizedBox(height: 20),
          const Text('كيف كانت تجربتك؟', style: TextStyle(fontWeight: FontWeight.w700)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(5, (i) => IconButton(onPressed: () => setState(() => rating = i + 1), icon: Icon(i < rating ? Icons.star_rounded : Icons.star_border_rounded, color: Colors.amber, size: 38)))),
          const SizedBox(height: 16),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(50)),
            onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
            child: const Text('إرسال التقييم'),
          ),
        ]),
      ),
    );
  }
}

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ListView(padding: const EdgeInsets.all(18), children: [
      Text('طلباتي', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
      const SizedBox(height: 14),
      const Card(child: ListTile(leading: CircleAvatar(child: Icon(Icons.ac_unit)), title: Text('صيانة تكييف'), subtitle: Text('مكتمل • 12 أغسطس'), trailing: Text('150 ر.س', style: TextStyle(fontWeight: FontWeight.bold)))),
      const Card(child: ListTile(leading: CircleAvatar(child: Icon(Icons.plumbing)), title: Text('سباكة'), subtitle: Text('مكتمل • 2 أغسطس'), trailing: Text('120 ر.س', style: TextStyle(fontWeight: FontWeight.bold)))),
    ]));
  }
}

class CustomerProfile extends StatelessWidget {
  const CustomerProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ListView(padding: const EdgeInsets.all(18), children: [
      const Center(child: CircleAvatar(radius: 42, child: Icon(Icons.person, size: 44))),
      const SizedBox(height: 12),
      const Center(child: Text('أحمد', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22))),
      const Center(child: Text('05XXXXXXXX', style: TextStyle(color: Colors.black54))),
      const SizedBox(height: 22),
      const Card(child: Column(children: [
        ListTile(leading: Icon(Icons.location_on_outlined), title: Text('العناوين المحفوظة'), trailing: Icon(Icons.chevron_right)),
        Divider(height: 1),
        ListTile(leading: Icon(Icons.payment_outlined), title: Text('طرق الدفع'), trailing: Icon(Icons.chevron_right)),
        Divider(height: 1),
        ListTile(leading: Icon(Icons.support_agent_outlined), title: Text('الدعم والمساعدة'), trailing: Icon(Icons.chevron_right)),
      ])),
    ]));
  }
}
