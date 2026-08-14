import 'package:flutter/material.dart';

void main() => runApp(const FixNowPartnerApp());

const navy = Color(0xFF0D2E4F);
const blue = Color(0xFF1769FF);
const bg = Color(0xFFF5F7FA);

class FixNowPartnerApp extends StatelessWidget {
  const FixNowPartnerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FixNow Partner',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: blue, primary: blue, secondary: navy),
        scaffoldBackgroundColor: bg,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white, foregroundColor: navy, centerTitle: true),
        cardTheme: CardThemeData(color: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
        inputDecorationTheme: InputDecorationTheme(
          filled: true, fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        ),
      ),
      home: const PartnerSplash(),
    );
  }
}

class PartnerSplash extends StatelessWidget {
  const PartnerSplash({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: navy,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(children: [
              const Spacer(),
              Container(width: 110, height: 110, decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(28)), child: const Icon(Icons.handyman_rounded, size: 64, color: Colors.white)),
              const SizedBox(height: 18),
              const Text('FixNow Partner', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: Colors.white)),
              const SizedBox(height: 10),
              const Text('تطبيق الفني', style: TextStyle(fontSize: 18, color: Colors.white70)),
              const Spacer(),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: blue, minimumSize: const Size.fromHeight(54)),
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PartnerLogin())),
                child: const Text('تسجيل الدخول', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class PartnerLogin extends StatelessWidget {
  const PartnerLogin({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('دخول الفني')),
        body: ListView(padding: const EdgeInsets.all(24), children: [
          const SizedBox(height: 28),
          const Icon(Icons.badge_outlined, size: 82, color: blue),
          const SizedBox(height: 24),
          const TextField(keyboardType: TextInputType.phone, decoration: InputDecoration(labelText: 'رقم الجوال', prefixIcon: Icon(Icons.phone_android))),
          const SizedBox(height: 12),
          const TextField(obscureText: true, decoration: InputDecoration(labelText: 'كلمة المرور', prefixIcon: Icon(Icons.lock_outline))),
          const SizedBox(height: 18),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PartnerShell())),
            child: const Text('دخول'),
          ),
          const SizedBox(height: 10),
          const Text('نسخة تجريبية: اضغط للمتابعة مباشرة.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black45)),
        ]),
      ),
    );
  }
}

class PartnerShell extends StatefulWidget {
  const PartnerShell({super.key});
  @override
  State<PartnerShell> createState() => _PartnerShellState();
}

class _PartnerShellState extends State<PartnerShell> {
  int index = 0;
  final pages = const [PartnerDashboard(), PartnerRequests(), PartnerStats(), PartnerProfile()];
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
            NavigationDestination(icon: Icon(Icons.assignment_outlined), selectedIcon: Icon(Icons.assignment), label: 'الطلبات'),
            NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: 'الإحصائيات'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'حسابي'),
          ],
        ),
      ),
    );
  }
}

class PartnerDashboard extends StatefulWidget {
  const PartnerDashboard({super.key});
  @override
  State<PartnerDashboard> createState() => _PartnerDashboardState();
}

