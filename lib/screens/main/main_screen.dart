import 'package:flutter/material.dart';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;

import 'package:github_members_app/models/member.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Member> _members = [];

  final String dataUrl = "https://api.github.com/orgs/google/members";

  _loadMembers() async {
    http.Response response = await http.get(dataUrl);
    setState(() {
      final dynamic membersJSON = json.decode(response.body);
      for (dynamic memberJSON in membersJSON) {
        final Member member = Member(memberJSON["login"], memberJSON["avatar_url"]);
        _members.add(member);
      }
    });
  }

  Widget _buildRow(int i) {
    return ListTile(
      title: Text(
        "${_members[i].login}",
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18.0,
        ),
      ),
      leading: CircleAvatar(
          backgroundColor: Colors.green,
          backgroundImage: NetworkImage(_members[i].avatarUrl)),
    );
  }

  @override
  void initState() {
    super.initState();

    _loadMembers();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
          itemCount: _members.length * 2,
          itemBuilder: (BuildContext context, int position) {
            if (position.isOdd) return Divider();
            final index = position ~/ 2;
            return _buildRow(index);
          }),
    );
  }
}
