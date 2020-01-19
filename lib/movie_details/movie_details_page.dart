import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/helpers/bloc_provider.dart';
import 'package:movies/models/movie_detail.dart';
import 'package:movies/movie_details/movie_details_bloc.dart';
import 'package:movies/movies_list/movies_service.dart';

class MovieDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MovieDetailsBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<MovieDetail>(
          stream: bloc.details,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Stack(
              children: [
                _content(context, snapshot.data),
                _backButton(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: IconButton(
        icon: SvgPicture.asset('assets/ic_arrow_back.svg'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _content(BuildContext context, MovieDetail details) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Placeholder(
            fallbackHeight: 224,
          ),
          _title(details.title),
          _storyLine(context, details.storyLine),
        ],
      ),
    );
  }

  Widget _title(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 96,
            height: 168,
            child: Placeholder(key: Key('poster_small')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16.0),
            child: Container(
              child: Row(
                children: <Widget>[
                  Text(
                    title,
                    key: Key('title'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _storyLine(BuildContext context, String story) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
      child: Text(
        story,
        key: Key('story_line'),
      ),
    );
  }
}

class MovieDetailsPageFactory {
  Widget movieDetailsPage({@required int movieId}) {
    return BlocProvider(
      bloc: MovieDetailsBloc(
        id: movieId,
        service: MoviesService(),
      ),
      child: MovieDetailsPage(),
    );
  }
}
