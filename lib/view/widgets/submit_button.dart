import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String? text;
  final bool? loadingHandler;
  final Function()? onPressed;

  const SubmitButton({Key? key, this.text, this.loadingHandler, this.onPressed}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(30),
        padding:const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.95),
                Theme.of(context).primaryColor.withOpacity(0.85),
                Theme.of(context).primaryColor.withOpacity(0.75),
              ],
            )),
        height: size.height * 0.06,
        child: Center(
          child: loadingHandler==false
              ? Text(
                  text!,
                  style:const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                )
              :const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
