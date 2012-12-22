# AwsPipes

Text streams are the universal interface. This gem provides binaries to
read and write to Amazon Web Services (AWS) using Unix pipes.

## Installation

    gem install aws_pipes


## Usage

Reading and writing to the Simple Queue Service (SQS).

    # write data to an SQS queue
    your_program | sqswrite <queue-name>
    
    # read data from an SQS queue
    sqsread <queue-name> | your_program

These programs read Amazon credentials from environment variables
or command line options.  Use `--help` to read more details.
