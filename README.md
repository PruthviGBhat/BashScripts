## SSL Certificate Checker
This Bash script checks the SSL certificates of specified websites and logs information about the certificates. It sends notifications if the certificates are invalid or close to expiration.

## Features
- Checks SSL certificates for a list of websites.
- Logs certificate information including issuer and expiration date.
- Sends notifications for invalid certificates or certificates that are close to expiring.

## Prerequisites
- openSSL
- Bash

## Usage
1. Clone the repository:

```bash
git clone https://github.com/yourusername/ssl-certificate-checker.git
cd ssl-certificate-checker
```
2. Add the websites to be checked:

```bash
websites=("https://google.com" "https://youtube.com" "https://facebook.com")
```
3. Run the script:
  ```bash
./ssl_check.sh
```
4. View the log file:

Check the ssl_check.log file for detailed logs of the certificate checks.

## Script Details
## Variables
- websites: An array of websites to check.
- log_file: The file where logs will be written.
## Functions
- send_notification(website, message): Sends a notification with a given message for a specified website.
- check_ssl_certificate(website): Checks the SSL certificate for a specified website, logs details, and sends notifications if necessary.
## Logging and Notifications
- Logs are written to ssl_check.log.
- Notifications are sent using the send_notification function. Currently, this function prints to the console but can be modified to send emails or alerts.
## Example Output
  
     Thu Jun 23 14:23:45 UTC 2024: SSL certificate for https://google.com issued by C=US, O=Google Trust Services LLC, CN=GTS CA 1C3, expires on Jun 22 14:23:45 2024 GMT (in 29 days)
     Thu Jun 23 14:23:45 UTC 2024: Warning: SSL certificate for https://google.com is expiring in 29 days
  
## Customization
Modify the websites array to include the websites you want to check.
Customize the send_notification function to integrate with your preferred notification system (e.g., email, SMS, Slack).
## License
This project is licensed under the MIT License.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request with your improvements.
