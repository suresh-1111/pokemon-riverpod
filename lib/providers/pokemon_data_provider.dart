import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_riverpod/services/database_service.dart';
import 'package:pokemon_riverpod/services/http_service.dart';

import '../models/pokemon.dart';

final pokemonDataProvider =
FutureProvider.family<Pokemon?,String>((ref,url) async {

  HTTPService _httpService =GetIt.instance.get<HTTPService>();
  Response? res= await _httpService.get(url);
  if(res != null && res.data !=null ){
    return Pokemon.fromJson(
      res.data!,
    );
  }
  return null;
} );

final favoritePokemonsProvider =StateNotifierProvider<FavoritePokemonsProvider,List<String>>((ref){
  return FavoritePokemonsProvider(
    [],
  );
});


class FavoritePokemonsProvider extends StateNotifier <List<String>>{
  final DatabaseService _databaseService =GetIt.instance.get<DatabaseService>();


String FAVORITE_POKEMON_LIST_KEY ="FAVORITE_POKEMON_LIST_KEY";
  FavoritePokemonsProvider(
      super._state,
      ){
    _setup(

    );
  }
  Future<void> _setup() async{
    List<String>? result =await _databaseService.getList(FAVORITE_POKEMON_LIST_KEY,);
state=result ?? [];
  }

  void addFavoritePokemon(String url){
    state =[ ...state,url];
    _databaseService.saveList(FAVORITE_POKEMON_LIST_KEY, state);
  }
  void removeFavoritePokemon(String url){
    state=state.where((e) => e != url).toList();
    _databaseService.saveList(FAVORITE_POKEMON_LIST_KEY, state);
  }

}








// class FavoritePokemonsProvider extends StateNotifier<List<String>> {
//   FavoritePokemonsProvider() : super([]);
//
//   void addToFavorites(String pokemonId) {
//     state = [...state, pokemonId];
//     notifyListeners();
//   }
//
//   void removeFromFavorites(String pokemonId) {
//     state = state.where((id) => id != pokemonId).toList();
//     notifyListeners();
//   }

// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get_it/get_it.dart';
// import 'package:pokemon_riverpod/services/http_service.dart';
//
// import '../models/pokemon.dart';
//
// final pokemonDataProvider = FutureProvider.family<Pokemon?, String>((ref, url) async {
//   HTTPService _httpService = GetIt.instance.get<HTTPService>();
//   Response? res = await _httpService.get(url);
//   if (res != null && res.data != null) {
//     return Pokemon.fromJson(
//       res.data!,
//     );
//   }
//   return null;
// });
//
// final favoritePokemonsProvider = StateNotifierProvider<FavoritePokemonsProvider, List<String>>((ref) {
//   return FavoritePokemonsProvider();
// });
//
//
//
//   Future<void> _setup() async {
//     // Perform any necessary setup tasks
//   }
// }