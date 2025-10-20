import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../data/models/user_profile.dart';
import '../providers/liked_provider.dart';


class ProfileDetailsPage extends ConsumerWidget {
  final UserProfile user;
  const ProfileDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liked = ref.watch(likedIdsProvider).contains(user.id);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(liked ? Icons.favorite : Icons.favorite_border,
                color: liked ? Colors.red : Colors.white),
            onPressed: () =>
                ref.read(likedIdsProvider.notifier).toggle(user.id),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          // Full-bleed photo
          Positioned.fill(
            child: Hero(
              tag: 'img_${user.id}',
              child: Image.network(user.imageUrl, fit: BoxFit.cover),
            ),
          ),

          // A subtle bottom gradient for legibility (optional but looks like the mock)
          const Positioned(
            left: 0, right: 0, bottom: 0, height: 220,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black38, Colors.transparent],
                ),
              ),
            ),
          ),

          // Bottom info card exactly like the screenshot
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: _BottomInfoCard(
              name: '${user.firstName}, ${user.age}',
              city: user.city,
              country: 'India',
              liked: liked,
              onToggleLike: () => ref.read(likedIdsProvider.notifier).toggle(user.id),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomInfoCard extends StatelessWidget {
  final String name;
  final String city;
  final String country;
  final bool liked;
  final VoidCallback onToggleLike;

  const _BottomInfoCard({
    required this.name,
    required this.city,
    required this.country,
    required this.liked,
    required this.onToggleLike,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // The card
        Container(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              // soft, wide shadow like the mock
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 24,
                spreadRadius: 0,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Texts
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      '$city, $country',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // Heart button inside the card (bottom-right in mock)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Material(
                  color: Colors.white,
                  shape: const CircleBorder(),
                  elevation: 2, // small lift like mock
                  child: IconButton(
                    icon: Icon(
                      liked ? Icons.favorite : Icons.favorite_border,
                      color: liked ? Colors.red : Colors.black87,
                    ),
                    onPressed: onToggleLike,
                  ),
                ),
              ),
            ],
          ),
        ),

        // The top "grabber/pill" centered over the card edge
        Positioned(
          top: -10,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 64,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

