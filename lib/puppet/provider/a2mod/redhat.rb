Puppet::Type.type(:a2mod).provide(:redhat) do
  desc "Manage Apache 2 modules on RedHat family OSs"

  defaultfor :osfamily => :redhat

  def create
    File.open("/etc/httpd/conf.d/00_load_#{resource[:name]}.conf")
  end

  def destroy
    if httpd_conf_exist?(resource[:name])
      httpd_conf_disable(resource[:name])
    elsif conf_d_exists?(resource[:name])
      conf_d_disable(resource[:name])
    end
  end

  def exists?
    httpd_conf_exists?(resource[:name]) or conf_d_exists?(resource[:name])
  end

  private

  def httpd_conf_exists?(mod)
    conf_file = File.read('/etc/httpd/conf/httpd.conf')
    conf_file.match(/^LoadModule #{mod}_module modules\/mod_#{mod}.so$/i)
  end

  def conf_d_exists?(mod)
    File.exists?("/etc/httpd/conf.d/00_load_#{mod}.conf")
  end

  def conf_d_create(mod)
    File.open("/etc/httpd/conf.d/00_load_#{mod}.conf",'w') do |f|
      f.puts "LoadModule #{mod}_module modules/mod_#{mod}.so"

  def conf_d_disable(mod)
    File.delete("/etc/httpd/conf.d/00_load_#{mod}.conf")
  end
end
