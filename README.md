Send messages between Amazon EC2 instances through Unix pipes.

This gem is built on top of the Amazon [Simple Queue
Service](http://aws.amazon.com/sqs/) (SQS) which lets you

- Move data between distributed components of your application without
  losing messages or requiring each component to be always available.
- Get started with no extra installed software or special firewall
  configurations.
- Connect machines on different networks, developed with different
  technologies, and running at different times.
- Save messages in the queue for up to 14 days.

Text is the universal interface, and any application that can read and
write text can use this gem &ndash; no knowledge of the Amazon API is
required.

## Usage

    # write data to an SQS queue named "foo"
    your_program | aws_queue write foo
    
    # read data from an SQS queue named "foo"
    aws_queue read foo | your_program

To use this program you will need to [create a
queue](https://console.aws.amazon.com/sqs/) in the Amazon Web Console.

## Installation

1. Sign up for an [AWS account](http://aws.amazon.com/).
1. Find your secret key and key id in *My Account* > *Security Credentials*.
1. (optionally) Set your environment variables AWS_ACCESS_KEY_ID, and
   AWS_ACCESS_KEY accordingly.
1. Run `gem install aws_pipes` from the command line.

This will install the `aws_queue` command to your path. If you haven't
stored your Amazon credentials in environment variables, you can pass
them in as command line options. For more info, run

    aws_queue --help

## Examples

### Downloading a massive list of urls in parallel.

One computer can feed a list of urls to workers which download them.
Suppose the urls are stored in `urls.txt`. Just redirect the file into a
queue:

    aws_queue write to_be_downloaded < urls.txt

Then have each worker pull from the `to_be_downloaded` queue and
repeatedly run a command to download each url. The queue supports many
simultaneous readers and prevents duplicate work.

    aws_queue read to_be_downloaded | xargs -L1 wget
