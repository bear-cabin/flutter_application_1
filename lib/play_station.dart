import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'station.dart';
import 'station_manager.dart';

class PlayStationPage extends StatefulWidget {
  const PlayStationPage({super.key, required this.station});
  final Station station;
  @override
  State<StatefulWidget> createState() => _PlayStationPageState();
}

class _PlayStationPageState extends State<PlayStationPage> {
  @override
  Widget build(BuildContext context) {
    AudioPlayer player = StationManager.shared.player;
    return Stack(children: [
      Positioned.fill(
        child: Image.asset(
          "images/background.png",
          fit: BoxFit.cover,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          title: Text(widget.station.name),
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 333,
              child: Consumer<StationManager>(
                builder: (context, mgr, child) {
                  final url = mgr.station?.artworkURL;
                  if (url == null) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        widget.station.imageWidget(height: 111),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.station.desc,
                          style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.8),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Image.network(
                      url,
                      width: 300,
                      height: 300,
                      fit: BoxFit.fill,
                      errorBuilder: (context, obj, stack) {
                        return const Text("");
                      },
                    );
                  }
                },
              ),
            ),
            const Spacer(),
            StreamBuilder(
              stream: player.icyMetadataStream,
              builder: (context, snapshot) {
                final title = snapshot.data?.info?.title ?? "";
                final strings = title.split('-');
                return Column(
                  children: [
                    Text(
                      strings.last,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      strings.first,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                    stream: player.playerStateStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.playing) {
                        return IconButton(
                          onPressed: () {
                            player.pause();
                          },
                          icon: Image.asset('images/btn-pause.png'),
                        );
                      } else {
                        return IconButton(
                          onPressed: () {
                            player.play();
                          },
                          icon: Image.asset('images/btn-play.png'),
                        );
                      }
                    })
              ],
            ),
            const SizedBox(height: 22),
            const BottomBar()
          ],
        ),
      )
    ]);
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 44,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          children: [Image.asset('images/btn-share.png')],
        ));
  }
}
