import 'package:bloc/bloc.dart';
import 'package:flutter_breaking/data/models/characters.dart';
import 'package:flutter_breaking/data/models/quote.dart';
import 'package:flutter_breaking/data/repository/characters_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

//receive data from Repository
class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character>? characters;
  List<Quote>? quotes;
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());
  // Future<List<Character>> getAllCharacters() async {
  List<Character>? getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  List<Quote>? getQuotes(String charName) {
    charactersRepository.getCharacterQuotes(charName).then((quotes) {
      emit(QuotesLoaded(quotes));
      this.quotes = quotes;
    });
    return quotes;
  }
}
