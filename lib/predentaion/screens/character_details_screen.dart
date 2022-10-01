import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breaking/constants/my_colors.dart';

import '../../data/models/characters.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo('job : ', character.jobs.join(' / ')),
                    buildDivider(300),
                    characterInfo(
                        'Appeared in : ', character.categoryForTwoSeries),
                    buildDivider(300),
                    characterInfo('job : ', character.jobs.join(' / ')),
                    buildDivider(250),
                    characterInfo('Seasons : ',
                        character.appearanceOfSeasons.join(' / ')),
                    buildDivider(280),
                    characterInfo('Status : ', character.statusIfDeadOrAlive),
                    buildDivider(280),
                    character.betterCallSaulAppearance.isEmpty
                        ? Container()
                        : characterInfo('Better Call Sul Seasons : ',
                            character.betterCallSaulAppearance.join(' / ')),
                    character.betterCallSaulAppearance.isEmpty
                        ? Container()
                        : buildDivider(150),
                    const SizedBox(height: 20),
                    buildBlocBuilderQuote(context),
                  ],
                ),
              ),
              const SizedBox(height: 500),
            ]),
          )
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name,
          style: const TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
              text: title,
              style: const TextStyle(
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          TextSpan(
              text: value,
              style: const TextStyle(color: MyColors.myWhite, fontSize: 16)),
        ]));
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  Widget buildBlocBuilderQuote(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is QuotesLoaded) {
          return displayRandomQuoteOrEmptySpace(state);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          style: const TextStyle(
              fontSize: 20,
              color: MyColors.myWhite,
              shadows: [
                Shadow(
                    blurRadius: 7,
                    color: MyColors.myYellow,
                    offset: Offset(0, 0))
              ]),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote)
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
