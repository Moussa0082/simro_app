import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/screens/verify_code.dart';

class ForgetPassWordScreen extends StatefulWidget {
  const ForgetPassWordScreen({super.key});

  @override
  State<ForgetPassWordScreen> createState() => _ForgetPassWordScreenState();
}

class _ForgetPassWordScreenState extends State<ForgetPassWordScreen> {
  
  
  String email = "";
   TextEditingController emailController = TextEditingController();

  
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
                      'assets/images/forget-pass.png',
                      // height: MediaQuery.sizeOf(context).height * 0.45,
                    )),
                  ),
                  const Text(
                    " Mot de passe oublié ",
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
                        // debut fullname
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Email *",
                            style: TextStyle(color: (Colors.black), fontSize: 18),
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            hintText: "Entrez votre adresse email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Veillez entrez votre adresse email";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) => email = val!,
                        ),
                        // fin  adresse email

         
                        const SizedBox(height: 20),
                      const  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [

                            Text(
                                      "J'ai pas réçu de code." , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                    ),     
                            TextButton(
                              onPressed: null,
                              child: 
                                    Text("Envoyer le code", style: TextStyle(color: vert, fontWeight: FontWeight.bold, fontSize: 20)),
                            ),     
                                
                          ]),
                              ],
                            ),
                   
         
                        const SizedBox(
                          height: 30,
                        ),
                         Center(
        child: SizedBox(
          width:double.infinity,
          child: ElevatedButton(
                            onPressed: () async {
                              Get.to(VerifyCodeScreen() , transition: Transition.rightToLeft, duration: Duration(seconds: 2));
                            },
                            style: ElevatedButton.styleFrom(
                                     backgroundColor: vert,
                                     padding: EdgeInsets.symmetric(vertical: 14.0),
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(8),
                                     ),
                                   ),
                            child: Text(
                              "Envoyer le code",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
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

}