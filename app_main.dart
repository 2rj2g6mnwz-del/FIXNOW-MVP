import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const FixNowApp());

class FixNowApp extends StatelessWidget {
  const FixNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF143D59));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FixNow MVP',
      theme: ThemeData(
        colorScheme: scheme,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        appBarTheme: const AppBarTheme(centerTitle: true),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      home: const RoleSelectPage(),
    );
  }
}

class ServiceCategory {
  final String name;
  final IconData icon;
  const ServiceCategory(this.name, this.icon);
}

class TechnicianOffer {
  final String name;
  final double rating;
  final int jobs;
  final int price;
  final int eta;
  final String note;
  const TechnicianOffer({
    required this.name,
    required this.rating,
    required this.jobs,
    required this.price,
    required this.eta,
    required this.note,
  });
}

const categories = <ServiceCategory>[
  ServiceCategory('تكييف', Icons.ac_unit_rounded),
  ServiceCategory('سباكة', Icons.plumbing_rounded),
  ServiceCategory('كهرباء', Icons.electrical_services_rounded),
  ServiceCategory('نجارة', Icons.carpenter_rounded),
  ServiceCategory('أجهزة منزلية', Icons.kitchen_rounded),
  ServiceCategory('أقفال', Icons.lock_outline_rounded),
];

const demoOffers = <TechnicianOffer>[
  TechnicianOffer(name: 'محمد العتيبي', rating: 4.9, jobs: 428, price: 95, eta: 18, note: 'السعر يشمل الكشف والعمل البسيط.'),
  TechnicianOffer(name: 'أحمد الحربي', rating: 4.8, jobs: 316, price: 85, eta: 27, note: 'متاح الآن ويمكن الوصول خلال أقل من نصف ساعة.'),
  TechnicianOffer(name: 'خالد الزهراني', rating: 4.7, jobs: 201, price: 110, eta: 14, note: 'أسرع وصول، السعر لا يشمل قطع الغيار.'),
  TechnicianOffer(name: 'سعد الغامدي', rating: 4.6, jobs: 156, price: 80, eta: 32, note: 'عرض اقتصادي، قطع الغيار بعد المعاينة.'),
  TechnicianOffer(name: 'تركي المطيري', rating: 4.9, jobs: 501, price: 125, eta: 20, note: 'فني موثق وخبرة عالية.'),
];

class RoleSelectPage extends StatelessWidget {
  const RoleSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Icon(Icons.home_repair_service_rounded, size: 86, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 18),
                Text('FixNow', textAlign: TextAlign.center, style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text('صيانة منزلية فورية • عروض متعددة • اختيارك أنت', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
                const Spacer(),
                FilledButton.icon(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerHomePage())),
                  icon: const Icon(Icons.person_rounded),
                  label: const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: Text('الدخول كتجربة عميل')),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TechnicianHomePage())),
                  icon: const Icon(Icons.handyman_rounded),
                  label: const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: Text('الدخول كتجربة فني')),
                ),
                const SizedBox(height: 20),
                const Text('نسخة MVP تجريبية — لا توجد عمليات دفع أو مواقع حقيقية.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerHomePage extends StatelessWidget {
  const CustomerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('الخدمات الفورية')),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(children: [
                  const CircleAvatar(child: Icon(Icons.location_on_rounded)),
                  const SizedBox(width: 12),
                  const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('موقع الخدمة', style: TextStyle(fontWeight: FontWeight.bold)), Text('جدة • الموقع التجريبي الحالي')])),
                  TextButton(onPressed: () {}, child: const Text('تغيير')),
                ]),
              ),
            ),
            const SizedBox(height: 16),
            Text('ماذا تحتاج الآن؟', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GridView.builder(
              itemCount: categories.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.35, crossAxisSpacing: 12, mainAxisSpacing: 12),
              itemBuilder: (_, i) {
                final category = categories[i];
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RequestPage(category: category))),
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(category.icon, size: 38, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(height: 10),
                        Text(category.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ]),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const ListTile(leading: Icon(Icons.history_rounded), title: Text('طلباتي السابقة'), subtitle: Text('لا توجد طلبات مكتملة في النسخة التجريبية')), 
          ],
        ),
      ),
    );
  }
}

