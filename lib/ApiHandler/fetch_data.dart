import 'dart:convert';
import 'package:assignment/Model/tournament.dart';
import 'package:http/http.dart' as http;

Future<List<Tournament>> fetchData(int limit, String cursor) async {
  Uri uri = Uri.parse(
      'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=$limit&status=all&cursor=$cursor');
  String host = uri.host;
  String path = uri.path;
  Map<String, String> queryParameters = uri.queryParameters;
  var response = await http.get(Uri.https(host, path, queryParameters));
  var jsonData = jsonDecode(response.body);
  var tournaments = jsonData['data']['tournaments'];
  String cursorString = jsonData['data']['cursor'];

  List<Tournament> tournamentsList = [];
  for (var tournament in tournaments) {
    String name = tournament['name'] ?? '';
    String gameName = tournament['game_name'] ?? '';
    String coverUrl = tournament['cover_url'] ?? '';

    Tournament objTournament =
        new Tournament(name, coverUrl, gameName, cursorString);
    tournamentsList.add(objTournament);
  }
  return tournamentsList;
}
