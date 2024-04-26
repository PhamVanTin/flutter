import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class LightDartMode extends StatelessWidget {
  final void Function()? onTap;
  const LightDartMode({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return // Generated code for this Container Widget...
        Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.transparent,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  splashColor: Colors.black,
                  focusColor: Colors.black,
                  hoverColor: Colors.black,
                  highlightColor: Colors.black,
                  onTap: onTap,
                  child: Container(
                    width: 115,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : const Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : const Color.fromARGB(255, 0, 0, 0),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wb_sunny_rounded,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xFF15161E)
                                  : const Color.fromARGB(255, 255, 255, 255),
                          size: 16,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          child: Text(
                            'Light ',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? const Color(0xFF15161E)
                                  : const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 14,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  splashColor: Colors.black,
                  focusColor: Colors.black,
                  hoverColor: Colors.black,
                  highlightColor: Colors.black,
                  onTap: onTap,
                  child: Container(
                    width: 115,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : const Color.fromARGB(255, 0, 0, 0),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.nightlight_round,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? const Color.fromARGB(255, 0, 0, 0)
                              : const Color.fromARGB(255, 255, 255, 255),
                          size: 16,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          child: Text(
                            'Dark',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? const Color.fromARGB(255, 0, 0, 0)
                                  : const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 14,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
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

  void setDarkModeSetting(BuildContext context, ThemeMode themeMode) {
    // Thực hiện cài đặt chế độ tối
    // Ví dụ:
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
  }
}
