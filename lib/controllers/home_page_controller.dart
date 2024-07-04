import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_riverpod/models/page_data.dart';
import 'package:pokemon_riverpod/models/pokemon.dart';
import 'package:pokemon_riverpod/services/http_service.dart';

class HomePageController extends StateNotifier<HomePageData>{
  final GetIt _getIt = GetIt.instance;
  late HTTPService _httpService;
HomePageController(
    super._state,){
    _httpService = _getIt.get<HTTPService>();
    _setUp();
}

Future<void> _setUp() async{
  loadData();

}

Future<void> loadData() async{
  if(state.data ==null){
    Response? res = await _httpService.get(
      "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0",);
    if(res!= null && res.data !=null ){
      PokemonListData data = PokemonListData.fromJson(res.data);
      state=state.copyWith(data: data);
    }
  }
  else {
    if(state.data?.next !=null){
      Response? res =await _httpService.get(
        state.data!.next!
      );
      if(res != null && res.data != null){
        PokemonListData data = PokemonListData.fromJson(res.data!);
        state=state.copyWith(
            data:data.copyWith(
              results:[
          ...?state.data?.results,
          ...?data.results,

        ],
        ),
        );
      }
    }

  }
  }
}
