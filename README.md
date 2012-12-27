## Overview

### Communicating

Send messages between Amazon EC2 instances through Unix pipes.

Communication in aws_pipes is built on top of the Amazon [Simple Queue
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

### Logging

Consolidate logs between EC2 instances. Logging in aws_pipes is built on
top of Amazon [SimpleDB](http://aws.amazon.com/simpledb/).

- Get logs off individual servers to save disk space.
- Pool the log messages from related workers.
- Monitor and query logs from one place.
- Save as much log history as you want, the storage is virtually
  unlimited.

## Usage

### aws_queue

    # write data to an SQS queue named "foo"
    your_program | aws_queue write foo

    # read data from an SQS queue named "foo"
    aws_queue read foo | your_program

To use this program you will need to [create a
queue](https://console.aws.amazon.com/sqs/) in the Amazon Web Console.

### aws_log

    # write stderr to log named "bar"
    your_program 2> >(aws_log record bar)

    # delete all messages in log named "bar"
    aws_log delete bar

    # View log entries for "bar" within a date range
    aws_log show bar --after "1970-01-01" --before "2020-02-02 13:42:12.123"

Each line sent to the log gets marked with a timestamp and the external
IP address of the machine which added it.

You can combine queuing and logging in
a single command using Bash [process substitution](
http://www.gnu.org/software/bash/manual/bashref.html#Process-Substitution):

    # write stdout to an SQS queue named "foo"
    # while logging stderr to a log named "bar"
    your_program 1> >(aws_queue write foo) 2> >(aws_log record bar)

## Installation

1. Sign up for an [AWS account](http://aws.amazon.com/).
1. Find your secret key and key id in *My Account* > *Security Credentials*.
1. (optionally) Set your environment variables AWS_ACCESS_KEY_ID, and
   AWS_ACCESS_KEY accordingly.
1. Run `gem install aws_pipes` from the command line.

This will install the `aws_queue` and `aws_log` commands to your path.
If you haven't stored your Amazon credentials in environment variables,
you can pass them in as command line options. For more info, run

    aws_queue --help

## Examples

### Downloading a massive list of urls in parallel.

One computer can feed a list of urls to workers which download them.
Suppose the urls are stored in `urls.txt`. Just redirect the file into a
queue:

    aws_queue write to_be_downloaded < urls.txt

Then have each worker pull from the `to_be_downloaded` queue and
repeatedly run a command to download each url. The queue supports many
simultaneous readers and prevents duplicate work. We save any errors to
a log named "downloader" which we can monitor remotely.

    aws_queue read to_be_downloaded | xargs -L1 wget -nv 2> >(aws_log record downloader)
