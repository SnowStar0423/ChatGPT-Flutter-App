import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'conversation_provider.dart';

void showProxyDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String newProxy = 'your proxy';
      return AlertDialog(
        title: const Text('proxy Setting'),
        content: TextField(
          // display the current name of the conversation
          decoration: InputDecoration(
            hintText: Provider.of<ConversationProvider>(context).yourProxy,
          ),
          onChanged: (value) {
            newProxy = value;
          },
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text(
              'Save',
              style: TextStyle(
                color: Color(0xff55bb8e),
              ),
            ),
            onPressed: () {
              if (newProxy == '') {
                Navigator.pop(context);
                return;
              }
              Provider.of<ConversationProvider>(context, listen: false).yourProxy = newProxy;
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}


void showRenameDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newName = 'YOUR_API_KEY';
        return AlertDialog(
          title: const Text('API Setting'),
          content: TextField(
            // display the current name of the conversation
            decoration: InputDecoration(
              hintText: Provider.of<ConversationProvider>(context).yourApiKey,
            ),
            onChanged: (value) {
              newName = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Color(0xff55bb8e),
                ),
              ),
              onPressed: () {
                if (newName == '') {
                  Navigator.pop(context);
                  return;
                }
                Provider.of<ConversationProvider>(context, listen: false).yourApiKey = newName;
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }