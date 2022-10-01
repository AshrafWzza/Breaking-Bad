part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  List<Character>? characters;
  CharactersLoaded(this.characters);
}

class QuotesLoaded extends CharactersState {
  List<Quote>? quotes;
  QuotesLoaded(this.quotes);
}
