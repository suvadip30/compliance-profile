# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title "/tmp profile"

control "tmp-1.0" do
impact 0.3
title "create /tmp directory"
desc "A /tmp directory must exist"
describe file('/tmp') do
  it{should be directory}
end
end

control 'tmp-1.1' do
impact 0.7
title "/tmp directory owned by root user"
desc "The /tmp directory must be owned by root user"
describe file ('/tmp') do
  it{should be owned by "root"}
end
end
