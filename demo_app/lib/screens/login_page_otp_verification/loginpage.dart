
import 'package:DemoVideoApp/screens/login_page_otp_verification/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../resources/colors.dart';
import '../../resources/components/round_button.dart';
import '../../utils/utils.dart';
import '../../view_model/login_signup_otpverify_view_model.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body:SingleChildScrollView(
            child:Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(top: 0,bottom: 0),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 230,),
                    Container(
                      width: 245.0,
                      child: Column(
                        children: [
                          Text(
                            "Welcome Back",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26, color:Colors.black),
                          ),
                          const SizedBox(height: 10.0,),
                          Text(
                            "Sign in to access your account",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100.0,),
                    Container(
                      width: 320,
                      height: 65,
                      child: Center(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: phoneController,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (value) {
                            setState(() {
                              phoneController.text = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Enter phone number",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.appLightColorText,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(color: AppColors.appTextFieldBorderColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(color: AppColors.appTextFieldBorderColor),
                            ),
                            prefixIcon: Container(
                              padding: const EdgeInsets.only(left: 18,right: 8),
                              child: InkWell(
                                  onTap: () {
                                    showCountryPicker(
                                        context: context,
                                        countryListTheme: const CountryListThemeData(
                                          bottomSheetHeight: 550,
                                        ),
                                        onSelect: (value) {
                                          setState(() {
                                            selectedCountry = value;
                                          });
                                        });
                                  },
                                  child:
                                  Container(
                                    width: 100,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          alignment: Alignment.center,
                                          child: Center(
                                            child:
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                    color: AppColors.appTextFieldBorderColor,  // Color of the border
                                                    width: 1.0,         // Width of the border
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${selectedCountry.flagEmoji}",
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center, // Center-align the text
                                                    overflow: TextOverflow.ellipsis, // Hide text if it overflows
                                                  ),
                                                  Icon(
                                                    Icons.arrow_drop_down_rounded, // Downward caret icon
                                                    size: 30, // Adjust the size of the icon as needed
                                                    color: AppColors.blackColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 15,),
                                        Text("+""${selectedCountry.phoneCode}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ),
                            suffixIcon: phoneController.text.length == 10
                                ? Container(
                              height: 30,
                              width: 30,
                              margin: const EdgeInsets.all(12.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.appColorGreen,
                              ),
                              child: const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 20,
                              ),
                            )
                                : null,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35.0,),
                    RoundButton(title: "Get OTP",loading:authViewModel.loading , onPress:()async{
                      if(phoneController.text.length!=10){
                        Utils.flushBarErrorMessage("Invalid Phone Number",context);
                      }else{
                        Map<String,dynamic> loginData = {
                          "mobile_code": selectedCountry.phoneCode.toString(),
                          "mobile_no": selectedCountry.phoneCode.toString()+phoneController.text
                        };
                        authViewModel.loginApi(loginData, context,selectedCountry.phoneCode.toString(),phoneController.text);
                      }
                    }),
                    const SizedBox(height: 10.0,),
                    Container(
                      width: 200.0,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                            ), // Use SizedBox with width to add spacing
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpScreen(),
                                    )
                                );
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  color: Color(0xFFF01B49E),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        )
    );
  }
}