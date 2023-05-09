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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Poke Bola',
                    style: TextStyle(color: Colors.black, fontSize: 35),
                  ),
                  Image.asset(
                    "assets/poke.png",
                    width: double.tryParse("50"),
                  ),
                ],
              ),
              /* Theme.of(context).textTheme.titleLarge) */
              const SizedBox(
                width: 10,
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
                        const SizedBox(
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
                        backgroundColor:
                            const Color.fromARGB(255, 119, 221, 122),
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
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 253, 1, 1),
                                                fontSize: 20)),
                                        const Divider(),
                                        Text(
                                            "N°: ${widget.pokemons[index].num}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15)),
                                        Text(
                                            "Tipo: ${widget.pokemons[index].type}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15)),
                                        Text(
                                            "Peso: ${widget.pokemons[index].weight}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15)),
                                        Text(
                                            "Altura: ${widget.pokemons[index].height}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15)),
                                        Text(
                                            "Fraco Contra: ${widget.pokemons[index].weaknesses}",
                                            style: const TextStyle(
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
