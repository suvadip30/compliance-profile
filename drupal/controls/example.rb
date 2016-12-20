# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title 'Drupal Configuration'

only_if do
  command('drush').exist?
end

#check php package for drupal configuration
control 'drupal-1' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'check settings file for drupal configuration'
  describe file('/var/www/html/smith_wesson_stage/settings.php') do                  # The actual test
    it { should be_file }
    its('mode') { should cmp '0644' }
   end
end

#check drupal core directory
control 'drupal-2' do
  impact 0.7
  title 'check drupal core directory'
  describe file('/usr/share/php/drush/commands/core/drupal') do
  it { should be_directory }
 end
end

#check mount point for for drupal configuration
control 'drupal-3' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'check mount point for for drupal configuration'
  describe mount('/dev') do
       it { should be_mounted  }
end
 describe mount("/dev") do
    its("options") { should include "mode=755" }
  end
end

#check drupal version for drupal configuration
control 'drupal-4' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'check drupal version for drupal configuration'
  describe  command('$HOME/.composer/vendor/bin/drush version').stdout =~ /^Drush Version.*?:.*? 6.7.0( .*?)?$/
        expect(true).to be true
end

#check PHP configuration file location for drupal configuration
control 'drupal-5' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'check PHP configuration file location for drupal configuration'
  describe  command('$HOME/.composer/vendor/bin/drush status').stdout =~ /^PHP configuration.*?:.*? \/etc\/php5\/cli\/php.ini( .*?)?$/
        expect(true).to be true
end

