module MCollective
  module Agent
    class Haproxy<RPC::Agent
      metadata :name        => 'haproxy',
               :description => 'Performs haproxy actions',
               :author      => 'Hunter Haugen',
               :license     => 'MIT',
               :version     => '1.0',
               :url         => 'http://puppetlabs.com',
               :timeout     => 120

      ['enable','disable'].each do |act|
        action act do
          validate :server, :shellsafe
          run_hamanage act, request[:server]
        end
      end
      action 'status' do
        run_hamanage 'status'
      end

      private
      def run_hamanage(action,server=nil)
        output = ''
        cmd = ['/usr/bin/hamanage']
        case action
        when 'enable','disable'
          cmd << '-e' if action == 'enable'
          cmd << '-d' if action == 'disable'
          cmd << server
          reply[:server] = server
        when 'status'
          cmd << '-s'
        end
        reply[:status] = run(cmd, :stdout => :output, :chomp => true)
      end
    end
  end
end
