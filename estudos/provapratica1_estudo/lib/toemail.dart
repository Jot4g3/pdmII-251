import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';

void sendEmail({
  required String nomeRemetente,
  required String emailRemetente,
  required String senhaRemetente,
  required String emailDestinatario,
  required String assuntoEmail,
  required String conteudoEmail,
  required int quantidadeEnvios,
}) async {
  final smtpServer = gmail(emailRemetente, senhaRemetente);

  final message = Message()
  ..from = Address(emailRemetente, nomeRemetente)
  ..recipients.add(emailDestinatario)
  ..subject = assuntoEmail
  ..text = conteudoEmail;

  try{
    for (int i = 1; i <= quantidadeEnvios; i++){
      final result = await send(message, smtpServer);
      print('E-mail enviado: ${result}');
    }
  } on MailerException catch (err) {
    print('Erro ao enviar e-mail: ${err.toString()}');
  }
}