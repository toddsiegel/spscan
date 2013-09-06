class VersionMappings

  def initialize(mappings)
    @mappings = mappings
  end

  def version_for(header_value)
    mappings.fetch(header_value) { UnknownVersion.new }
  end

  private

  attr_reader :mappings

end

class UnknownVersion
  def unknown?
    true
  end

  def to_s
    "Unknown"
  end
end


class Version

  def initialize(idenfitier)
    @version_idenfitier = idenfitier
  end

  def unknown?
    false
  end

  def to_s
    version_idenfitier
  end

  private

  attr_reader :version_idenfitier

end