import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/models/movie_detail.dart';
import 'package:movies/movie_details/movie_details_bloc.dart';

class MovieDetailsPage extends StatefulWidget {
  final MovieDetailsBloc _bloc;

  const MovieDetailsPage({Key key, MovieDetailsBloc bloc})
      : _bloc = bloc,
        super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState(_bloc);
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final MovieDetailsBloc _bloc;

  _MovieDetailsPageState(this._bloc);

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<MovieDetail>(
          stream: _bloc.details,
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
