metadata :name        => "haproxy",
         :description => "Performs haproxy actions",
         :author      => "Hunter Haugen",
         :license     => "MIT",
         :version     => "1.0",
         :url         => "http://puppetlabs.com",
         :timeout     => 120

['enable','disable'].each do |act|
  action act, :description => "#{act.capitalize} an haproxy server" do
    input :server,
          :prompt      => "Server name",
          :description => "Server to #{act}",
          :type        => :string,
          :validation  => '.',
          :optional    => false,
          :maxlength   => 256

    output :server,
           :description => "Server requested to #{act}",
           :display_as  => "Server"

    output :output,
           :description => "Output from hamanage",
           :display_as  => "Output"

    output :status,
           :description => "Return status of hamanage",
           :display_as  => "Return Status"
  end
end

action 'status', :description => "Get status from haproxy" do
  display :always

  output :output,
         :description => "Output from hamanage",
         :display_as  => "Output"

  output :status,
         :description => "Return status of hamanage",
         :display_as  => "Return Status"
 end
