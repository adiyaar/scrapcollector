import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'message.dart';


class NotificationPage extends StatelessWidget {
  final String appTitle = 'Firebase messaging';
  @override
  Widget build(BuildContext context) {
    return MainPage(appTitle: "Hi");
  }

}

class MainPage extends StatelessWidget {
  final String appTitle;

  const MainPage({@required this.appTitle});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Notifications"),
      backgroundColor: Colors.red,
    ),
    body: MessagingWidget(),
  );
}


class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  @override
  void initState() {


    super.initState();


    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        messages.add(Message(title: '${message}', body: '${message}'));
      }
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  @override
  Widget build(BuildContext context) => ListView(children: messages.map(buildMessage).toList(),);

  Widget buildMessage(Message message) => ListTile(
    title: Text(message.title),
    subtitle: Text(message.body),
  );
}


