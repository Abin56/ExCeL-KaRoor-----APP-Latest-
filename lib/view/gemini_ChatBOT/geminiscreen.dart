import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:excel_karoor/view/gemini_ChatBOT/chat_text_form)_field.dart';
import 'package:excel_karoor/view/gemini_ChatBOT/message_widget.dart';
import 'package:excel_karoor/view/gemini_ChatBOT/util/app_const.dart';

class GeminiAIBOT extends StatefulWidget {
  const GeminiAIBOT({super.key});

  @override
  State<GeminiAIBOT> createState() => _GeminiAIBOTState();
}

class _GeminiAIBOTState extends State<GeminiAIBOT> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final GenerativeModel _model;
  late final ScrollController _scrollController;
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  late ChatSession _chatSession;
  late bool _isLoading;
  @override
  void initState() {
    _scrollController = ScrollController();
    _textController = TextEditingController();
    _isLoading = false;
    //
    _focusNode = FocusNode();
    //setup the model
    _model = GenerativeModel(model: geminiModel, apiKey: apiKey);
    //Setup the chat
    _chatSession = _model.startChat();
    super.initState();
  }

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _chatSession.history.length,
                  itemBuilder: (context, index) {
                    var content = _chatSession.history.toList()[index];
                    final message = _getMessageFromContent(content);
                    return MessageWidget(
                        message: message, isFromUser: content.role == 'user');
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Material(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: ChatTextFormFiled(
                          textController: _textController,
                          focusNode: _focusNode,
                          isReadyOnly: _isLoading,
                          onFieldSubmitted: _sendChatMessage),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  if (!_isLoading) ...[
                    ElevatedButton(
                        onPressed: () {
                          _sendChatMessage(_textController.text);
                        },
                        child: const Text('Send'))
                  ] else ...[
                    const CircularProgressIndicator.adaptive()
                  ]
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  void _sendChatMessage(String message) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _setLoading(true); //
    try {
      var response = await _chatSession.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      if (text == null) {
        _showError("No response was found");
        _setLoading(false);
      } else {
        _setLoading(false);
      }
      _setLoading(false);
    } catch (e) {
      _showError(e.toString());
      _setLoading(false);
    } finally {
      _textController.clear();
      _focusNode.requestFocus();
      _setLoading(false);
    }
  }

  String _getMessageFromContent(Content content) {
    return content.parts.whereType<TextPart>().map((e) => e.text).join('');
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: AlertDialog(
            title: const Text('Error'),
            scrollable: true,
            content: SingleChildScrollView(
              child: Text(message),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'))
            ],
          ),
        );
      },
    );
  }
}
