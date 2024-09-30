import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/screens/forgetPass.dart';
import 'package:simro/screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

    String password = "";
  String email = "";
  bool _obscureText = true;
  bool isActive = true;
   TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  
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
                      'assets/images/logo-simro.png',
                      // height: MediaQuery.sizeOf(context).height * 0.45,
                    )),
                  ),
                  const Text(
                    " Connexion ",
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
         
                        const SizedBox(
                          height: 10,
                        ),
         
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Mot de passe *",
                            style: TextStyle(color: (Colors.black), fontSize: 18),
                          ),
                        ),
                        // debut  mot de pass
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: "Entrez votre mot de passe",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText =
                                      !_obscureText; // Inverser l'état du texte masqué
                                });
                              },
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons
                                        .visibility, // Choisir l'icône basée sur l'état du texte masqué
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: _obscureText,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Veillez entrez votre  mot de passe";
                            }
                            if (val.length < 4) {
                              return 'Le mot de passe doit contenir au moins 4 caractères';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) => password = val!,
                        ),
                        // fin mot de pass
         
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 30,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Switch(
                                      value: isActive,
                                      activeColor: vert,
                                      onChanged: (bool value) {
                                        setState(() {
                                          isActive = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  "Se souvenir de moi",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                print("ho");
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ForgetPassScreen(),
                                //   ),
                                // );
                                Get.to(ForgetPassWordScreen(),
                                    duration: Duration(seconds: 1),
                                    transition: Transition.leftToRight);
                              },
                              child: const Text(
                                "Mot de passe oublié ",
                                style: TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  color: vert,
                                ),
                              ),
                            ),
                          ],
                        ),
         
                        const SizedBox(
                          height: 40,
                        ),
                         Center(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
                            onPressed: () async {
                              Get.offAll(HomeScreen(), transition: Transition.downToUp, duration: Duration(seconds: 1)) ;
                            },
                            style: ElevatedButton.styleFrom(
                                     backgroundColor: vert,
                                     padding: EdgeInsets.symmetric(vertical: 14.0),
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(8),
                                     ),
                                   ),
                            child: Text(
                              "Se connecter",
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