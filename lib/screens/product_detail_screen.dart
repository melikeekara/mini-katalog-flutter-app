import 'package:flutter/material.dart';
import '../core/app_routes.dart';
import '../core/formatters.dart';
import '../models/product.dart';
import '../state/cart_state.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final cart = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
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
      body: AnimatedBuilder(
        animation: cart,
        builder: (context, _) {
          final inCart = cart.contains(product);

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Container(
                      height: 280,
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Hero(
                          tag: 'p_${product.id}',
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.contain,
                            errorBuilder: (_, _, _) => Icon(
                              Icons.image_not_supported,
                              size: 90,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.title,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                        ),
                        const SizedBox(width: 10),
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
                            Formatters.tl(product.price),
                            style: TextStyle(
                              color: cs.onPrimaryContainer,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          product.category,
                          style: TextStyle(color: cs.onSurfaceVariant),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Açıklama',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description,
                      style: TextStyle(
                        color: cs.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                decoration: BoxDecoration(
                  color: cs.surface,
                  border: Border(
                    top: BorderSide(color: cs.surfaceContainerHighest),
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: inCart
                        ? null
                        : () {
                            cart.add(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Sepete eklendi!')),
                            );
                          },
                    icon: const Icon(Icons.add_shopping_cart),
                    label: Text(inCart ? 'Sepette' : 'Sepete Ekle'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
