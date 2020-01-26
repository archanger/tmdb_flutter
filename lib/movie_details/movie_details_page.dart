import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/helpers/bloc_provider.dart';
import 'package:movies/models/movie_detail.dart';
import 'package:movies/movie_details/genre_widget.dart';
import 'package:movies/movie_details/movie_details_bloc.dart';
import 'package:movies/movies_list/movies_service.dart';
import 'package:movies/providers/configuration_provider.dart';

class MovieDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MovieDetailsBloc>(context);
    bloc.adjustTo(size: MediaQuery.of(context).size.width.toInt());

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
            return _page(context, snapshot.data);
          },
        ),
      ),
    );
  }

  Widget _page(BuildContext context, MovieDetail data) {
    return Stack(
      children: [
        _poster(data.poster),
        _content(context, data),
        // _backButton(context),
      ],
    );
  }

  Widget _content(BuildContext context, MovieDetail details) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _backButton(context),
        _scrollableContent(details: details),
      ],
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

  Widget _scrollableContent({MovieDetail details}) {
    return Expanded(
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.only(top: 220),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight - 220,
            ),
            child: Material(
              elevation: 16,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _genres(context, details.genres),
                    _title(context, details.title),
                    _storyLine(context, details.storyLine),
                    // Expanded(child: Container()),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _title(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        title,
        key: Key('title'),
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }

  Widget _storyLine(BuildContext context, String story) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Story',
          style: Theme.of(context).textTheme.subhead,
        ),
        SizedBox(height: 16),
        Text(
          story,
          key: Key('story_line'),
          style: Theme.of(context).textTheme.body1,
        ),
      ],
    );
  }

  Widget _poster(String url) {
    return Container(
      height: 350,
      foregroundDecoration: BoxDecoration(
        color: Colors.black26,
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(url),
        fit: BoxFit.fitWidth,
      )),
    );
  }

  Widget _genres(BuildContext context, List<String> genres) {
    return Row(
      children: genres
          .map((g) => Genre(
                text: g,
              ))
          .expand((item) sync* {
            yield const SizedBox(width: 8);
            yield item;
          })
          .skip(1)
          .toList(),
    );
  }
}

class MovieDetailsPageFactory {
  Widget movieDetailsPage({@required int movieId}) {
    return BlocProvider(
      bloc: MovieDetailsBloc(
        id: movieId,
        service: MoviesService(),
        config: globalConfigProvider,
      ),
      child: MovieDetailsPage(),
    );
  }
}