class _PartnerDashboardState extends State<PartnerDashboard> {
  bool available = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(18), children: [
        Row(children: [
          const CircleAvatar(radius: 24, backgroundColor: Color(0xFFE4EDFF), child: Icon(Icons.handyman_rounded, color: blue)),
          const SizedBox(width: 10),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('مرحباً محمد', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)), Text('فني تكييف وكهرباء', style: TextStyle(color: Colors.black54))])),
          Switch(value: available, onChanged: (v) => setState(() => available = v)),
        ]),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: navy, borderRadius: BorderRadius.circular(22)),
          child: const Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('الرصيد الحالي', style: TextStyle(color: Colors.white70)),
              SizedBox(height: 5),
              Text('1,250 ر.س', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 28)),
            ])),
            Icon(Icons.account_balance_wallet_rounded, color: blue, size: 42),
          ]),
        ),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: _StatCard('4.9', 'التقييم', Icons.star_rounded)),
          const SizedBox(width: 10),
          Expanded(child: _StatCard('128', 'مكتمل', Icons.check_circle_outline)),
          const SizedBox(width: 10),
          Expanded(child: _StatCard('5', 'اليوم', Icons.assignment_turned_in_outlined)),
        ]),
        const SizedBox(height: 20),
        Text('طلب قريب منك', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 10),
        if (available)
          RequestCard(
            service: 'صيانة تكييف',
            area: 'حي الروضة، جدة',
            distance: '3.2 كم',
            onOpen: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PartnerRequestDetails())),
          )
        else
          const Card(child: Padding(padding: EdgeInsets.all(26), child: Center(child: Text('فعّل حالة متاح لاستقبال الطلبات.')))),
      ]),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value, label;
  final IconData icon;
  const _StatCard(this.value, this.label, this.icon);
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(children: [
        Icon(icon, color: blue),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
        Text(label, style: const TextStyle(color: Colors.black54, fontSize: 12)),
      ]),
    ),
  );
}

class RequestCard extends StatelessWidget {
  final String service, area, distance;
  final VoidCallback onOpen;
  const RequestCard({super.key, required this.service, required this.area, required this.distance, required this.onOpen});
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: const EdgeInsets.all(15), child: Column(children: [
      Row(children: [
        const CircleAvatar(backgroundColor: Color(0xFFE4EDFF), child: Icon(Icons.ac_unit_rounded, color: blue)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(service, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17)), Text('$area • $distance', style: const TextStyle(color: Colors.black54))])),
        const Chip(label: Text('جديد')),
      ]),
      const SizedBox(height: 12),
      const Align(alignment: Alignment.centerRight, child: Text('المكيف يعمل لكن التبريد ضعيف ويوجد صوت خفيف.')),
      const SizedBox(height: 12),
      FilledButton(style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(46)), onPressed: onOpen, child: const Text('عرض التفاصيل')),
    ])));
  }
}

class PartnerRequests extends StatelessWidget {
  const PartnerRequests({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ListView(padding: const EdgeInsets.all(18), children: [
      Text('الطلبات الجديدة', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
      const SizedBox(height: 12),
      RequestCard(service: 'صيانة تكييف', area: 'حي الروضة، جدة', distance: '3.2 كم', onOpen: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PartnerRequestDetails()))),
      RequestCard(service: 'كهرباء - تركيب إنارة', area: 'حي السلامة، جدة', distance: '5.1 كم', onOpen: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PartnerRequestDetails()))),
      RequestCard(service: 'صيانة جهاز منزلي', area: 'حي الشاطئ، جدة', distance: '6.8 كم', onOpen: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PartnerRequestDetails()))),
    ]));
  }
}

class PartnerRequestDetails extends StatefulWidget {
  const PartnerRequestDetails({super.key});
  @override
  State<PartnerRequestDetails> createState() => _PartnerRequestDetailsState();
}

class _PartnerRequestDetailsState extends State<PartnerRequestDetails> {
  final priceController = TextEditingController();
  final notesController = TextEditingController();
  String? error;

  @override
  void dispose() {
    priceController.dispose();
    notesController.dispose();
    super.dispose();
  }

