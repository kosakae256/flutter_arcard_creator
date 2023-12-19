import 'package:myapp/components/color.dart';
import 'package:myapp/ui/create_card/create_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var innerWidth = MediaQuery.of(context).size.width * 0.8;
    return Padding(
      padding: const EdgeInsetsDirectional.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'カードを作成する',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: innerWidth,
              height: innerWidth / 4,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const CreateCardScreen();
                      },
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: theme,
                  foregroundColor: Colors.black,
                  elevation: 0,
                ),
                child: const Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.add_box_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '新規作成',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            '作成したカード',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
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
    );
  }
}
