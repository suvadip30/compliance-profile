# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title 'sample section'

control 'varnish-1' do
  impact 0.7
  title 'check the varnish directory'
  describe file('/etc/varnish') do
  it { should be_directory }
  end
end

control 'varnish-2' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'check varnish configuration file'             # A human-readable title
  desc 'varnish file should include the below words and lines'
  describe file('/etc/default/varnish') do                  # The actual test
    its('content') { should match "DAEMON_OPTS=\"-a :80 \\\n             -T localhost:6082 \\\n             -f /etc/varnish/default.vcl \\\n             -S /etc/varnish/secret \\\n             -s malloc,256m\"\n" }
 end
end

control 'varnish-3' do
  impact 0.7
  title 'check varnish port configuration file'
  desc 'varnish default.vcl should include the below words and lines'
  describe file('/etc/varnish/default.vcl') do
    its('content') { should match "backend default {\n    .host = \"127.0.0.1\";\n    .port = \"81\";\n}\n" }
 end
end

control 'varnish-4' do
  impact 0.7
  title 'check apache configuration file for varnish configuration'
  desc 'varnish apache2 should include the below words and lines'
  describe file('/etc/apache2/ports.conf') do
    its('content') { should match "# If you just change the port or add more ports here, you will likely also\n# have to change the VirtualHost statement in\n# /etc/apache2/sites-enabled/000-default.conf\n\nListen 81\n\n<IfModule ssl_module>\n        Listen 443\n</IfModule>\n\n<IfModule mod_gnutls.c>\n        Listen 443\n</IfModule>\n\n# vim: syntax=apache ts=4 sw=4 sts=4 sr noet\n\n"}
 end
end

control 'varnish-5' do
  impact 0.5
  title 'check varnish service'
  describe service('varnish') do
   it { should be_enabled }
   it { should be_running }
 end
end