  void sendOffer() {
    final value = int.tryParse(priceController.text.trim());
    if (value == null || value <= 0) {
      setState(() => error = 'أدخل مبلغاً صحيحاً أكبر من صفر');
      return;
    }
    setState(() => error = null);
    Navigator.push(context, MaterialPageRoute(builder: (_) => PartnerActiveJob(price: value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تفاصيل الطلب')),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        const Card(child: Padding(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [CircleAvatar(backgroundColor: Color(0xFFE4EDFF), child: Icon(Icons.ac_unit_rounded, color: blue)), SizedBox(width: 12), Expanded(child: Text('صيانة تكييف', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 19)))]),
          SizedBox(height: 14),
          Text('وصف المشكلة', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text('المكيف يعمل لكن التبريد ضعيف ويوجد صوت خفيف.'),
          Divider(height: 28),
          Row(children: [Icon(Icons.location_on_outlined, color: blue), SizedBox(width: 8), Expanded(child: Text('حي الروضة، جدة • 3.2 كم'))]),
        ]))),
        const SizedBox(height: 14),
        Text('حدد سعر عرضك', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        TextField(
          controller: priceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'السعر بالريال السعودي', prefixIcon: const Icon(Icons.payments_outlined), errorText: error),
        ),
        const SizedBox(height: 10),
        TextField(controller: notesController, maxLines: 3, decoration: const InputDecoration(labelText: 'تفاصيل العرض (اختياري)', hintText: 'مثال: السعر يشمل الكشف والعمل ولا يشمل القطع')),
        const SizedBox(height: 12),
        const Card(child: ListTile(leading: Icon(Icons.schedule_outlined, color: blue), title: Text('وقت الوصول المتوقع'), trailing: Text('20 دقيقة', style: TextStyle(fontWeight: FontWeight.bold)))),
        const SizedBox(height: 18),
        FilledButton.icon(
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(54)),
          onPressed: sendOffer,
          icon: const Icon(Icons.send_rounded),
          label: const Text('إرسال العرض', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        ),
      ]),
    );
  }
}

class PartnerActiveJob extends StatefulWidget {
  final int price;
  const PartnerActiveJob({super.key, required this.price});
  @override
  State<PartnerActiveJob> createState() => _PartnerActiveJobState();
}

class _PartnerActiveJobState extends State<PartnerActiveJob> {
  int step = 1;
  final labels = ['تم القبول', 'في الطريق', 'وصلت', 'جاري العمل'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('متابعة العمل')),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
          Row(children: [
            const CircleAvatar(child: Icon(Icons.person)),
            const SizedBox(width: 12),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('طلب العميل #12345', style: TextStyle(fontWeight: FontWeight.w900)), Text('صيانة تكييف • حي الروضة')])),
            Text('${widget.price} ر.س', style: const TextStyle(fontWeight: FontWeight.w900, color: blue)),
          ]),
          const Divider(height: 28),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: List.generate(labels.length, (i) => Column(children: [
            CircleAvatar(radius: 15, backgroundColor: i <= step ? Colors.green : Colors.black12, child: Icon(i <= step ? Icons.check : Icons.circle, size: 14, color: Colors.white)),
            const SizedBox(height: 5),
            Text(labels[i], style: const TextStyle(fontSize: 11)),
          ]))),
        ]))),
        const SizedBox(height: 16),
        Container(height: 220, decoration: BoxDecoration(color: const Color(0xFFE9F1F7), borderRadius: BorderRadius.circular(20)), child: const Center(child: Icon(Icons.map_rounded, size: 140, color: Color(0xFFB6C9D8)))),
        const SizedBox(height: 16),
        if (step < 3)
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(50)),
            onPressed: () => setState(() => step++),
            child: Text(step == 1 ? 'وصلت إلى العميل' : 'بدء العمل'),
          )
        else
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size.fromHeight(50)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PartnerCompleteJob(price: widget.price))),
            child: const Text('إنهاء العمل'),
          ),
      ]),
    );
  }
}