class RequestPage extends StatefulWidget {
  final ServiceCategory category;
  const RequestPage({super.key, required this.category});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final controller = TextEditingController();
  bool photoAttached = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.category.name)),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Text('صف المشكلة باختصار', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(controller: controller, maxLines: 4, decoration: const InputDecoration(hintText: 'مثال: المكيف يعمل ولكن التبريد ضعيف...')),
            const SizedBox(height: 14),
            OutlinedButton.icon(
              onPressed: () => setState(() => photoAttached = !photoAttached),
              icon: Icon(photoAttached ? Icons.check_circle : Icons.add_a_photo_outlined),
              label: Text(photoAttached ? 'تمت إضافة صورة تجريبية' : 'إضافة صورة أو فيديو (اختياري)'),
            ),
            const SizedBox(height: 14),
            const Card(child: ListTile(leading: Icon(Icons.location_on_rounded), title: Text('الموقع الحالي'), subtitle: Text('جدة • يتم إظهار الموقع التقريبي للفني قبل اختياره'))),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => SearchingOffersPage(category: widget.category.name, description: controller.text.trim().isEmpty ? 'مشكلة في ${widget.category.name}' : controller.text.trim())));
              },
              icon: const Icon(Icons.flash_on_rounded),
              label: const Padding(padding: EdgeInsets.symmetric(vertical: 15), child: Text('اطلب فني الآن', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchingOffersPage extends StatefulWidget {
  final String category;
  final String description;
  const SearchingOffersPage({super.key, required this.category, required this.description});

  @override
  State<SearchingOffersPage> createState() => _SearchingOffersPageState();
}

class _SearchingOffersPageState extends State<SearchingOffersPage> {
  int seconds = 12;
  int received = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() {
        seconds--;
        if (seconds == 10) received = 1;
        if (seconds == 8) received = 2;
        if (seconds == 6) received = 3;
        if (seconds == 4) received = 4;
        if (seconds <= 2) received = 5;
      });
      if (seconds <= 0 || received >= 5) {
        t.cancel();
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OffersPage(category: widget.category, description: widget.description)));
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('جاري استقبال العروض')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 28),
            Text('أرسلنا طلبك للفنيين القريبين', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 10),
            const Text('في النظام الفعلي تستمر نافذة العروض حتى 90 ثانية أو وصول 5 عروض. تم تسريعها هنا للعرض التجريبي.', textAlign: TextAlign.center),
            const SizedBox(height: 28),
            Text('$received من 5 عروض', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: received / 5),
            const SizedBox(height: 12),
            Text('الوقت التجريبي المتبقي: ${seconds.clamp(0, 12)} ثانية', style: const TextStyle(color: Colors.black54)),
          ]),
        ),
      ),
    );
  }
}

class OffersPage extends StatefulWidget {
  final String category;
  final String description;
  const OffersPage({super.key, required this.category, required this.description});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  String sort = 'المقترح';

  List<TechnicianOffer> get offers {
    final list = [...demoOffers];
    if (sort == 'السعر') list.sort((a, b) => a.price.compareTo(b.price));
    if (sort == 'الوصول') list.sort((a, b) => a.eta.compareTo(b.eta));
    if (sort == 'التقييم') list.sort((a, b) => b.rating.compareTo(a.rating));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('العروض المتاحة')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('وصلت 5 عروض', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            Text('${widget.category} • ${widget.description}', maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 12),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'المقترح', label: Text('المقترح')),
                ButtonSegment(value: 'السعر', label: Text('السعر')),
                ButtonSegment(value: 'الوصول', label: Text('الوصول')),
                ButtonSegment(value: 'التقييم', label: Text('التقييم')),
              ],
              selected: {sort},
              onSelectionChanged: (s) => setState(() => sort = s.first),
            ),
            const SizedBox(height: 14),
            ...offers.map((offer) => OfferCard(offer: offer, onSelect: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TechnicianConfirmationPage(offer: offer))))),
          ],
        ),
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  final TechnicianOffer offer;
  final VoidCallback onSelect;
  const OfferCard({super.key, required this.offer, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            const CircleAvatar(radius: 24, child: Icon(Icons.handyman_rounded)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(offer.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text('★ ${offer.rating} • ${offer.jobs} مهمة') ])),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('${offer.price} ر.س', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)), Text('${offer.eta} دقيقة', style: const TextStyle(color: Colors.black54))]),
          ]),
          const SizedBox(height: 10),
          Text(offer.note),
          const SizedBox(height: 10),
          FilledButton(onPressed: onSelect, child: const Text('اختيار هذا الفني')),
        ]),
      ),
    );
  }
}

class TechnicianConfirmationPage extends StatefulWidget {
  final TechnicianOffer offer;
  const TechnicianConfirmationPage({super.key, required this.offer});

  @override
  State<TechnicianConfirmationPage> createState() => _TechnicianConfirmationPageState();
}

class _TechnicianConfirmationPageState extends State<TechnicianConfirmationPage> {
  bool confirmed = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => confirmed = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('تأكيد المهمة')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(confirmed ? Icons.check_circle_rounded : Icons.hourglass_top_rounded, size: 80, color: confirmed ? Colors.green : Theme.of(context).colorScheme.primary),
            const SizedBox(height: 20),
            Text(confirmed ? 'أكد الفني المهمة' : 'بانتظار تأكيد الفني...', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(widget.offer.name),
            const SizedBox(height: 30),
            if (confirmed)
              FilledButton.icon(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TrackingPage(offer: widget.offer))),
                icon: const Icon(Icons.navigation_rounded),
                label: const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: Text('متابعة وصول الفني')),
              ),
          ]),
        ),
      ),
    );
  }
}

