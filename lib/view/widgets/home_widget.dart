import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.deepPurple,
          child: TabBar(
            // isScrollable: true,
            // labelPadding: const EdgeInsets.only(top: 25),
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            controller: _controller,
            tabs: const [
              Tab(
                child: Text(
                  "All",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                child: Text(
                  "PLAYING",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                child: Text(
                  "COMPLETE",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                child: Text(
                  "PLAN TO PLAY",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 100,
          child: TabBarView(controller: _controller, children: const [
            Center(
                child: Text(
              "ALL",
              style: TextStyle(fontSize: 12),
            )),
            Center(
                child: Text(
              "PLAYING",
              style: TextStyle(fontSize: 12),
            )),
            Center(
                child: Text(
              "COMPLETED",
              style: TextStyle(fontSize: 12),
            )),
            Center(
                child: Text(
              "PLAN TO PLAY",
              style: TextStyle(fontSize: 12),
            )),
          ]),
        ),
      ],
    );
  }
}
