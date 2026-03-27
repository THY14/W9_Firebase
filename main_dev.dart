import 'package:provider/provider.dart';

import 'data/repositories/artists/artist_repository.dart';
import 'data/repositories/artists/artist_repository_firebase.dart';
import 'data/repositories/settings/app_settings_repository_mock.dart';
import 'data/repositories/songs/song_repository.dart';
import 'data/repositories/songs/song_repository_firebase.dart';
import 'data/service/song_service.dart';
import 'main_common.dart';
import 'ui/states/player_state.dart';
import 'ui/states/settings_state.dart';

List<InheritedProvider> get devProviders {
  final appSettingsRepository = AppSettingsRepositoryMock();
  final songRepository        = SongRepositoryFirebase();
  final artistRepository      = ArtistRepositoryFirebase();

  return [

    // 1 - Inject the song repository
    Provider<SongRepository>(create: (_) => songRepository),

    // 2 - Inject the artist repository
    Provider<ArtistRepository>(create: (_) => artistRepository),

    // 3 - Inject the song service 
    Provider<SongService>(
      create: (_) => SongService(
        songRepository:   songRepository,
        artistRepository: artistRepository,
      ),
    ),

    // 4 - Inject the player state
    ChangeNotifierProvider<PlayerState>(create: (_) => PlayerState()),

    // 5 - Inject the app setting state
    ChangeNotifierProvider<AppSettingsState>(
      create: (_) => AppSettingsState(repository: appSettingsRepository),
    ),
  ];
}

void main() {
  mainCommon(devProviders);
}