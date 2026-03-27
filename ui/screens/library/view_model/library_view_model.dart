import 'package:flutter/material.dart';

import '../../../../data/service/song_service.dart';
import '../../../../model/artists/song_with_artist.dart';
import '../../../states/player_state.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongService songService;
  final PlayerState playerState;

  AsyncValue<List<SongWithArtist>> songsValue = AsyncValue.loading();

  LibraryViewModel({required this.songService, required this.playerState}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<SongWithArtist> songs = await songService.fetchSongsWithArtist();
      songsValue = AsyncValue.success(songs);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  bool isSongPlaying(SongWithArtist s) =>
      playerState.currentSong?.id == s.id;

  void start(SongWithArtist s) => playerState.start(s.song);
  void stop(SongWithArtist s) => playerState.stop();
}