class TrackingPage extends StatefulWidget {
  final TechnicianOffer offer;
  const TrackingPage({super.key, required this.offer});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  int stage = 0;
  final stages = const ['الفني في الطريق', 'وصل الفني', 'العمل قيد التنفيذ', 'تم إنجاز العمل'];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('متابعة الطلب')),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Container(
              height: 230,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color(0xFFE4EBF0)),
              child: const Stack(children: [
                Center(child: Icon(Icons.map_rounded, size: 90, color: Colors.black26)),
                Positioned(right: 50, top: 65, child: CircleAvatar(child: Icon(Icons.home_rounded))),
                Positioned(left: 70, bottom: 55, child: CircleAvatar(child: Icon(Icons.handyman_rounded))),
              ]),
            ),
            const SizedBox(height: 18),
            Card(child: ListTile(leading: const CircleAvatar(child: Icon(Icons.person)), title: Text(widget.offer.name), subtitle: Text('★ ${widget.offer.rating} • وقت الوصول المبدئي ${widget.offer.eta} دقيقة'), trailing: const Icon(Icons.chat_bubble_outline_rounded))),
            const SizedBox(height: 12),
            Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text(stages[stage], style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              LinearProgressIndicator(value: (stage + 1) / stages.length),
              const SizedBox(height: 14),
              if (stage < 3) OutlinedButton(onPressed: () => setState(() => stage++), child: const Text('محاكاة الانتقال للحالة التالية')),
              if (stage == 3) FilledButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutPage(offer: widget.offer))), child: const Text('مراجعة الفاتورة')),
            ]))),
          ],
        ),
      ),
    );
  }
}

class CheckoutPage extends StatelessWidget {
  final TechnicianOffer offer;
  const CheckoutPage({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    final fee = 10;
    final total = offer.price + fee;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('الفاتورة والدفع')),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(children: [
              line('قيمة الخدمة', '${offer.price} ر.س'),
              line('رسوم الخدمة', '$fee ر.س'),
              const Divider(),
              line('الإجمالي', '$total ر.س', bold: true),
            ]))),
            const SizedBox(height: 14),
            const Card(child: Column(children: [
              RadioListTile(value: 1, groupValue: 1, onChanged: null, title: Text('Apple Pay / مدى / بطاقة'), subtitle: Text('محاكاة دفع إلكتروني')),
              RadioListTile(value: 2, groupValue: 1, onChanged: null, title: Text('نقداً عند الانتهاء')),
            ])),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RatingPage())),
              icon: const Icon(Icons.lock_rounded),
              label: const Padding(padding: EdgeInsets.symmetric(vertical: 15), child: Text('اعتماد ودفع تجريبي')),
            ),
          ],
        ),
      ),
    );
  }

  Widget line(String a, String b, {bool bold = false}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(a, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)), Text(b, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal))]),
  );
}

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int rating = 5;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('تقييم الخدمة')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.task_alt_rounded, size: 74, color: Colors.green),
            const SizedBox(height: 18),
            Text('تم إكمال الطلب بنجاح', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            const Text('كيف كانت تجربتك مع الفني؟'),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(5, (i) => IconButton(onPressed: () => setState(() => rating = i + 1), icon: Icon(i < rating ? Icons.star_rounded : Icons.star_border_rounded, color: Colors.amber, size: 36)))),
            const SizedBox(height: 20),
            FilledButton(onPressed: () => Navigator.popUntil(context, (route) => route.isFirst), child: const Text('إرسال التقييم والعودة للرئيسية')),
          ],
        ),
      ),
    ),
  );

class TechnicianHomePage extends StatefulWidget {
  const TechnicianHomePage({super.key});

  @override
  State<TechnicianHomePage> createState() => _TechnicianHomePageState();
}

class _TechnicianHomePageState extends State<TechnicianHomePage> {
  bool available = true;
  int price = 95;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('تطبيق الفني')),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Card(child: SwitchListTile(value: available, onChanged: (v) => setState(() => available = v), title: Text(available ? 'متاح لاستقبال الطلبات' : 'غير متاح'), secondary: Icon(available ? Icons.online_prediction_rounded : Icons.pause_circle_outline))),
            const SizedBox(height: 18),
            if (available) ...[
              Text('طلب قريب منك', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const Row(children: [CircleAvatar(child: Icon(Icons.ac_unit_rounded)), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('صيانة تكييف', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)), Text('حي قريب • 3.2 كم')]))]),
                const SizedBox(height: 14),
                const Text('المكيف يعمل ولكن التبريد ضعيف ويوجد صوت خفيف.'),
                const SizedBox(height: 14),
                Text('عرضك: $price ر.س', style: const TextStyle(fontWeight: FontWeight.bold)),
                Slider(value: price.toDouble(), min: 60, max: 180, divisions: 12, label: '$price', onChanged: (v) => setState(() => price = v.round())),
                const Text('وقت الوصول المتوقع: 20 دقيقة'),
                const SizedBox(height: 10),
                FilledButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إرسال العرض للعميل في النسخة التجريبية'))), child: const Text('إرسال العرض')),
              ]))),
            ] else
              const Padding(padding: EdgeInsets.only(top: 80), child: Center(child: Text('فعّل حالة متاح لعرض الطلبات القريبة.'))),
          ],
        ),
      ),
    );
  }
}
