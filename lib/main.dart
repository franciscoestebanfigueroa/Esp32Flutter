import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba/provider/model.dart';

void main() {
  runApp(const Pro());
}

class Pro extends StatelessWidget {
  const Pro({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Model(),
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PageOne());
  }
}

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Model>(context);
    return Container(
        color: Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
                color: data.puerto
                    ? Color.fromARGB(255, 48, 146, 232)
                    : Colors.red,
                onPressed: // data.estado_server
                    () {
                  data.on();
                  print("boton Encender");
                },
                child: const Text("Led")),
            const SizedBox(
              width: 20,
            ),
            MaterialButton(
                color: data.estado_server ? Colors.green : Colors.red,
                child: const Text("Conectar server... "),
                onPressed: () {
                  print("socket esta data.server");
                  print(data.estado_server);
                  data.conectarSocket();
                }),
          ],
        ));
  }
}
