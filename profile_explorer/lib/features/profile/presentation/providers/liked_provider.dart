import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikedIdsNotifier extends StateNotifier<Set<String>> {
  LikedIdsNotifier() : super(<String>{});

  bool isLiked(String id) => state.contains(id);

  void toggle(String id) {
    final newSet = Set<String>.from(state);
    if (!newSet.remove(id)) newSet.add(id);
    state = newSet;
  }
}

final likedIdsProvider =
StateNotifierProvider<LikedIdsNotifier, Set<String>>((ref) {
  return LikedIdsNotifier();
});
