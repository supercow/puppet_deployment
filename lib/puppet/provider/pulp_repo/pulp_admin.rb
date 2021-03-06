require "#{File.dirname(__FILE__)}/../../../puppet-pulp/pulp_admin"

Puppet::Type::type(:pulp_repo).provide(:pulp_admin) do
  def create
    pulp_admin.create @resource[:id], @resource[:repo_type], {
      :display_name    => @resource[:display_name],
      :description     => @resource[:description],
      :feed            => @resource[:feed],
      :notes           => @resource[:notes],
      :validate        => @resource[:validate],
      :queries         => @resource[:queries],
      :sync_schedules  => @resource[:sync_schedules],
      :serve_http      => @resource[:serve_http],
      :serve_https     => @resource[:serve_https],
      :relative_url    => @resource[:relative_url],
      :feed_ca_cert    => @resource[:feed_ca_cert],
      :feed_cert       => @resource[:feed_cert],
      :feed_key        => @resource[:feed_key],
      :verify_feed_ssl => @resource[:verify_ssl],
    }
  end

  def destroy
    pulp_admin.destroy @resource[:id]
  end

  def exists?
    repos = pulp_admin.repos(@resource[:repo_type])
    return false if repos.nil?
    repos.has_key? @resource[:id]
  end

  [ :display_name,
    :description,
    :feed,
    :notes,
    :queries,
    :sync_schedules,
    :schedules,
    :serve_http,
    :serve_https,
    :relative_url].each do |x| 
    define_method(x) { pulp_admin.repos( @resource[:repo_type] )[@resource[:id]].send x }
    define_method("#{x}=") { |v| pulp_admin.repos( @resource[:repo_type] )[@resource[:id]].send "#{x}=", v }
  end

  private

  def pulp_admin
    PuppetPulp::PulpAdmin.new @resource[:login], @resource[:password]
  end
end
