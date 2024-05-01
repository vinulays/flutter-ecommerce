import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/screens/Login/bloc/authentication_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeSettingsForm extends StatefulWidget {
  // * Passing the values from previous screen to know which setting to change.
  final String userId;
  final String settingName;
  final String settingValue;

  const ChangeSettingsForm(
      {super.key,
      required this.settingName,
      required this.settingValue,
      required this.userId});

  @override
  State<ChangeSettingsForm> createState() => _ChangeSettingsFormState();
}

class _ChangeSettingsFormState extends State<ChangeSettingsForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.03),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.chevron_left_outlined,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text("Change ${widget.settingName}",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              FormBuilderTextField(
                initialValue: widget.settingValue,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: GoogleFonts.poppins(),
                name: widget.settingName,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    errorStyle: GoogleFonts.poppins(
                        fontSize: 14, color: const Color(0xffba000d)),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    // isDense: true,
                    prefix: Container(
                      width: 20,
                    ),
                    contentPadding: EdgeInsets.zero,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.15)),
                        borderRadius: BorderRadius.circular(20)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.15)),
                        borderRadius: BorderRadius.circular(20)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.15)),
                        borderRadius: BorderRadius.circular(20)),
                    hintStyle: GoogleFonts.poppins(
                        height: 4,
                        color: Colors.black.withOpacity(0.40),
                        fontWeight: FontWeight.w600),
                    hintText: widget.settingName),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "${widget.settingName} is required."),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.saveAndValidate()) {
                        // * If the setting name is 'Username', update the displauName of the currently logged user.
                        if (widget.settingName == "Username") {
                          String username =
                              _formKey.currentState!.value["Username"];

                          context
                              .read<AuthenticationBloc>()
                              .add(ChangeUsernameEvent(username));

                          Navigator.of(context).pop();
                          // * If the setting name is 'Phone number', update the phoneNumber of the currently logged user.
                        } else if (widget.settingName == "Phone number") {
                          String phoneNumber =
                              _formKey.currentState!.value["Phone number"];

                          context
                              .read<AuthenticationBloc>()
                              .add(ChangePhoneNumberEvent(phoneNumber));

                          Navigator.of(context).pop();
                        }
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.8),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 17.88)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    child: Text(
                      "Save",
                      style: GoogleFonts.poppins(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
