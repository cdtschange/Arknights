import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SnackbarManager<B extends BlocBase<S>, S> extends StatelessWidget {
  final String? Function(S)? messageHandler;
  final void Function(BuildContext, S)? popupHandler;
  SnackbarManager.fromError(this.messageHandler)
      : popupHandler = null,
        super();
  SnackbarManager.fromPopup(this.popupHandler)
      : messageHandler = null,
        super();

  static Widget wrap(Widget view, List<SnackbarManager> snacks) {
    return SafeArea(child: Stack(children: [Row(children: snacks), view]));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      listener: (context, state) {
        if (popupHandler != null) {
          popupHandler!.call(context, state);
          return;
        }
        if (messageHandler != null) {
          final message = messageHandler!.call(state);
          if (message != null) {
            _showErrorToast(context, message);
            return;
          }
        }
      },
      child: Container(),
    );
  }

  void _showErrorToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Flexible(
          child: Text(
        message,
        style: TextStyle(color: Colors.white),
      )),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
    ));
  }
}
