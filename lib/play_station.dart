import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'station.dart';

class PlayStationPage extends StatefulWidget {
  const PlayStationPage({super.key, required this.station});
  final Station station;
  @override
  State<StatefulWidget> createState() => _PlayStationPageState();
}

class _PlayStationPageState extends State<PlayStationPage> {
  final _player = AudioPlayer();

  @override
  void initState() {
    final uri = Uri.parse(widget.station.streamURL);
    _player.setAudioSource(AudioSource.uri(uri));
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    widget.station.imageWidget(height: 111),
                    const SizedBox(height: 20,),
                    Text(
                      widget.station.desc,
                      style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        fontWeight: FontWeight.normal
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                    stream: _player.playerStateStream, 
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.playing) {
                        return IconButton(
                          onPressed: () {
                            _player.pause();
                          },
                          icon: Image.asset('images/btn-pause.png')
                        );
                      } else {
                        return IconButton(
                          onPressed: () {
                            _player.play();
                          },
                          icon: Image.asset('images/btn-play.png')
                        );
                      }
                    }
                  )
                ],
              ),
              const SizedBox(height: 22),
              const BottomBar()
            ],
          ),
        )
      ]
    );
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
        children: [
          Image.asset('images/btn-share.png')
        ],
      )
    );
  }
}