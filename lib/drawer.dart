import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'conversation_provider.dart';
import 'models.dart';
import 'secrets.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Provider.of<ConversationProvider>(context, listen: false)
                      .addEmptyConversation('');
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(color: Color(Colors.grey[300]?.value ?? 0)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    // left align
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.add, color: Colors.grey[800], size: 20.0),
                      const SizedBox(width: 15.0),
                      const Text(
                        'New Chat',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'din-regular',
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<ConversationProvider>(
                builder: (context, conversationProvider, child) {
                  return ListView.builder(
                    itemCount: conversationProvider.conversations.length,
                    itemBuilder: (BuildContext context, int index) {
                      Conversation conversation =
                          conversationProvider.conversations[index];
                      return Dismissible(
                        key: UniqueKey(),
                        child: GestureDetector(
                          onTap: () {
                            conversationProvider.currentConversationIndex =
                                index;
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: conversationProvider
                                          .currentConversationIndex ==
                                      index
                                  ? const Color(0xff55bb8e)
                                  : Colors.white,
                              // border: Border.all(color: Color(Colors.grey[200]?.value ?? 0)),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // conversation icon
                                Icon(
                                  Icons.person,
                                  color: conversationProvider
                                              .currentConversationIndex ==
                                          index
                                      ? Colors.white
                                      : Colors.grey[700],
                                  size: 20.0,
                                ),
                                const SizedBox(width: 15.0),
                                Text(
                                  conversation.title,
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    color: conversationProvider
                                                .currentConversationIndex ==
                                            index
                                        ? Colors.white
                                        : Colors.grey[700],
                                    fontFamily: 'din-regular',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // add a setting button at the end of the drawer
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  showRenameDialog(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.grey[700], size: 20.0),
                    const SizedBox(width: 15.0),
                    Text(
                      'API Setting',
                      style: TextStyle(
                        fontFamily: 'din-regular',
                        color: Colors.grey[700],
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  showProxyDialog(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.grey[700], size: 20.0),
                    const SizedBox(width: 15.0),
                    Text(
                      'Proxy Setting',
                      style: TextStyle(
                        fontFamily: 'din-regular',
                        color: Colors.grey[700],
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 50,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}
