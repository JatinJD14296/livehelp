import 'package:flutter/material.dart';
import 'package:livehelp/common/widgets/appbar_widget.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
    },
    child:Scaffold(
      appBar: appbar(
        context,
        title: "Messages",
        leadingIcon:
             Icons.arrow_back_ios_new_sharp,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),),
    );
  }
}
