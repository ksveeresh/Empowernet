import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:intl/date_symbol_data_local.dart';
class mSendMail{
  String username = "veereshks1993@gmail.com";
  String password = "no1canseeme";
  CreateMail(int rNum, String to)  {
    initializeDateFormatting();
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username)
      ..recipients.add(to) //recipent email//cc Recipents emails
      ..subject = 'Email verification' //subject of the email
      ..html =  "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Strict//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'><html data-editor-version='2' class='sg-campaigns' xmlns='http://www.w3.org/1999/xhtml'><head> <meta http-equiv='Content-Type' content='text/html; charset=utf-8'> <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>  <meta http-equiv='X-UA-Compatible' content='IE=Edge'>    <style type='text/css'> body, p, div { font-family: inherit; font-size: 14px; } body { color: #000000; } body a { color: #1188E6; text-decoration: none; } p { margin: 0; padding: 0; } table.wrapper { width:100% !important; table-layout: fixed; -webkit-font-smoothing: antialiased; -webkit-text-size-adjust: 100%; -moz-text-size-adjust: 100%; -ms-text-size-adjust: 100%; } img.max-width { max-width: 100% !important; } .column.of-2 { width: 50%; } .column.of-3 { width: 33.333%; } .column.of-4 { width: 25%; } @media screen and (max-width:480px) { .preheader .rightColumnContent, .footer .rightColumnContent { text-align: left !important; } .preheader .rightColumnContent div, .preheader .rightColumnContent span, .footer .rightColumnContent div, .footer .rightColumnContent span { text-align: left !important; } .preheader .rightColumnContent, .preheader .leftColumnContent { font-size: 80% !important; padding: 5px 0; } table.wrapper-mobile { width: 100% !important; table-layout: fixed; } img.max-width { height: auto !important; max-width: 100% !important; } a.bulletproof-button { display: block !important; width: auto !important; font-size: 80%; padding-left: 0 !important; padding-right: 0 !important; } .columns { width: 100% !important; } .column { display: block !important; width: 100% !important; padding-left: 0 !important; padding-right: 0 !important; margin-left: 0 !important; margin-right: 0 !important; } } </style> <link href='https://fonts.googleapis.com/css?family=Muli&display=swap' rel='stylesheet'><style> body {font-family: 'Muli', sans-serif;} </style> </head> <body> <center class='wrapper' data-link-color='#1188E6' data-body-style='font-size:14px; font-family:inherit; color:#000000; background-color:#FFFFFF;'> <div class='webkit'> <table cellpadding='0' cellspacing='0' border='0' width='100%' class='wrapper' bgcolor='#FFFFFF'> <tbody><tr> <td valign='top' bgcolor='#FFFFFF' width='100%'> <table width='100%' role='content-container' class='outer' align='center' cellpadding='0' cellspacing='0' border='0'> <tbody><tr> <td width='100%'> <table width='100%' cellpadding='0' cellspacing='0' border='0'> <tbody><tr> <td>  <table width='100%' cellpadding='0' cellspacing='0' border='0' style='width:100%; max-width:600px;' align='center'> <tbody><tr> <td role='modules-container' style='padding:0px 0px 0px 0px; color:#000000; text-align:left;' bgcolor='#FFFFFF' width='100%' align='left'><table class='module preheader preheader-hide' role='module' data-type='preheader' border='0' cellpadding='0' cellspacing='0' width='100%' style='display: none !important; mso-hide: all; visibility: hidden; opacity: 0; color: transparent; height: 0; width: 0;'> <tbody><tr> <td role='module-content'> <p></p> </td> </tr> </tbody></table><table border='0' cellpadding='0' cellspacing='0' align='center' width='100%' role='module' data-type='columns' style='padding:30px 20px 30px 20px;' bgcolor='#f6f6f6'> <tbody> <tr role='module-content'> <td height='100%' valign='top'> <table class='column' width='540' style='width:540px; border-spacing:0; border-collapse:collapse; margin:0px 10px 0px 10px;' cellpadding='0' cellspacing='0' align='left' border='0' bgcolor=''> <tbody> <tr> <td style='padding:0px;margin:0px;border-spacing:0;'><table class='wrapper' role='module' data-type='image' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-muid='72aac1ba-9036-4a77-b9d5-9a60d9b05cba'> <tbody> <tr> <td style='font-size:6px; line-height:10px; padding:0px 0px 0px 0px;' valign='top' align='center'> <img class='max-width' border='0' style='display:block; color:#000000; text-decoration:none; font-family:Helvetica, arial, sans-serif; font-size:16px;' width='29' alt='' data-proportionally-constrained='true' data-responsive='false' src='http://cdn.mcauto-images-production.sendgrid.net/954c252fedab403f/9200c1c9-b1bd-47ed-993c-ee2950a0f239/29x27.png' height='27'> </td> </tr> </tbody> </table><table class='module' role='module' data-type='spacer' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-muid='331cde94-eb45-45dc-8852-b7dbeb9101d7'> <tbody> <tr> <td style='padding:0px 0px 20px 0px;' role='module-content' bgcolor=''> </td> </tr> </tbody> </table><table class='wrapper' role='module' data-type='image' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-muid='d8508015-a2cb-488c-9877-d46adf313282'> <tbody> <tr> <td style='font-size:6px; line-height:10px; padding:0px 0px 0px 0px;' valign='top' align='center'> <img class='max-width' border='0' style='display:block; color:#000000; text-decoration:none; font-family:Helvetica, arial, sans-serif; font-size:16px;' width='95' alt='' data-proportionally-constrained='true' data-responsive='false' src='http://cdn.mcauto-images-production.sendgrid.net/954c252fedab403f/61156dfa-7b7f-4020-85f8-a586addf4288/95x33.png' height='33'> </td> </tr> </tbody> </table><table class='module' role='module' data-type='spacer' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-muid='27716fe9-ee64-4a64-94f9-a4f28bc172a0'> <tbody> <tr> <td style='padding:0px 0px 30px 0px;' role='module-content' bgcolor=''> </td> </tr> </tbody> </table><table class='module' role='module' data-type='text' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-muid='948e3f3f-5214-4721-a90e-625a47b1c957' data-mc-module-version='2019-10-22'> <tbody> <tr> <td style='padding:50px 30px 18px 30px; line-height:36px; text-align:inherit; background-color:#ffffff;' height='100%' valign='top' bgcolor='#ffffff' role='module-content'><div><div style='font-family: inherit; text-align: center'><span style='font-size: 43px'>Thanks for signing up!Â </span></div><div></div></div></td> </tr> </tbody> </table><table class='module' role='module' data-type='text' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-muid='a10dcb57-ad22-4f4d-b765-1d427dfddb4e' data-mc-module-version='2019-10-22'> <tbody> <tr> <td style='padding:18px 30px 18px 30px; line-height:22px; text-align:inherit; background-color:#ffffff;' height='100%' valign='top' bgcolor='#ffffff' role='module-content'><div><div style='font-family: inherit; text-align: center'><span style='font-size: 18px'>Your verfication code is: </span><span style='color: #000000; font-size: 18px; font-family: arial,helvetica,sans-serif'>${rNum}</span><span style='font-size: 18px'>.</span></div> <div style='font-family: inherit; text-align: center'><span style='color: #ffbe00; font-size: 18px'><strong>Thank you!Â </strong></span></div><div></div></div></td> </tr> </tbody> </table><table class='module' role='module' data-type='spacer' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-muid='7770fdab-634a-4f62-a277-1c66b2646d8d'>  </td> </tr> </tbody></table> </td> </tr> </tbody></table> </td> </tr> </tbody></table> </div> </center> </body></html>";

    try {
      final sendReport =  send(message, smtpServer).then((value) => print("Done: $value")).catchError((Object error) {
        print("Done: $error");
      });
      print('Message sent: ' + sendReport.toString()); //print if the email is sent
    } on MailerException catch (e) {
      print('Message not sent. \n'+ e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }
  }
}