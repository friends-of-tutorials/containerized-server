<?php

// Add autoloader
require_once 'vendor/autoload.php';

// Read .env file
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

// Set smtp settings
$smtpHost = $_ENV['MAILHOG_1_0_1_WEB_APPLICATION_HOSTNAME'];
$smtpPort = $_ENV['MAILHOG_1_0_1_WEB_APPLICATION_PORT'];
$mailFromEmail = 'from@domain.tld';
$mailFromName = 'PHP Script';

// Set MAIL content
$mailToEmail = 'to@domain.tld';
$mailToName = 'Name';
$mailSubject = 'Das ist der Betreff der Testmail';
$mailMessage = 'Das ist der Text der Testmail';

// Create the Transport
$transport = new Swift_SmtpTransport($smtpHost, $smtpPort);

// Create the Mailer using your created Transport
$mailer = new Swift_Mailer($transport);

// Create a message
$message = (new Swift_Message($mailSubject))
    ->setFrom([$mailFromEmail => $mailFromName])
    ->setTo([$mailToEmail => $mailToName])
    ->setBody($mailMessage)
;

// Send the message
$numSent = $mailer->send($message);

// No mail was sent
if ($numSent === 0) {
    echo "Status: No mail was sent. :(\n\n";
    exit;
}

// At least one mail was sent
echo printf("Status: %d messages was sent.\n\n", $numSent);

