import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/helpers/bloc_provider.dart';
import 'package:movies/models/movie_credit.dart';
import 'package:movies/models/movie_detail.dart';
import 'package:movies/movie_details/movie_details_bloc.dart';
import 'package:movies/movies_list/movies_service.dart';
import 'package:movies/providers/configuration_provider.dart';

class MovieDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MovieDetailsBloc>(context);
    bloc.adjustTo(size: MediaQuery.of(context).size.width.toInt());

    return Scaffold(
      body: StreamBuilder<MovieDetail>(
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
    );
  }

  Widget _page(BuildContext context, MovieDetail data) {
    return Stack(
      children: [
        _backdrop(data.backdrop),
        _content(context, data),
      ],
    );
  }

  Widget _content(BuildContext context, MovieDetail details) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SafeArea(
          bottom: false,
          child: _backButton(context),
        ),
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
      child: DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.8,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
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
                  _title(context, details.title),
                  SizedBox(height: 12),
                  _genres(context, details.genres),
                  if (details.runtime != 0) ...[
                    SizedBox(height: 12),
                    _runtime(context, details.runtime),
                  ],
                  SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: ClampingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _storyLine(context, details.storyLine),
                          SizedBox(height: 24),
                          _cast(context, details.credits),
                          // Expanded(child: Container()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget _title(BuildContext context, String title) {
    return Text(
      title,
      key: Key('title'),
      style: Theme.of(context).textTheme.display1,
    );
  }

  Widget _storyLine(BuildContext context, String story) {
    return SafeArea(
      top: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Story',
            style: Theme.of(context).textTheme.body2,
          ),
          SizedBox(height: 16),
          Text(
            story,
            key: Key('story_line'),
            style: Theme.of(context).textTheme.title,
          ),
        ],
      ),
    );
  }

  Widget _backdrop(String url) {
    return Container(
      key: Key('backdrop'),
      height: 300,
      foregroundDecoration: BoxDecoration(
        color: Colors.black26,
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(url),
        fit: BoxFit.cover,
      )),
    );
  }

  Widget _genres(BuildContext context, List<String> genres) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: genres.map((g) {
        return Text(
          g,
          style: Theme.of(context).textTheme.body2,
        );
      }).toList(),
    );
  }

  Widget _runtime(BuildContext context, int runtime) {
    return Text(
      'Run Time: ${_format(runtime)}',
      key: Key('runtime'),
      style: Theme.of(context).textTheme.caption,
    );
  }

  String _format(int runtime) {
    var duration = Duration(minutes: runtime);
    var result = "";
    if (duration.inHours != 0) {
      result += "${duration.inHours} h ";
    }
    result += "${duration.inMinutes.remainder(60)} min";
    return result;
  }

  Widget _cast(BuildContext context, List<MovieCredit> credits) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cast',
          style: Theme.of(context).textTheme.body2,
        ),
        SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 24,
            children: credits.map((c) => Credit(credit: c)).toList(),
          ),
        ),
      ],
    );
  }
}

class Credit extends StatelessWidget {
  final MovieCredit credit;

  const Credit({Key key, this.credit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: Column(
        children: [
          Text(
            credit.character,
            textAlign: TextAlign.center,
          ),
          if (credit.profile != null) ...[
            SizedBox(
              height: 8,
            ),
            Container(
              height: 80,
              width: 72,
              child: Image.network(credit.profile),
            ),
          ],
          SizedBox(height: 8),
          Text(
            credit.name,
            textAlign: TextAlign.center,
          ),
        ],
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
        config: globalConfigProvider,
      ),
      child: MovieDetailsPage(),
    );
  }
}
