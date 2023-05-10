import 'package:flutter/material.dart';
import '../api/api.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();

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
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'PokeBola',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontStyle: FontStyle.italic),
                    ),
                    Image.asset(
                      "assets/poke.png",
                      width: double.tryParse("50"),
                    ),
                  ],
                ),
                /* Theme.of(context).textTheme.titleLarge) */
                const SizedBox(
                  width: 50,
                ),
                TextField(
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                      hintText: '🔎 Pesquisa..',
                      hintStyle: TextStyle(color: Colors.yellow)),
                  controller: controller,
                  onChanged: (value) => setState(() {}),
                  style: const TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Dados>>(
              future: dados(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error has occurred!'),
                  );
                } else if (snapshot.hasData) {
                  return PokemonsList(
                      pokemons: snapshot.data!
                          .where((pokemon) => pokemon.name!
                              .toLowerCase()
                              .contains(controller.text.toLowerCase()))
                          .toList());
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PokemonsList extends StatelessWidget {
  const PokemonsList({Key? key, required this.pokemons}) : super(key: key);

  final List<Dados> pokemons;

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
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              padding: const EdgeInsets.all(6.0),
              margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  color: pokemons[index].type == "Grass"
                      ? Colors.greenAccent
                      : pokemons[index].type == "Fire"
                          ? Colors.redAccent
                          : pokemons[index].type == "Water"
                              ? Colors.blue
                              : pokemons[index].type == "Poison"
                                  ? Colors.deepPurpleAccent
                                  : pokemons[index].type == "Electric"
                                      ? Colors.amber
                                      : pokemons[index].type == "Rock"
                                          ? Colors.grey
                                          : pokemons[index].type == "Ground"
                                              ? Colors.brown
                                              : pokemons[index].type ==
                                                      "Psychic"
                                                  ? Colors.indigo
                                                  : pokemons[index].type ==
                                                          "Fighting"
                                                      ? Colors.orange
                                                      : pokemons[index].type ==
                                                              "Bug"
                                                          ? Colors
                                                              .lightGreenAccent
                                                          : pokemons[index]
                                                                      .type ==
                                                                  "Ghost"
                                                              ? Colors
                                                                  .deepPurple
                                                              : pokemons[index]
                                                                          .type ==
                                                                      "Normal"
                                                                  ? Colors
                                                                      .black26
                                                                  : Colors.pink,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: ListTile(
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(pokemons[index].type.toString()),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "#${pokemons[index].id}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Image.network("${pokemons[index].img}", height: 100),
                    Text(
                      "${pokemons[index].name}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(builder: (BuildContext context) {
                      return Scaffold(
                        appBar:
                            AppBar(title: const Text('Detalhes do Pokemon')),
                        body: Hero(
                          tag: 'Detalhes Pokemon',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: pokemons[index].type == "Grass"
                                      ? Colors.greenAccent
                                      : pokemons[index].type == "Fire"
                                          ? Colors.redAccent
                                          : pokemons[index].type == "Water"
                                              ? Colors.blue
                                              : pokemons[index].type == "Poison"
                                                  ? Colors.deepPurpleAccent
                                                  : pokemons[index].type ==
                                                          "Electric"
                                                      ? Colors.amber
                                                      : pokemons[index].type ==
                                                              "Rock"
                                                          ? Colors.grey
                                                          : pokemons[index]
                                                                      .type ==
                                                                  "Ground"
                                                              ? Colors.brown
                                                              : pokemons[index]
                                                                          .type ==
                                                                      "Psychic"
                                                                  ? Colors
                                                                      .indigo
                                                                  : pokemons[index]
                                                                              .type ==
                                                                          "Fighting"
                                                                      ? Colors
                                                                          .orange
                                                                      : pokemons[index].type ==
                                                                              "Bug"
                                                                          ? Colors
                                                                              .lightGreenAccent
                                                                          : pokemons[index].type == "Ghost"
                                                                              ? Colors.deepPurple
                                                                              : pokemons[index].type == "Normal"
                                                                                  ? Colors.black26
                                                                                  : Colors.pink,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.network(
                                          "${pokemons[index].img}",
                                          height: 200,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      width: 407,
                                      height: 400,
                                      decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(1, 2.0),
                                              blurRadius: 5,
                                              spreadRadius: 2),
                                        ],
                                        color: Color(0xFFE4DFDF),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          topLeft: Radius.circular(30),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Nome: ${pokemons[index].name}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20)),
                                          const Divider(),
                                          Text("N°: ${pokemons[index].num}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15)),
                                          const Divider(),
                                          Text("Tipo: ${pokemons[index].type}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15)),
                                          const Divider(),
                                          Text(
                                              "Peso: ${pokemons[index].weight}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15)),
                                          const Divider(),
                                          Text(
                                              "Altura: ${pokemons[index].height}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15)),
                                          const Divider(),
                                          Text(
                                              "Fraco Contra: ${pokemons[index].weaknesses}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
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
