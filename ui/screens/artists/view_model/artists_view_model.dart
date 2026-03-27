import 'package:flutter/material.dart';

import '../../../../data/repositories/artists/artist_repository.dart';
import '../../../../model/artists/artist.dart';
import '../../../utils/async_value.dart';

class ArtistsViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;

  AsyncValue<List<Artist>> artistsValue = AsyncValue.loading();

  ArtistsViewModel({required this.artistRepository}) {
    _init();
  }

  void _init() => fetchArtists();

  void fetchArtists() async {
    // 1 - Loading state
    artistsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2 - Fetch is successful
      List<Artist> artists = await artistRepository.fetchArtists();
      artistsValue = AsyncValue.success(artists);
    } catch (e) {
      // 3 - Fetch is unsuccessful
      artistsValue = AsyncValue.error(e);
    }

    notifyListeners();
  }
}