# encoding: UTF-8

class WPScanInfoController < WPScanController

  def initialize
    super(author: 'WPScanTeam')

    register_options(
      ['-u', '--url TARGET_URL', 'The target url'],
      ['--format [cli,json]', 'The output format'],
      ['-o', '--output FILE', 'Output the results to the file supplied']
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
