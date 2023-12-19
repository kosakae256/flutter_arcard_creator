import 'package:flutter/material.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    var innerWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsDirectional.all(30),
        child: Column(
          children: <Widget>[
            Expanded(
              child: RefreshIndicator(
                color: const Color.fromARGB(255, 72, 72, 72),
                onRefresh: () async {},
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: SizedBox(
                          width: innerWidth,
                          height: innerWidth / 1.48,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 18),
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              foregroundColor: Colors.black,
                              elevation: 0,
                            ),
                            child: const Center(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
