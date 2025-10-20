import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/profile/data/models/user_profile.dart';
import '../../features/profile/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_details.dart';


class AppRouter {
  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: '/details',
        builder: (ctx, state) {
          final user = state.extra as UserProfile;
          return ProfileDetailsPage(user: user);
        },
      ),
    ],
  );

  static GoRouter get router => _router;

  static void toDetails(BuildContext context, UserProfile user) {
    context.push('/details', extra: user);
  }
}
