# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title 'php configuration'

# check php directory
control 'php-1' do
  impact 0.5
  title 'Check if php configuration directory is located'
  describe file('/etc/php.ini') do
  it { should exist }
 end
end

control 'php-2' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'check php package for drupal configuration'
  describe package('php') do                  # The actual test
    it { should be_installed }
    its('version') { should eq '5.4.16-42.el7' }
  end
end

# check content of php configuration file
control 'php-3' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'Set PHP configuration file'             # A human-readable title
  desc 'php configuration file should include the below words and lines'
  describe file('/etc/php.ini') do                  # The actual test
    its('content') { should match 'engine = On' }
    its('content') {should match 'max_execution_time' }
    its('content') {should match 'max_input_time' }
  end
end

control 'php-4' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'check apache index content in PHP configuration file'             # A human-readable title
  desc 'check apache index content in directory file should include the below words and lines'
  describe file('/etc/apache2/mods-enabled/dir.conf') do                  # The actual test
    its('content') { should match "<IfModule mod_dir.c>\n        DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm\n</IfModule>\n\n# vim: syntax=apache ts=4 sw=4 sts=4 sr noet" }
  end
end
