import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_riverpod/providers/pokemon_data_provider.dart';

class PokemonStatsCard extends ConsumerWidget{
final String pokemonURL;

PokemonStatsCard({

  super.key,
  required this.pokemonURL,
});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon =ref.watch(pokemonDataProvider(pokemonURL,));
    return AlertDialog(
      title: Text("Statistics"),
      content: pokemon.when(data: (data){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children:
            data?.stats?.map((s) {
              return Text("${s.stat?.name?.toUpperCase()}: ${s.baseStat}");

            },).toList()??
         [] ,
        );
      }, error: (error,stackTrace){
        return Text(error.toString());
      }, loading:(){

        return CircularProgressIndicator(
          color: Colors.white,
        );
      })
    );
  }

}