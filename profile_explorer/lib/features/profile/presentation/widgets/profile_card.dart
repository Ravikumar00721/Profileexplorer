import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_profile.dart';
import '../providers/liked_provider.dart';


class ProfileCard extends ConsumerWidget {
  final UserProfile user;
  final VoidCallback onTap;
  const ProfileCard({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liked = ref.watch(likedIdsProvider).contains(user.id);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Hero(
              tag: 'img_${user.id}',
              child: Image.network(
                user.imageUrl,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (c, w, p) =>
                p == null ? w : const Center(child: CircularProgressIndicator()),
              ),
            ),
            // gradient overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter, end: Alignment.center,
                    colors: [Colors.black87, Colors.transparent],
                  ),
                ),
              ),
            ),
            // name/loc
            Positioned(
              left: 12, right: 12, bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${user.firstName}, ${user.age}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 2),
                  Text(user.city,
                      style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            // heart
            Positioned(
              right: 10, top: 10,
              child: _HeartButton(
                isLiked: liked,
                onPressed: () => ref.read(likedIdsProvider.notifier).toggle(user.id),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeartButton extends StatefulWidget {
  final bool isLiked;
  final VoidCallback onPressed;
  const _HeartButton({required this.isLiked, required this.onPressed});

  @override
  State<_HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<_HeartButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
  AnimationController(vsync: this, duration: const Duration(milliseconds: 180));
  @override
  void didUpdateWidget(covariant _HeartButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLiked != widget.isLiked) _c.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 1.0, end: 1.2).animate(_c),
      child: Material(
        color: Colors.white.withOpacity(0.85),
        shape: const CircleBorder(),
        child: IconButton(
          icon: Icon(
            widget.isLiked ? Icons.favorite : Icons.favorite_border,
            color: widget.isLiked ? Colors.red : Colors.black87,
          ),
          onPressed: widget.onPressed,
        ),
      ),
    );
  }

  @override
  void dispose() { _c.dispose(); super.dispose(); }
}
