import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/Customer/message.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  List<Message> messages = [];

  void token() {
    _fcm.getToken().then((token) => print(token));
  }

  void notification() async {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () async {
                  messages.add(Message(
                      title: message['notification']['title'],
                      body: message['notification']['body']));

                  print(messages);
                  // Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () async {
                  messages.add(Message(
                      title: message['notification']['title'],
                      body: message['notification']['body']));

                  print(messages);
                  // Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
        messages.add(Message(
            title: message['notification']['title'],
            body: message['notification']['body']));
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () async {
                  messages.add(Message(
                      title: message['notification']['title'],
                      body: message['notification']['body']));

                  print(messages);
                  // Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );

        messages.add(Message(
            title: message['notification']['title'],
            body: message['notification']['body']));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    token();
    notification();
  }

  @override
  Widget build(BuildContext context) {
    notification();
    return Scaffold(
        appBar: AppBar(
          title: Text("Notification"),
        ),
        body: MessagingWidget());
  }
}

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final List<Message> messages = [];

  void reg() async {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        messages.add(Message(
            title: message['notification']['title'],
            body: message['notification']['body']));
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );
  }

  @override
  void initState() {
    super.initState();

    reg();
  }

  @override
  Widget build(BuildContext context) {
    reg();
    return ListView(
      children: messages.map(buildMessage).toList(),
    );
  }

  Widget buildMessage(Message message) => ListTile(
        title: Text(message.title),
        subtitle: Text(message.body),
      );
}
