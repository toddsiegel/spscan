# encoding: UTF-8

class WPScanInfoController < WPScanController

  def initialize
    super(author: 'WPScanTeam')

    register_options(
      ['--url TARGET_URL', '-u', 'The target url'],
      ['--format [cli,json]', 'The output format']
    )
  end

  def validate_parsed_options(options)
    raise 'The url is mandatory' unless options[:url]
    super(options)
  end

  #
  ## Actions
  #
  def scan_start
    @start_time = Time.now
  end

  def scan_stop
    @stop_time = Time.now
    @elapsed = @stop_time - @start_time
  end

end
