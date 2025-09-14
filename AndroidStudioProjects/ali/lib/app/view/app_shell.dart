import 'package:flutter/material.dart';
import '../../core/styles/colors.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import 'widgets/app_drawer.dart';
import '../../features/orders/presentation/pages/orders_page.dart';


class _OrdersPage extends StatelessWidget {
  const _OrdersPage();
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 1;

  final List<Widget> _pages = const [
    OrdersPage(),   // 0: الطلبات ✅
    HomePage(),     // 1: الرئيسية
    SettingsPage(), // 2: الإعدادات
  ];
  final List<String> _titles = const ['الطلبات', 'الرئيسية', 'الإعدادات'];

  // حجم الحواف وتداخل الورقة داخل منطقة الـAppBar (لتقليل الأصفر)
  static const double _corner  = 34;
  static const double _overlap = 100; // ← كلما كبر الرقم، قلّ الأصفر أسفل البار

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 52, // ← قلّل ارتفاع البار
      title: Text(_titles[_index]),
      leading: Builder(
        builder: (ctx) => IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () => Scaffold.of(ctx).openDrawer(), // يفتح الدرج من اليمين (RTL)
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8, end: 16),
          child: InkResponse(
            onTap: () {},
            radius: 20,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.notifications_none_rounded, size: 18),
            ),
          ),
        ),
      ],
    );

    // ارتفاع البار + شريط الحالة لبدء الورقة من تحته
    final double topOffset =
        appBar.preferredSize.height + MediaQuery.of(context).padding.top;

    final double drawerWidth = MediaQuery.of(context).size.width * 0.82;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.surface, // الخلفية العامة بيضاء
        appBar: appBar,

        body: Stack(
          children: [
            // تلوين الشريط أسفل الـAppBar (حتى لا يظهر خلف الورقة لون أبيض)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: topOffset,
              child: const ColoredBox(color: AppColors.primary),
            ),

            // الورقة البيضاء بحواف علوية يمين/يسار، تدخل قليلاً داخل منطقة البار
            Positioned.fill(
              top: topOffset - _overlap,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(_corner),
                ),
                child: ColoredBox(
                  color: AppColors.surface,
                  child: IndexedStack(index: _index, children: _pages),
                ),
              ),
            ),
          ],
        ),

        // الدرج (يمين في RTL) بانحناءة داخلية يسار
        drawer: Drawer(
          width: drawerWidth,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
          ),
          child: const SafeArea(child: AppDrawerContent()),
        ),
        drawerEnableOpenDragGesture: true,

        // شريط التبويب السفلي
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined),
              selectedIcon: Icon(Icons.receipt_long),
              label: 'الطلبات',
            ),
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'الإعدادات',
            ),
          ],
        ),
      ),
    );
  }
}
