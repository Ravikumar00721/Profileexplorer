import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_explorer/features/profile/presentation/providers/profile_list_provider.dart';
import '../../../profile/data/datasources/profile_remote_ds.dart';
import '../../data/repositories/profile_repo_iml.dart';
import '../../domain/usecases/fetch_profiles.dart';

final remoteDsProvider = Provider<ProfileRemoteDataSource>((ref) {
  return ProfileRemoteDataSourceImpl();
});

final repoProvider = Provider((ref) {
  return ProfileRepositoryImpl(ref.read(remoteDsProvider));
});

final fetchProfilesProvider = Provider((ref) {
  return FetchProfiles(ref.read(repoProvider));
});

final profileListProvider =
StateNotifierProvider<ProfileListNotifier, ProfileListState>((ref) {
  return ProfileListNotifier(ref.read(fetchProfilesProvider))..load();
});
