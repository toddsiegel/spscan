# encoding: UTF-8

class Controller

  attr_reader :author, :registered_options, :parsed_options

  def initialize(infos = {})
    @author    = infos[:author]
    @format    = 'cli'

    @views_dir = File.expand_path(File.join(
      self.class.instance_method(:initialize).source_location[0], '..', '..' , 'views',
      self.name.downcase
    ))
  end

  def name
    self.class.to_s.gsub(/Controller/, '')
  end

  def allowed_formats
    %w{cli json}
  end

  # param [ Array ] options
  def register_options(*options)
    options.each do |option|
      unless option.is_a?(Array)
        raise "Each option must be an array, #{option.class} supplied"
      end
    end
    @registered_options = options
  end

  def validate_parsed_options(options)
    @parsed_options = options
  end

  # param [ String ] action
  #
  # return [ String ] The rendered result of the action
  def result(action)
    send(action.to_sym)
    render(action)
  end

  # param [ String ] action
  # return [ String ] The rendered action
  def render(action)
    if allowed_formats.include?(@format)
      view = File.join(@views_dir, "#{action}.#{@format}.erb")

      if File.exists?(view)
        ERB.new(File.read(view)).result(binding)
      else
        raise "The file #{view} does not exist"
      end
    end
  end
end
