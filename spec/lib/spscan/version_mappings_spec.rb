require_relative '../../../lib/spscan/version_mappings'

describe VersionMappings do

  it "returns an unknown version for an unknown header version" do
    mappings = VersionMappings.new({})
    unknown = mappings.version_for("unknown_header_value")
    unknown.should be_unknown
    unknown.to_s.should == "Unknown"
  end

  it "returns the version for a known header version" do
    expected_version = "1.0"
    mappings = VersionMappings.new("known_header_value" => Version.new(expected_version))
    version = mappings.version_for "known_header_value"
    version.to_s.should == expected_version
    version.should_not be_unknown
  end
end