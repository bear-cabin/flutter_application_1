import 'package:flutter/material.dart';
import 'package:flutter_application_1/play_station.dart';
import 'package:flutter_application_1/station_manager.dart';
import 'package:provider/provider.dart';
import 'station.dart';

class StationListPage extends StatefulWidget {
  const StationListPage({super.key});
  @override
  State<StationListPage> createState() => _StationListPageState();
}

class _StationListPageState extends State<StationListPage> {
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
        SafeArea(
          child: Column(
            children: [
              const TopBar(),
              Expanded(
                child: Consumer<StationManager>(builder: (context, mgr, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: mgr.stations.length,
                    itemBuilder: (context, index) {
                      Color color = const Color.fromRGBO(255, 255, 255, 0.1);
                      if (index % 2 != 0) {
                        color = Colors.transparent;
                      }
                      return StationCell(
                        station: mgr.stations[index],
                        color: color,
                      );
                    },
                  );
                }),
              ),
              Consumer<StationManager>(
                builder: (context, mgr, child) {
                  if (mgr.station == null) {
                    return const Padding(padding: EdgeInsets.only());
                  } else {
                    return BottomBar();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          const SizedBox(
            width: 8,
          ),
          IconButton(
            onPressed: () {
              Station station = StationManager.shared.stations.first;
              StationManager.shared.replaceStation(station);
            },
            icon: const Icon(Icons.menu),
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  final player = StationManager.shared.player;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Consumer<StationManager>(
              builder: (context, mgr, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                      stream: player.icyMetadataStream,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data?.info?.title ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 4),
                    Text(
                      mgr.station?.name ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StationCell extends StatelessWidget {
  const StationCell({super.key, required this.station, required this.color});
  final Station station;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        StationManager.shared.replaceStation(station);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PlayStationPage(station: station);
            },
          ),
        );
      },
      child: Container(
        color: color,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SizedBox(
          height: 68,
          child: Row(
            children: [
              station.imageWidget(),
              const SizedBox(
                width: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    station.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    station.desc,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
