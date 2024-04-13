import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_mall_flutter/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dialogflow_grpc/dialogflow_grpc.dart';
import 'package:dialogflow_grpc/generated/google/cloud/dialogflow/v2beta1/session.pb.dart';


class UserChatPage extends StatefulWidget {
  const UserChatPage({Key? key}) : super(key: key);

  @override
  State<UserChatPage> createState() => _UserChatPage();
}

class _UserChatPage extends State<UserChatPage> {
  // message text controller
  final TextEditingController _textController = TextEditingController();

  // list of messages that will be displayed on the screen
  final List<ChatMessage> _messages = <ChatMessage>[];

  late DialogflowGrpcV2Beta1 dialogflow;

  @override
  void initState() {
    super.initState();
    initPlugin();
  }

  Future<void> initPlugin() async {

    // requiried for setting up dialogflow
    final serviceAccount = ServiceAccount.fromString(
      await rootBundle.loadString(
        'assets/cred.json',
      ),
    );

    // dialogflow setup
    dialogflow = DialogflowGrpcV2Beta1.viaServiceAccount(serviceAccount);
    setState(() {});
  }


  void handleSubmitted(text) async {
    _textController.clear();

    ChatMessage message = ChatMessage(
      text: text,
      name: "You",
      type: true,
    );

    setState(() {
      _messages.insert(0, message);
    });

    // callling dialogflow api
    DetectIntentResponse data = await dialogflow.detectIntent(text, 'en-US');

    // getting meaningful response text
    String fulfillmentText = data.queryResult.fulfillmentText;
    if (fulfillmentText.isNotEmpty) {
      ChatMessage botMessage = ChatMessage(
        text: fulfillmentText,
        name: "Assistant",
        type: false,
      );

      setState(() {
        _messages.insert(0, botMessage);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.w,
        backgroundColor: Colors.blue.shade400,
        title: const  Text(
          "Online Assistant",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding:  EdgeInsets.all(8.w),
              reverse: true,
              itemBuilder: (ctx, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Container(
            padding:  EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(10),
            ),
            margin:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: handleSubmitted,
                    decoration: const InputDecoration.collapsed(
                        hintText: "Send a message"),
                  ),
                ),
                Container(
                  margin:  EdgeInsets.symmetric(horizontal: 4.w),
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => handleSubmitted(_textController.text),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}