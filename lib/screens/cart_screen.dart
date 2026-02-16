import 'package:flutter/material.dart';
import '../core/formatters.dart';
import '../state/cart_state.dart';
import '../widgets/empty_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> _showCheckoutDialog(BuildContext context, CartState cart) async {
    final cs = Theme.of(context).colorScheme;

    await showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Satın Alma'),
          content: Text(
            'Toplam: ${Formatters.tl(cart.total)}\n\n'
            'Bu demo projede ödeme simülasyonudur.\n'
            'Onaylarsan sepet temizlenecek.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Vazgeç'),
            ),
            FilledButton(
              onPressed: () {
                cart.clear();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Sipariş alındı! (Simülasyon)'),
                    backgroundColor: cs.primary,
                  ),
                );
              },
              child: const Text('Onayla'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final cart = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sepet'),
        actions: [
          AnimatedBuilder(
            animation: cart,
            builder: (_, _) {
              return IconButton(
                onPressed: cart.count == 0
                    ? null
                    : () {
                        cart.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sepet temizlendi')),
                        );
                      },
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Sepeti temizle',
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: AnimatedBuilder(
        animation: cart,
        builder: (context, _) {
          if (cart.count == 0) {
            return EmptyState(
              title: 'Sepet boş',
              subtitle: 'Ana sayfadan ürün ekleyince burada listelenecek.',
              icon: Icons.shopping_cart_outlined,
              action: FilledButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Ürünlere dön'),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Toplam',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: cs.primaryContainer,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              Formatters.tl(cart.total),
                              style: TextStyle(
                                color: cs.onPrimaryContainer,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: FilledButton.icon(
                          onPressed: () => _showCheckoutDialog(context, cart),
                          icon: const Icon(Icons.payment),
                          label: const Text('Satın Al'),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '',
                        style: TextStyle(
                          color: cs.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ...cart.items.map((p) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      leading: Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            p.image,
                            fit: BoxFit.contain,
                            errorBuilder: (_, _, _) => Icon(
                              Icons.image_not_supported,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        p.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(
                        Formatters.tl(p.price),
                        style: TextStyle(color: cs.onSurfaceVariant),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => cart.remove(p),
                        tooltip: 'Kaldır',
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
