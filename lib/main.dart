import 'package:flutter/material.dart';
// import 'package:uas_mobile/models/mahasiswa.dart';
import 'package:uas_mobile/service/service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'API (Farah 2141762091)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int mhsCount;
  late List listMhs;
  MahasiswaService service = MahasiswaService();

  final TextEditingController nimController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController kelasController = TextEditingController();

  Future getData() async {
    listMhs = [];
    listMhs = await service.getData();
    setState(() {
      mhsCount = listMhs.length;
      listMhs = listMhs;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Container(
        width: 400,
        margin: const EdgeInsets.all(10),
        child: Column(children: [
          TextFormField(
            controller: nimController,
            decoration: const InputDecoration(labelText: "NIM"),
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            controller: namaController,
            decoration: const InputDecoration(labelText: "Nama"),
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            controller: kelasController,
            decoration: const InputDecoration(labelText: "Kelas"),
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(
            height: 20,
          ),
          FilledButton(
              onPressed: () {
                service.addData(
                    nimController.value.text,
                    namaController.value.text.toUpperCase(),
                    kelasController.value.text.toUpperCase());
                nimController.clear();
                namaController.clear();
                kelasController.clear();
                listMhs.clear();
                getData();
              },
              child: const Text("Submit")),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Data Mahasiswa",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: listMhs.isEmpty
                ? const Text("Tidak ada data")
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 325,
                              child: ListTile(
                                title: Text(
                                  listMhs[index].nama,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                    "${listMhs[index].nim} | ${listMhs[index].kelas}"),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  service
                                      .deleteData(listMhs[index].id)
                                      .whenComplete(() {
                                    setState(() {
                                      listMhs.removeWhere((element) =>
                                          element.id == listMhs[index].id);
                                    });
                                  });
                                },
                                icon: const Icon(Icons.delete_rounded))
                          ],
                        ),
                      );
                    },
                    itemCount: listMhs.length,
                  ),
          ),
        ]),
      )),
    );
  }
}