class PartnerCompleteJob extends StatelessWidget {
  final int price;
  const PartnerCompleteJob({super.key, required this.price});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إكمال الطلب')),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        const CircleAvatar(radius: 42, backgroundColor: Color(0xFFE5F6EA), child: Icon(Icons.check_rounded, color: Colors.green, size: 52)),
        const SizedBox(height: 16),
        const Center(child: Text('تم إنجاز العمل', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 23))),
        const SizedBox(height: 18),
        Card(child: Column(children: [
          ListTile(title: const Text('قيمة العرض'), trailing: Text('$price ر.س')),
          const Divider(height: 1),
          const ListTile(title: Text('عمولة التطبيق (10%)'), trailing: Text('محاكاة تجريبية')),
        ])),
        const SizedBox(height: 14),
        const TextField(maxLines: 3, decoration: InputDecoration(labelText: 'ملاحظات إكمال العمل')),
        const SizedBox(height: 12),
        OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.add_a_photo_outlined), label: const Text('إضافة صور الإنجاز')),
        const SizedBox(height: 18),
        FilledButton(
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(50)),
          onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
          child: const Text('إكمال الطلب'),
        ),
      ]),
    );
  }
}

class PartnerStats extends StatelessWidget {
  const PartnerStats({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ListView(padding: const EdgeInsets.all(18), children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('الإحصائيات', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
        const Chip(label: Text('هذا الشهر')),
      ]),
      const SizedBox(height: 14),
      Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: navy, borderRadius: BorderRadius.circular(20)), child: const Column(children: [
        Text('إجمالي الدخل', style: TextStyle(color: Colors.white70)),
        SizedBox(height: 6),
        Text('3,750 ر.س', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 30)),
      ])),
      const SizedBox(height: 14),
      const Row(children: [
        Expanded(child: Card(child: Padding(padding: EdgeInsets.all(16), child: Column(children: [Text('28', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22)), Text('طلبات مكتملة')])))),
        SizedBox(width: 10),
        Expanded(child: Card(child: Padding(padding: EdgeInsets.all(16), child: Column(children: [Text('4.9', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22)), Text('متوسط التقييم')])))),
      ]),
      const SizedBox(height: 10),
      const Row(children: [
        Expanded(child: Card(child: Padding(padding: EdgeInsets.all(16), child: Column(children: [Text('56', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22)), Text('ساعات عمل')])))),
        SizedBox(width: 10),
        Expanded(child: Card(child: Padding(padding: EdgeInsets.all(16), child: Column(children: [Text('2', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22)), Text('طلبات ملغاة')])))),
      ]),
      const SizedBox(height: 18),
      const Card(child: Padding(padding: EdgeInsets.all(20), child: SizedBox(height: 170, child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _Bar(55), _Bar(90), _Bar(72), _Bar(120), _Bar(80), _Bar(140), _Bar(110),
      ])))),
    ]));
  }
}

class _Bar extends StatelessWidget {
  final double h;
  const _Bar(this.h);
  @override
  Widget build(BuildContext context) => Container(width: 18, height: h, decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(8)));
}

class PartnerProfile extends StatelessWidget {
  const PartnerProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ListView(padding: const EdgeInsets.all(18), children: [
      const Center(child: CircleAvatar(radius: 42, backgroundColor: Color(0xFFE4EDFF), child: Icon(Icons.handyman_rounded, color: blue, size: 42))),
      const SizedBox(height: 12),
      const Center(child: Text('محمد الشهري', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22))),
      const Center(child: Text('فني موثق • 4.9 ⭐', style: TextStyle(color: Colors.black54))),
      const SizedBox(height: 22),
      const Card(child: Column(children: [
        ListTile(leading: Icon(Icons.badge_outlined), title: Text('بيانات الاعتماد'), trailing: Icon(Icons.chevron_right)),
        Divider(height: 1),
        ListTile(leading: Icon(Icons.account_balance_outlined), title: Text('الحساب البنكي'), trailing: Icon(Icons.chevron_right)),
        Divider(height: 1),
        ListTile(leading: Icon(Icons.wallet_outlined), title: Text('المحفظة والتحويلات'), trailing: Icon(Icons.chevron_right)),
        Divider(height: 1),
        ListTile(leading: Icon(Icons.support_agent_outlined), title: Text('الدعم'), trailing: Icon(Icons.chevron_right)),
      ])),
    ]));
  }
}
