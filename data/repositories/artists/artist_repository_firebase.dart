import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/artists/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

const String baseUrl = "w9-db-8d7c4-default-rtdb.asia-southeast1.firebasedatabase.app";

class ArtistRepositoryFirebase extends ArtistRepository {
  final Uri artistsUri = Uri.https(baseUrl, '/artists.json');

  List<Artist>? _cache;

  @override
  Future<List<Artist>> fetchArtists() async {
    if (_cache != null) return _cache!;

    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> artistsJson = json.decode(response.body);

      List<Artist> artists = [];
      artistsJson.forEach((id, data) {
        final Artist artist = ArtistDto.fromJson(id, data);
        artists.add(artist);
      });

      _cache = artists;
      return _cache!;
    } else {
      throw Exception('Failed to load artists');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {
    final List<Artist> artists = await fetchArtists();
    try {
      return artists.firstWhere((artist) => artist.id == id);
    } catch (_) {
      return null;
    }
  }
}