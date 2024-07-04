import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_riverpod/models/pokemon.dart';
import 'package:pokemon_riverpod/providers/pokemon_data_provider.dart';
import 'package:pokemon_riverpod/widgets/pokemon_stats_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonListTile extends ConsumerWidget {
  final String pokemonURL;

  PokemonListTile({required this.pokemonURL});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final favoritePokemonsNotifier = ref.watch(favoritePokemonsProvider.notifier);
    final favoritePokemons = ref.watch(favoritePokemonsProvider);
    final pokemon = ref.watch(pokemonDataProvider(pokemonURL));

    return pokemon.when(
      data: (data) {
        return _tile(context, false, data, favoritePokemons, favoritePokemonsNotifier);
      },
      error: (error, stackTrace) {
        return Text("Error: $error");
      },
      loading: () {
        return _tile(context, true, null, favoritePokemons, favoritePokemonsNotifier);
      },
    );
  }

  Widget _tile(
      BuildContext context,
      bool isLoading,
      Pokemon? pokemon,
      List<String> favoritePokemons,
      FavoritePokemonsProvider favoritePokemonsNotifier,
      ) {
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap:() {
      if(!isLoading){
      showDialog(context: context, builder: (_) {
      return PokemonStatsCard(
      pokemonURL:pokemonURL,
      );
      });
      }
        },
        child: ListTile(
          leading: pokemon != null
              ? CircleAvatar(
            backgroundImage: NetworkImage(pokemon.sprites!.frontDefault!),
          )
              : CircleAvatar(),
          title: Text(pokemon != null
              ? pokemon.name!.toUpperCase()
              : "Currently loading name for pokemon"),
          subtitle: Text("Has ${pokemon?.moves?.length.toString() ?? 0} moves "),
          trailing: IconButton(
            onPressed: () {
              if (favoritePokemons.contains(pokemonURL)) {
                favoritePokemonsNotifier.removeFavoritePokemon(pokemonURL);
              } else {
                favoritePokemonsNotifier.addFavoritePokemon(pokemonURL);
              }
            },
            icon: Icon(
              favoritePokemons.contains(pokemonURL)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: favoritePokemons.contains(pokemonURL)
                  ? Colors.red
                  : Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
