import '../../model/artists/artist.dart';
import '../../model/artists/song_with_artist.dart';
import '../repositories/artists/artist_repository.dart';
import '../repositories/songs/song_repository.dart';

class SongService {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;

  SongService({
    required this.songRepository,
    required this.artistRepository,
  });

  Future<List<SongWithArtist>> fetchSongsWithArtist() async {
    final results = await Future.wait([
      songRepository.fetchSongs(),
      artistRepository.fetchArtists(),
    ]);

    final songs   = results[0];
    final artists = results[1];


    final Map<String, Artist> artistById = {
      for (final artist in artists) artist.id: artist,
    };

    return songs.map((song) {
      final artist = artistById[song.artistId];
      if (artist == null) {
        throw Exception('No artist found for song "${song.title}" '
            '(artistId: ${song.artistId})');
      }
      return SongWithArtist(song: song, artist: artist);
    }).toList();
  }
}