import 'package:flutter/material.dart';

import 'api.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //col/ Set background color to transparent
        //Color.fromARGB(255, 228, 135, 135),
        elevation: 0, // Set elevation to zero

        toolbarHeight: double.tryParse('165'),
        title: Container(
          decoration: const BoxDecoration(
              //borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),

              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Poke Bola',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              /* Theme.of(context).textTheme.titleLarge) */
              SizedBox(
                width: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Go!',
                    style: TextStyle(color: Color(0xFF2E2B2B), fontSize: 15),
                  ),
                  Image.asset(
                    "assets/poke.png",
                    width: double.tryParse("50"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<Dados>>(
        future: dados(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PokemonsList(pokemons: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PokemonsList extends StatefulWidget {
  const PokemonsList({Key? key, required this.pokemons}) : super(key: key);

  final List<Dados> pokemons;

  @override
  State<PokemonsList> createState() => _PokemonsListState();
}

class _PokemonsListState extends State<PokemonsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black,
              offset: Offset(1, 2.0),
              blurRadius: 5,
              spreadRadius: 2),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: widget.pokemons.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              padding: const EdgeInsets.all(2.0),
              margin: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 216, 214, 214),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: ListTile(
                title: Column(
                  children: [
                    Row(
                      children: [
                        Text(widget.pokemons[index].type.toString()),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${widget.pokemons[index].id}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Image.network("${widget.pokemons[index].img}", height: 100),
                    Text(
                      "${widget.pokemons[index].name}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(builder: (BuildContext context) {
                      return Scaffold(
                        backgroundColor: Color.fromARGB(255, 119, 221, 122),
                        appBar:
                            AppBar(title: const Text('Detalhes do Pokemon')),
                        body: Hero(
                          tag: 'Detalhes Pokemon',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        "${widget.pokemons[index].img}",
                                        height: 200,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    width: 407,
                                    height: 400,
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(1, 2.0),
                                            blurRadius: 5,
                                            spreadRadius: 2),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Nome: ${widget.pokemons[index].name}",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 253, 1, 1),
                                                fontSize: 20)),
                                        Divider(),
                                        Text(
                                            "N°: ${widget.pokemons[index].num}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15)),
                                        Text(
                                            "Tipo: ${widget.pokemons[index].type}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15)),
                                        Text(
                                            "Peso: ${widget.pokemons[index].weight}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15)),
                                        Text(
                                            "Altura: ${widget.pokemons[index].height}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15)),
                                        Text(
                                            "Fraco Contra: ${widget.pokemons[index].weaknesses}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}



//import 'package:flutter/material.dart';

// import 'api.dart';

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: FutureBuilder<List<Dados>>(
//         future: dados(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Center(
//               child: Text('An error has occurred!'),
//             );
//           } else if (snapshot.hasData) {
//             return PokemonsList(pokemons: snapshot.data!);
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class PokemonsList extends StatelessWidget {
//   const PokemonsList({Key? key, required this.pokemons}) : super(key: key);

//   final List<Dados> pokemons;

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//       ),
//       itemCount: pokemons.length,
//       itemBuilder: (context, index) {
//         return Container(
//           child: Container(
//             child: ListTile(
//               title: Image.network("${pokemons[index].img}", height: 200),
//               subtitle: Text(
//                 "${pokemons[index].name}",
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 17.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute<Widget>(builder: (BuildContext context) {
//                     return Scaffold(
//                       appBar: AppBar(title: const Text('Detalhes do Pokemon')),
//                       body: Hero(
//                         tag: 'Detalhes Pokemon',
//                         child: Row(
//                           children: [
//                             Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Image.network(
//                                       "${pokemons[index].img}",
//                                       height: 200,
//                                     ),
//                                   ],
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 8.0),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                             "Nome do Pokemon: ${pokemons[index].name}"),
//                                         Text("N°: ${pokemons[index].num}"),
//                                         Text("Tipo: ${pokemons[index].type}"),
//                                         Text("Peso: ${pokemons[index].weight}"),
//                                         Text(
//                                             "Altura: ${pokemons[index].height}"),
//                                         Text(
//                                             "Fraco Contra: ${pokemons[index].weaknesses}"),
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }



// // import 'package:flutter/material.dart';

// // import 'api.dart';

// // class MyHomePage extends StatelessWidget {
// //   const MyHomePage({Key? key, required this.title}) : super(key: key);

// //   final String title;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(title),
// //       ),
// //       body: FutureBuilder<List<Dados>>(
// //         future: dados(),
// //         builder: (context, snapshot) {
// //           if (snapshot.hasError) {
// //             return const Center(
// //               child: Text('An error has occurred!'),
// //             );
// //           } else if (snapshot.hasData) {
// //             return PokemonsList(pokemons: snapshot.data!);
// //           } else {
// //             return const Center(
// //               child: CircularProgressIndicator(),
// //             );
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }

// // class PokemonsList extends StatelessWidget {
// //   const PokemonsList({Key? key, required this.pokemons}) : super(key: key);

// //   final List<Dados> pokemons;

// //   @override
// //   Widget build(BuildContext context) {
// //     return GridView.builder(
// //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //           crossAxisCount: 2,
// //         ),
// //         itemCount: pokemons.length,
// //         itemBuilder: (context, index) {
// //           return Image.network(
// //             "${pokemons[index].img}",
// //           );
// //         });
// //   }
// // }

