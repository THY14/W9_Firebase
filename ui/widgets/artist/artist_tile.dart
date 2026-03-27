import 'package:flutter/material.dart';

import '../../../model/artists/artist.dart';

class ArtistTile extends StatelessWidget {
  const ArtistTile({
    super.key,
    required this.artist,
  });

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(artist.imageUrl),
            backgroundColor: Colors.grey.shade200,
          ),
          title: Text(
            artist.name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            artist.genre,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          ),
        ),
      ),
    );
  }
}