import 'package:flutter/material.dart';
import '../core/app_routes.dart';
import '../data/product_repository.dart';
import '../models/product.dart';
import '../state/cart_state.dart';
import '../widgets/empty_state.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final repo = ProductRepository();

  List<Product> all = [];
  List<Product> shown = [];
  bool loading = true;

  String query = '';
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final products = await repo.loadProducts();
    setState(() {
      all = products;
      shown = products;
      loading = false;
    });
  }

  List<String> get categories {
    final set = <String>{};
    for (final p in all) {
      set.add(p.category);
    }
    final list = set.toList();
    list.sort();
    return list;
  }

  void _apply() {
    final q = query.trim().toLowerCase();

    final filtered = all.where((p) {
      final matchesQuery =
          q.isEmpty ||
          p.title.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q);

      final matchesCategory =
          selectedCategory == null || p.category == selectedCategory;

      return matchesQuery && matchesCategory;
    }).toList();

    setState(() => shown = filtered);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final cart = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Katalog'),
        actions: [
          AnimatedBuilder(
            animation: cart,
            builder: (_, _) {
              return IconButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
                icon: Badge(
                  label: Text('${cart.count}'),
                  isLabelVisible: cart.count > 0,
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                children: [
                  // Banner
                  Container(
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [cs.primary, cs.tertiary],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: DefaultTextStyle(
                              style: TextStyle(color: cs.onPrimary),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Haftasonu Fırsatları',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Ürünleri incele, sepete ekle ve teslim et.',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              Icons.local_offer_outlined,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Search
                  TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Ürün ara (başlık / kategori)',
                    ),
                    onChanged: (v) {
                      query = v;
                      _apply();
                    },
                  ),

                  const SizedBox(height: 10),

                  // Category chips
                  SizedBox(
                    height: 48,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: const Text('Tümü'),
                            selected: selectedCategory == null,
                            onSelected: (_) {
                              setState(() => selectedCategory = null);
                              _apply();
                            },
                          ),
                        ),
                        ...categories.map((c) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(c),
                              selected: selectedCategory == c,
                              onSelected: (_) {
                                setState(() => selectedCategory = c);
                                _apply();
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (shown.isEmpty)
                    const SizedBox(
                      height: 420,
                      child: EmptyState(
                        title: 'Sonuç bulunamadı',
                        subtitle: 'Arama/filtreyi değiştirip tekrar dene.',
                        icon: Icons.search_off,
                      ),
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.74,
                          ),
                      itemCount: shown.length,
                      itemBuilder: (context, index) {
                        final p = shown[index];
                        return ProductCard(
                          product: p,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.detail,
                              arguments: p,
                            );
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
    );
  }
}
