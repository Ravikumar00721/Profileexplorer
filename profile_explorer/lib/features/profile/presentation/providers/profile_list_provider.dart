import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../profile/domain/usecases/fetch_profiles.dart';

import '../../../../core/utils/failure.dart';
import '../../data/models/user_profile.dart';


sealed class ProfileListState {
  const ProfileListState();
}
class ProfileLoading extends ProfileListState { const ProfileLoading(); }
class ProfileError extends ProfileListState {
  final String message; const ProfileError(this.message);
}
class ProfileData extends ProfileListState {
  final List<UserProfile> items; const ProfileData(this.items);
}

class ProfileListNotifier extends StateNotifier<ProfileListState> {
  final FetchProfiles _fetch;
  ProfileListNotifier(this._fetch) : super(const ProfileLoading());

  Future<void> load() async {
    state = const ProfileLoading();
    try {
      final items = await _fetch();
      state = ProfileData(items);
    } on Failure catch (f) {
      state = ProfileError(f.message);
    } catch (e) {
      state = ProfileError(e.toString());
    }
  }

  Future<void> refresh() => load();
}
