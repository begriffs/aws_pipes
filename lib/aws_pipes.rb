require "aws_pipes/version"
require 'trollop'

module AwsPipes
  def AwsPipes.common_aws_options program_name, custom_banner, &more_opts
    ::Trollop::options do
      version "#{program_name} #{VERSION} (c) 2013 Joe Nelson"
      banner <<-EOS
#{custom_banner}
You may provide Amazon authentication through these environment variables:
AWS_ACCESS_KEY_ID - AWS access key id
AWS_ACCESS_KEY    - AWS secret access key

Additional options:
EOS
      opt :keyid, "AWS access key id", :type => :string
      opt :key, "AWS secret access key", :type => :string

      self.instance_eval &more_opts if more_opts
    end
  end

  def AwsPipes.access_key_id opts
    ENV['AWS_ACCESS_KEY_ID'] ||
      opts[:keyid] ||
      ::Trollop::die("Missing access key id")
  end

  def AwsPipes.secret_access_key opts
    ENV['AWS_ACCESS_KEY'] ||
      opts[:key] ||
      ::Trollop::die("Missing secret access key")
  end
end
