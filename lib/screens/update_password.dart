import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/screens/login.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
 
  String password = "";
  bool _obscureText = true;
  bool isActive = true;
   TextEditingController confirmPasswordController = TextEditingController();
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
                    height: 250,
                    width: 250,
                    child: Center(
                        child: Image.asset(
                      'assets/images/update-pass.jpeg',
                      // height: MediaQuery.sizeOf(context).height * 0.45,
                    )),
                  ),
                  const Text(
                    " Modifier mot de passe ",
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
                  
                        const SizedBox(
                          height: 10,
                        ),
         
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Nouveau votre nouveau mot de passe *",
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
                            hintText: "Entre votre nouveau mot de passe",
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
                              return "Veillez entrez le nouveau mot de passe de ";
                            }
                            if (val.length < 4) {
                              return 'Le mot de passe doit contenir au moins 4 caractères';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) => password = val!,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
         
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Confirmer votre nouveau mot de passe *",
                            style: TextStyle(color: (Colors.black), fontSize: 18),
                          ),
                        ),
                        // debut  mot de pass
                        TextFormField(
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: "Confirmer votre mot de passe",
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
                              return "Veillez entrez le mot mot de passe de confirmation";
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
                        
        
                        const SizedBox(
                          height: 30,
                        ),
                         Center(
        child: SizedBox(
         width:double.infinity,
          child: ElevatedButton(
                            onPressed: () async {
                              Get.to(LoginScreen() , transition: Transition.rightToLeft, duration: Duration(seconds: 1));
                            },
                            style: ElevatedButton.styleFrom(
                                       backgroundColor: vert,
                                       padding: EdgeInsets.symmetric(vertical: 14.0),
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(8),
                                       ),
                                     ),
                                   
                            child: Text(
                              "Modifier",
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