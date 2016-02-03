# Bash - Check Website Changes

The main aim for this script is to check if any changes is applied to specific website. I highlighted the need for smething like this in order to check if on the teacher's personal website is published or not the exams results.

## Installation

1. Download the script
2. Navigate to the donwload folder (or move the just downloaded script wherever you want)
3. Make it executable with: `chmod +x ./checkchanges.sh`
4. Run it `./checkchanges.sh [-v] [-e notification_email] [-t refresh_time] url`


## Usage

The easiest invocation is `./checkchanges.sh url`. With this you get a running process that uses default parameters (remember to **change the default email** in the script!).

Following the options you can use:
* `-v` - activate verbose mode
* `-e email_address` - send notification to the email address specified
* `-t refresh_seconds` - specify the amount of seconds between two checks. (for example: `-t 600` to refresh every ten minutes)

## Contact
#### Developer: Giacomo Cavicchioli
* Homepage: [giacomocavicchioli.me](https://giacomocavicchioli.me "main website")
* Twitter: [@giacavicchioli](https://twitter.com/giacavicchioli "giacavicchioli on twitter")

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D