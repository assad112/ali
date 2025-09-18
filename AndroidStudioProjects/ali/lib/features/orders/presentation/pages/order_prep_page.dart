import 'package:flutter/material.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/dimens.dart';
import '../../../../core/widgets/pill_button.dart';
import '../../../scanner/presentation/pages/barcode_scan_page.dart';

class OrderPrepPage extends StatefulWidget {
  final String orderId;
  final Duration prepTime;

  const OrderPrepPage({
    super.key,
    required this.orderId,
    required this.prepTime,
  });

  @override
  State<OrderPrepPage> createState() => _OrderPrepPageState();
}

class _OrderPrepPageState extends State<OrderPrepPage> {
  final TextEditingController _codeCtrl = TextEditingController();

  final List<_PrepItem> _items = const [
    _PrepItem(
      name: 'نادك بطعم الشوكولاد',
      sku: '21312323',
      group: 'قشطة',
      shelfNo: '103',
      qty: 22,
      rack: 23,
      ok: false,
      image: 'https://images.unsplash.com/photo-1558642452-9d2a7deb7f62?w=512&q=60',
    ),
    _PrepItem(
      name: 'نادك بطعم الشوكولاد',
      sku: '21312323',
      group: 'قشطة',
      shelfNo: '103',
      qty: 22,
      rack: 23,
      ok: true,
      image: 'https://images.unsplash.com/photo-1558642452-9d2a7deb7f62?w=512&q=60',
    ),
    _PrepItem(
      name: 'نادك بطعم الشوكولاد',
      sku: '21312323',
      group: 'قشطة',
      shelfNo: '103',
      qty: 22,
      rack: 23,
      ok: false,
      image: 'https://images.unsplash.com/photo-1558642452-9d2a7deb7f62?w=512&q=60',
    ),
    _PrepItem(
      name: 'نادك بطعم الشوكولاد',
      sku: '21312323',
      group: 'قشطة',
      shelfNo: '103',
      qty: 22,
      rack: 23,
      ok: false,
      image: 'https://images.unsplash.com/photo-1558642452-9d2a7deb7f62?w=512&q=60',
    ),
  ];

  Future<void> _startScan() async {
    final code = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const BarcodeScanPage()),
    );
    if (code != null && code.isNotEmpty) {
      _codeCtrl.text = code;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    AppDimens.init(context);
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final prepText =
        '${widget.prepTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(widget.prepTime.inSeconds.remainder(60)).toString().padLeft(2, '0')}';

    final double headerH = 140 * AppDimens.scale;
    final double overlap = 30 * AppDimens.scale;
    final double bodyTop = (headerH - overlap).clamp(0, headerH);
    final double bottomSafe = 16 + AppDimens.safeBottom + 72;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: cs.surface,
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: headerH,
                child: Container(
                  color: AppColors.primary,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16 * AppDimens.scale,
                    vertical: 12 * AppDimens.scale,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.of(context).maybePop(),
                            icon: const Icon(Icons.arrow_back),
                            color: Colors.white,
                            iconSize: 28 * AppDimens.scale,
                          ),
                          const Spacer(),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.notifications_none),
                                color: Colors.white,
                                iconSize: 26 * AppDimens.scale,
                              ),
                              Positioned(
                                top: 6,
                                right: 6,
                                child: Container(
                                  height: 16,
                                  width: 16,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 12,
                                    width: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade600,
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      '2',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID ${widget.orderId}  مدة التحضير $prepText',
                        textAlign: TextAlign.center,
                        style: tt.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                top: bodyTop,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20 * AppDimens.scale),
                    topRight: Radius.circular(20 * AppDimens.scale),
                  ),
                  child: Container(
                    color: cs.background,
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        const SliverToBoxAdapter(child: SizedBox(height: 16)),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _codeCtrl,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintText: 'الكود',
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(22),
                                        borderSide: BorderSide(color: cs.outlineVariant),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(22),
                                        borderSide: BorderSide(color: cs.outlineVariant),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(22),
                                        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
                                      ),
                                    ),
                                    textInputAction: TextInputAction.search,
                                    onSubmitted: (_) {},
                                  ),
                                ),
                                const SizedBox(width: 12),
                                _CircleIconButton(
                                  icon: Icons.qr_code_scanner,
                                  onTap: _startScan,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 16)),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              if (index.isOdd) return const SizedBox(height: 14);
                              final i = index ~/ 2;
                              if (i >= _items.length) return null;
                              return _PrepItemCard(
                                item: _items[i],
                                onToggleOk: () {
                                  setState(() {
                                    final it = _items[i];
                                    _items[i] = it.copyWith(ok: !it.ok);
                                  });
                                },
                              );
                            },
                            childCount: _items.length * 2 - 1,
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: bottomSafe)),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: SafeArea(
                  top: false,
                  child: PillButton(
                    label: 'تسليم',
                    selected: true,
                    onTap: () {},
                    selectedBgColor: const Color(0xFFF6BC56),
                    selectedTextColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleIconButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          height: 42,
          width: 42,
          child: Icon(icon, color: cs.outline),
        ),
      ),
    );
  }
}

class _PrepItem {
  final String name;
  final String sku;
  final String group;
  final String shelfNo;
  final int qty;
  final int rack;
  final bool ok;
  final String image;

  const _PrepItem({
    required this.name,
    required this.sku,
    required this.group,
    required this.shelfNo,
    required this.qty,
    required this.rack,
    required this.ok,
    required this.image,
  });

  _PrepItem copyWith({
    String? name,
    String? sku,
    String? group,
    String? shelfNo,
    int? qty,
    int? rack,
    bool? ok,
    String? image,
  }) {
    return _PrepItem(
      name: name ?? this.name,
      sku: sku ?? this.sku,
      group: group ?? this.group,
      shelfNo: shelfNo ?? this.shelfNo,
      qty: qty ?? this.qty,
      rack: rack ?? this.rack,
      ok: ok ?? this.ok,
      image: image ?? this.image,
    );
  }
}

class _PrepItemCard extends StatelessWidget {
  final _PrepItem item;
  final VoidCallback? onToggleOk;

  const _PrepItemCard({required this.item, this.onToggleOk});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * AppDimens.scale),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        elevation: 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onToggleOk,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.image,
                        height: 68,
                        width: 88,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: -6,
                      right: 6,
                      child: Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${item.rack}',
                          style: tt.labelMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        item.name,
                        textAlign: TextAlign.center,
                        style: tt.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: cs.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'رقم الصنف: ${item.sku}\nاسم المجموعة: ${item.group}\nرقم الرف: ${item.shelfNo}',
                        textAlign: TextAlign.center,
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                _QtyBox(qty: item.qty),
                const SizedBox(width: 10),
                _StatusDot(ok: item.ok),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool ok;
  const _StatusDot({required this.ok});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      width: 26,
      decoration: BoxDecoration(
        color: ok ? Colors.green.shade600 : Colors.red.shade600,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(ok ? Icons.check : Icons.error_outline, size: 16, color: Colors.white),
    );
  }
}

class _QtyBox extends StatelessWidget {
  final int qty;
  const _QtyBox({required this.qty});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      height: 42,
      width: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.outlineVariant),
      ),
      alignment: Alignment.center,
      child: Text(
        '$qty',
        style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
