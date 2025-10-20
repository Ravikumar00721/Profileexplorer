import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/app_router.dart';

import '../../data/models/user_profile.dart';
import '../providers/profile_list_provider.dart';
import '../providers/provider.dart';
import '../widgets/profile_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SafeArea(
        child: switch (state) {
          ProfileLoading() => const Center(child: CircularProgressIndicator()),
          ProfileError(:final message) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => ref.read(profileListProvider.notifier).load(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          ProfileData(:final items) => RefreshIndicator(
            onRefresh: () => ref.read(profileListProvider.notifier).refresh(),
            child: _Grid(items: items),
          ),
        },
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  final List<UserProfile> items;
  const _Grid({required this.items});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width >= 900 ? 4 : width >= 600 ? 3 : 2;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 12, mainAxisSpacing: 12,
        childAspectRatio: 0.80, // tall cards like design
      ),
      itemCount: items.length,
      itemBuilder: (c, i) => ProfileCard(
        user: items[i],
        onTap: () => AppRouter.toDetails(c, items[i]),
      ),
    );
  }
}
