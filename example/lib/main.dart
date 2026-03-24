import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isRunning = useState(true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Mjpeg(
                isLive: isRunning.value,
                error: (context, error, stack) {
                  print(error);
                  print(stack);
                  return Text(error.toString(), style: TextStyle(color: Colors.red));
                },
                stream:
                'http://uk.jokkmokk.jp/photo/nr4/latest.jpg', //'http://192.168.1.37:8081',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    isRunning.value = !isRunning.value;
                  },
                  child: Text('Toggle isLive'),
                ),
                const SizedBox(width: 16),
                Text('isLive: ${isRunning.value}'),
                const SizedBox(width: 16),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Scaffold(
                              appBar: AppBar(
                                title: Text('New Route'),
                              ),
                              body: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Text(
                                    'This screen demonstrations route navigation while the MJPEG stream is active.\n\n'
                                    'When you navigate here, the Mjpeg widget on the previous screen is temporarily removed '
                                    'from the active render tree but kept alive in memory. When you press back, it should '
                                    'resume seamlessly without crashing or memory leaks.\n\n'
                                    'This tests the internal lifecycle and disposal mechanisms of the stream parser.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            )));
                  },
                  child: Text('Push new route'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
