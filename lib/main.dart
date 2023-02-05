import 'package:flutter/material.dart';

void main() {
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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Semestr Bal Hesabla'),
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
  String calculateRule = 'Əmsallı (0.6, 0.4) (BDU)';

  int execiseCount = 3;
  int laboratoryCount = 0;
  double laboratoryCountItem = 0;
  int colliquiumCount = 3;
  bool courseWork = false;

  int exerciseScore = 0;
  double laboratoryScore = 0;
  int colliquiumScore = 0;
  int freeWorkScore = 0;
  int courseWorkScore = 0;
  int freeCourseWorkCount = 1;
  String courseWorkText = "Sərbəst iş balı";

  int lessonHour = 15;
  int missedHour = 0;

  int counter = 0;

  String sex = 'Kişi';

  List<int> execiseItem = List<int>.generate(9, (index) => 0);
  List<int> freeCourseWorkItem = List<int>.generate(2, (index) => 0);
  List<int> colliquiumItem = List<int>.generate(3, (index) => 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 100.0,
            stretch: true,
            centerTitle: true,
            title: Text(
              'Imtahan Nəticəsi = $counter \n BAYIRA BLƏƏƏƏƏT',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                  boxShadow: const [
                    BoxShadow(color: Colors.black, spreadRadius: 1),
                  ],
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Tənzimlənmələr",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Hesab qaydası"),
                        DropdownButton<String>(
                          value: calculateRule,
                          onChanged: (newValue) {
                            setState(() {
                              calculateRule = newValue.toString();
                            });
                          },
                          items: <String>[
                            'Əmsallı (0.6, 0.4) (BDU)',
                            'Orta ədədin tapılması ilə'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Məşğələ dərslərinin sayı"),
                        DropdownButton<String>(
                          value: execiseCount.toString(),
                          onChanged: (newValue) {
                            setState(() {
                              execiseCount = int.parse(newValue.toString());
                            });
                          },
                          items: List.generate(9, (index) => index.toString())
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Laboratoriyaların sayı"),
                        DropdownButton<String>(
                          value: laboratoryCount.toString(),
                          onChanged: (newValue) {
                            setState(() {
                              laboratoryCount = int.parse(newValue.toString());
                            });
                          },
                          items: List.generate(11, (index) => index.toString())
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Kollikvium ballarının sayı"),
                        DropdownButton<String>(
                          value: colliquiumCount.toString(),
                          onChanged: (newValue) {
                            setState(() {
                              colliquiumCount = int.parse(newValue.toString());
                            });
                          },
                          items: List<String>.generate(2, (index) {
                            return (index + 2).toString();
                          }).map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Kurs işi"),
                        Switch(
                            value: courseWork,
                            onChanged: (value) {
                              setState(() {
                                courseWork = value;
                                courseWorkText = value
                                    ? 'Sərbəst/Kurs işi balları'
                                    : 'Sərbəst iş balı';
                                freeCourseWorkCount = value ? 2 : 1;
                              });
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: execiseCount != 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                        boxShadow: const [
                          BoxShadow(color: Colors.black, spreadRadius: 1),
                        ],
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              "Məşğələ balları",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Wrap(
                            spacing: 50.0,
                            children: List<Widget>.generate(
                              execiseCount,
                              (index) => DropdownButton<String>(
                                value: execiseItem[index].toString(),
                                onChanged: (newValue) {
                                  setState(() {
                                    execiseItem[index] =
                                        int.parse(newValue.toString());
                                  });
                                },
                                items: List.generate(
                                        11, (index) => index.toString())
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 10,
                  ),
          ),
          SliverToBoxAdapter(
            child: laboratoryCount != 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                        boxShadow: const [
                          BoxShadow(color: Colors.black, spreadRadius: 1),
                        ],
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              "Laboratoriya ballarının cəmi",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DropdownButton<String>(
                            value: laboratoryCountItem.toString(),
                            onChanged: (newValue) {
                              setState(() {
                                laboratoryCountItem =
                                    double.parse(newValue.toString());
                              });
                            },
                            items: List.generate(
                              (laboratoryCount * 2) + 1,
                              (index) => (index * 0.5).toString(),
                            ).map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          const Text(
                              textAlign: TextAlign.center,
                              "Laboratoriya balın \nTam - 1 bal \nNatamam - 0.5 bal \nolma halları var"),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 10,
                  ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                  boxShadow: const [
                    BoxShadow(color: Colors.black, spreadRadius: 1),
                  ],
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Kollikvium balları",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Wrap(
                      spacing: 30.0,
                      children: List<Widget>.generate(
                        colliquiumCount,
                        (index) => DropdownButton<String>(
                          value: colliquiumItem[index].toString(),
                          onChanged: (newValue) {
                            setState(() {
                              colliquiumItem[index] =
                                  int.parse(newValue.toString());
                            });
                          },
                          items: List.generate(11, (index) => index.toString())
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                  boxShadow: const [
                    BoxShadow(color: Colors.black, spreadRadius: 1),
                  ],
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        courseWorkText,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Wrap(
                      spacing: 30.0,
                      children: List<Widget>.generate(
                        freeCourseWorkCount,
                        (index) => DropdownButton<String>(
                          value: freeCourseWorkItem[index].toString(),
                          onChanged: (newValue) {
                            setState(() {
                              freeCourseWorkItem[index] =
                                  int.parse(newValue.toString());
                            });
                          },
                          items: List.generate(11, (index) => index.toString())
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                  boxShadow: const [
                    BoxShadow(color: Colors.black, spreadRadius: 1),
                  ],
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Qayıb/Dərs saatı",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Wrap(
                      spacing: 30.0,
                      children: [
                        DropdownButton<String>(
                          value: missedHour.toString(),
                          onChanged: (newValue) {
                            setState(() {
                              missedHour = int.parse(newValue.toString());
                            });
                          },
                          items: List.generate(
                                  lessonHour + 1, (index) => index.toString())
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        DropdownButton<String>(
                          value: lessonHour.toString(),
                          onChanged: (newValue) {
                            setState(() {
                              missedHour = 0;
                              lessonHour = int.parse(newValue.toString());
                            });
                          },
                          items: List.generate(
                                  8, (index) => ((index + 1) * 15).toString())
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverAppBar(
            pinned: true,
            expandedHeight: 50.0,
            stretch: true,
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    //Hesablama burada gedir
                    counter = 69;

                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                            title: const Text(
                                "Select one country or many countries"),
                            content: SingleChildScrollView(
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      DropdownButton<String>(
                                        value: sex,
                                        items: <String>['Kişi', 'Kadın']
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            sex = value ?? 'Kişi';
                                          });
                                        },
                                      ),
                                    ]),
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text("Yes"),
                                onPressed: () {
                                  Widget okButton = TextButton(
                                    child: const Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                  );
                                  String s = 'Get cinsivi gey';
                                  if (sex == 'Kişi') {
                                    s = 'Getdin Əsgərliyə';
                                  } else if (sex == 'Kadın') {
                                    s = 'Getdin Xalaoğluya';
                                  }

                                  AlertDialog alert = AlertDialog(
                                    title: const Text("Təbriklər"),
                                    content: Text(s),
                                    actions: [
                                      okButton,
                                    ],
                                  );

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        });
                      },
                    );
                  });
                },
                child: const Text("Hesabla"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
