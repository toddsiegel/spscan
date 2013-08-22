# encoding: UTF-8

class Controllers < Hash

  attr_reader :option_parser

  # param [ OptionParser ] option_parser
  def initialize(option_parser = nil)
    if option_parser
      if option_parser.is_a?(CustomOptionParser)
        @option_parser = option_parser
      else
        raise "The parser must be an instance of CustomOptionParser, #{option_parser.class} supplied"
      end
    else
      @option_parser = CustomOptionParser.new
    end
  end

  # param [ Array<Controller> ] controllers
  def register(*controllers)
    controllers.each { |controller| register_controller(controller) }
  end

  def validate_parsed_options(options)
    self.each { |_, controller| controller.validate_parsed_options(options) }
  end

  private

  # param [ Controller ] controller
  def register_controller(controller)
    if controller.is_a?(Controller)
      self[controller.name.to_sym] = controller

      # A controller may not have options
      if controller_options = controller.registered_options
        @option_parser.add(controller_options)
      end
    else
      raise "The argument must be an instance of Controller, #{controller.class} supplied"
    end
  end

end
