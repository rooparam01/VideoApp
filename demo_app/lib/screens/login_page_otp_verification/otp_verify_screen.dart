
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../resources/components/round_button.dart';
import '../../utils/utils.dart';
import '../../view_model/login_signup_otpverify_view_model.dart';

class OTPScreen extends StatefulWidget {
  final String countrycode;
  final String mobileNumber;
  const OTPScreen({super.key, required this.countrycode, required this.mobileNumber} );

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  String? otpCode;



  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 0.5, // Border width (1px)
                              ),
                              borderRadius: BorderRadius.circular(50.0), // 50% border radius
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 70,),
                      Expanded( // Use Expanded to push the Text to the center
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Verification",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50,),
                  Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset("assets/otpverification.png"),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    "Verify OTP",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "We have sent you a verification code to your mobile number ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "+${widget.countrycode.toString()} ${widget.mobileNumber}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFF01B49E),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          child: Icon(
                            Icons.edit_calendar,
                            color: Color(0xFFF01B49E),
                            size: 16,
                          ),
                        ),
                        )],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  Pinput(
                    length: 5,
                    showCursor: true,
                    defaultPinTheme: PinTheme(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xFFF01B49E),
                        ),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onCompleted: (value) {
                      setState(() {
                        otpCode = value;
                      });
                    },
                  ),
                  const SizedBox(height: 100),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't not received?",
                          style: TextStyle(
                            fontSize: 14,
                            // fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          ),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            print("resend code");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "  Resend OTP",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF01B49E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  RoundButton(title: "Verify Now",loading:authViewModel.otploading, onPress:()async{
                    if(otpCode?.length!=5){
                      Utils.flushBarSuccessMessage("Please Enter 5 digit OTP",context);
                    }else{
                      Map<String,dynamic> Data = {
                        "otp":otpCode.toString(),
                      };
                      print(Data);
                      authViewModel.OtpVerifyApi(Data, context);
                    }
                  }),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
