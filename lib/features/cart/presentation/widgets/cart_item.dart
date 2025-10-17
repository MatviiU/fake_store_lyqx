import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_item_entity.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    required this.cartItemEntity,
    required this.onRemove,
    required this.onAdd,
    super.key,
  });

  final CartItemEntity cartItemEntity;
  final VoidCallback onRemove;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final totalPrice = cartItemEntity.product.price * cartItemEntity.quantity;
    final formattedPrice = totalPrice.toStringAsFixed(2);

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              cartItemEntity.product.image,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.error_outline, color: Colors.redAccent),
                );
              },
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItemEntity.product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          _buildQuantityButton(
                            icon: Icons.remove,
                            onPressed: onRemove,
                          ),
                          Container(
                            height: 20,
                            width: 1.5,
                            color: Colors.grey.shade300,
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '${cartItemEntity.quantity}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 1.5,
                            color: Colors.grey.shade300,
                          ),
                          _buildQuantityButton(
                            icon: Icons.add,
                            onPressed: onAdd,
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    Text(
                      '\$$formattedPrice',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(7),
      child: Container(
        constraints: const BoxConstraints(minWidth: 32, minHeight: 36),
        alignment: Alignment.center,
        child: Icon(icon, size: 18, color: Colors.black54),
      ),
    );
  }
}
