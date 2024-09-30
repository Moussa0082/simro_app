import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/screens/update_password.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  
  String email = "";
 final List<TextEditingController> pinControllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  int _time = 120;
  late Timer timere;
  String pinCode = '';
  bool _isCodeExpired = false;

 

  void _moveToNextField(int index) {
    if (index < 3) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    }
  }

  void _moveToPreviousField(int index) {
    if (index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }

    @override
  void dispose() {
    timere.cancel();
    pinControllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }

  void startTimer() {
    timere = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _isCodeExpired = false;
        if (_time > 0) {
          _time--;
        } else {
          timere.cancel();
        }
      });
    });
  }

    void resendCode() {
    setState(() {
      _time = 120;
      _isCodeExpired = true;
    });
    startTimer();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

    String get timerText {
    int minutes = _time ~/ 60;
    int seconds = _time % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
       SingleChildScrollView(
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
             SizedBox(
                    height: 220,
                    width: 250,
                    child: Center(
                        child: Image.asset(
                      'assets/images/pin-code.png',
                      // height: MediaQuery.sizeOf(context).height * 0.45,
                    )),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    " Verification de code ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xfff2b6706)),
                  ),
                  // connexion
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //       Text('LAT: ${_currentPosition?.latitude ?? ""}'),
                        // Text('LNG: ${_currentPosition?.longitude ?? ""}'),
                        // Text('ADDRESS: ${_currentAddress ?? ""}'),
                        // const SizedBox(height: 32),
                        // ElevatedButton(
                        //   onPressed: _getCurrentPosition,
                        //   child: const Text("Get Current Location"),
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        
               Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return _buildPinBox(index);
              }),
            ),
         
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [

                          const  Text(
                                      "Le code expire dans ."  , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                    ),     
                            TextButton(
                              onPressed: null,
                              child: 
                                    Text("$timerText", style: TextStyle(color: vert, fontWeight: FontWeight.bold, fontSize: 20)),
                            ),     
                            
                                
                          ]),
                              ],
                            ),
                            const SizedBox(height:5),
                             TextButton(
                              onPressed: (){
                                if(_time>1){
                                   
                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                              const SnackBar(
                                                                                content: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Text("Veuillez attendre que le code sois expiré"),
                                                                                  ],
                                                                                ),
                                                                                duration: Duration(seconds: 2),
                                                                              ),
                                                                            );
                                }
                              },
                              child: 
                                    Center(child: Text("Envoyer le code à nouveau", style: TextStyle(color: vert, fontWeight: FontWeight.bold, fontSize: 20))),
                            ),    
                   
         
                        const SizedBox(
                          height: 20,
                        ),
                         Padding(
                               padding: const EdgeInsets.only(bottom: 1.0),
                               child: SizedBox(
                                 width: double.infinity,
                                 child: ElevatedButton(
                                   onPressed: () {
                                     // Verification logic here
                                      // Récupérer les valeurs des TextEditingControllers
  String pinCode = pinControllers.map((controller) => controller.text).join();
  
  // Afficher le code PIN dans la console
  print('Code PIN entré: $pinCode');
  Get.to(UpdatePasswordScreen() , transition: Transition.downToUp, duration: Duration(seconds: 1));
                                   },
                                   child: Text("Verifier", style: TextStyle(fontSize: 18, color: blanc)),
                                   style: ElevatedButton.styleFrom(
                                     backgroundColor: vert,
                                     padding: EdgeInsets.symmetric(vertical: 14.0),
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(8),
                                     ),
                                   ),
                                 ),
                               ),
                             )
          ],
               )
               ,
             )
             )
           ]),
       )
                );
  }

  Widget _buildPinBox(int index) {
    return SizedBox(
      width: 50,
      height: 60,
      child: RawKeyboardListener(
        focusNode: FocusNode(), // Use a new focus node for keyboard listener
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
            if (pinControllers[index].text.isEmpty) {
              _moveToPreviousField(index);
            }
          }
        },
        child: TextField(
          controller: pinControllers[index],
          focusNode: focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          onChanged: (value) {
            if (value.isNotEmpty) {
              _moveToNextField(index);
            }
          },
          onTap: () {
            pinControllers[index].selection = TextSelection.fromPosition(
              TextPosition(offset: pinControllers[index].text.length),
            );
          },
          onSubmitted: (_) {
            _moveToNextField(index);
          },
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: vert),
            ),
          ),
        ),
      ),
    );
  }


}