# Copyright (c) 2014-2016 Skytap, Inc.
#
# The MIT License (MIT)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

require File.expand_path("../../base", __FILE__)
require "vagrant-skytap/cap/host_metadata"

describe VagrantPlugins::Skytap::Cap::HostMetadata do
  let(:machine) { double("machine") }

  before do
    stub_request(:get, %r{http://gw/skytap}).to_return(body: '', status: 404)
  end

  describe "host_metadata" do
    it "returns nil if the metadata is not found" do
      expect(described_class.host_metadata(machine)).to be nil
    end

    it "returns the metadata if found" do
      stub_request(:get, %r{http://gw/skytap}).to_return(body: '{"id": 1}', status: 200)
      expect(described_class.host_metadata(machine)).to eq({"id" => 1})
    end
  end
end