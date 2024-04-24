import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/slider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black45),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, 
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5, right: 5),
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                  "assets/img_perfil.png",
                  height: 50.0,
                  width: 10.0,
                  fit: BoxFit.cover
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text('Delivery App', 
        style: TextStyle(
          color: Colors.black,
          fontSize: 14
        ),),
      ),
      body: Column(
        children: [
          MySlider()
        ],
      )
    );
  }
}
