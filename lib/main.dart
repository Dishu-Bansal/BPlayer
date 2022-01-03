import 'dart:io';

import 'package:bplayer/player.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<FileSystemEntity> fil = List.empty(growable: true);
  Directory? currentDirectory;
  bool loading=true;

  getFiles(Directory current) async {
    setState(() {
      loading = true;
    });
    Stream<FileSystemEntity> files = current.list();
    fil = await files.toList();
    setState(() {
      loading=false;
    });
  }

  initialize() async {
    var status = Permission.storage;
    if(await status.isDenied)
    {
      await Permission.storage.request();
    }
    var b = await getExternalStorageDirectory();
    currentDirectory = b!.parent.parent.parent;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    initialize();
  }


  enterFolder(String path) async {
    print("path is: " + path.toString());
    fil = await Directory(path).list().toList();
    print("fil is: " + fil.toString());
    setState(()  {
    loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {

    return  loading ? Scaffold(body: Center(child: CircularProgressIndicator(),)) : Scaffold(
      appBar: AppBar(
        title: Text(currentDirectory!.path.replaceAll("/", " > ")),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black,),
            onPressed: () {
                getFiles(currentDirectory!.parent);
            }),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: fil.length,
                itemBuilder: (context, index) {
                  FileSystemEntity file = fil.elementAt(index);
                  return GestureDetector(
                    onTap: () async {
                      if(file.path.contains("."))
                        {
                          if(file.path.endsWith(".mkv"))
                            {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => loader(file.path)));
                            }
                        }
                      else
                        {
                          getFiles(Directory(file.path));
                        }
                    },
                    child: Row(
                      children: [
                        Icon(
                          file.path.contains(".") ? Icons.file_copy : Icons.folder_open,
                          size: 50,
                        ),
                        Expanded(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0,0,0),
                              child: Text(file.path.substring(file.path.lastIndexOf("/") + 1), style: TextStyle(fontSize: 25), overflow: TextOverflow.fade, softWrap: false,),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.file_download),
      ),
    );
  }
}
