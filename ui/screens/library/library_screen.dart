import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/service/song_service.dart';
import '../../states/player_state.dart';
import 'view_model/library_view_model.dart';
import 'widgets/library_content.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LibraryViewModel(
        songService: context.read<SongService>(),
        playerState: context.read<PlayerState>(),
      ),
      child: const LibraryContent(),
    );
  }
}