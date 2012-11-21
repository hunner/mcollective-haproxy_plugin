class MCollective::Application::Haproxy<MCollective::Application
  def post_option_parser(configuration)
    if ARGV.length >= 1
      configuration[:command] = ARGV.shift
      case configuration[:command]
      when 'enable','disable'
        configuration[:server] = ARGV.shift || docs
      when 'status'
      end
    else
      docs
    end
  end

  def docs
    puts "Usage: #{$0} [enable|disable <server>] | status"
  end

  def main
    mc = rpcclient("haproxy", :chomp => true)
    options = {:server => configuration[:server]} if ['enable','disable'].include? configuration[:command]
    mc.send(configuration[:command], options).each do |resp|
      puts "#{resp[:sender]}:"
      if resp[:statuscode] == 0
        responses, statuses = parse_lines(resp[:data][:output])
        puts responses if responses and ['enable','disable'].include? configuration[:command]
        puts statuses if statuses and configuration[:command] == 'status'
      else
        puts resp[:statusmsg]
      end
    end
    mc.disconnect
    printrpcstats
  end

  def parse_lines(output)
    responses = ""
    statuses = ""
    output.each_line do |line|
      case line
      when /^\w+:/
        responses = responses + (sprintf '%-30s', "    #{line}")
      when /^\w+,/
        fields = line.split(',')
        statuses = statuses + (sprintf '%-30s %s', "    #{fields[0]}/#{fields[1]}:", "#{fields[17]}\n")
      end
    end
    [responses, statuses]
  end
end
