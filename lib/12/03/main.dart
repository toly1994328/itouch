import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: ListenerDemo(),
        ),
      ),
    );
  }
}

class ListenerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Listener(
          child:
          ConstrainedBox(
            constraints: BoxConstraints.tight(Size(300.0, 200.0)),
            child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.blue)),
          ),
          onPointerDown: (event) => print("down0"),
        ),
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(200.0, 100.0)),
            child: Center(child: Text("左上角200*100范围内非文本区域点击")),
          ),
          onPointerDown: (event) => print("down1"),
          behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
        )
      ],
    );

    // return Stack(
    //   children: [
    //     GestureDetector(
    //       onTap: onTap1,
    //       // behavior: HitTestBehavior.translucent,
    //       child: ConstrainedBox(
    //         constraints: BoxConstraints.tight(Size(200.0, 200.0)),
    //         child: DecoratedBox(
    //             decoration: BoxDecoration(color: Colors.blue)),
    //       ),
    //     ),
    //     GestureDetector(
    //       behavior: HitTestBehavior.translucent,
    //       onTap: onTap2,
    //       child: ConstrainedBox(
    //         constraints: BoxConstraints.tight(Size(80.0, 80.0)),
    //         child: Center(child: Text('ME')),
    //       ),
    //     ),
    //   ],
    // );
  }

  void onTap1() {
    print('-----onTap1----');
  }

  void onTap2() {
    print('-----onTap2----');
  }
}
