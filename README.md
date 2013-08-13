# ExtremeFeedbackDevice

TODO: Write a gem description

## Prepare

To get read-write permissions for the SPI-Device with udev you can add the following rule:

    # /etc/udev/rules.d/99-spidev.rules
    SUBSYSTEM=="spidev", GROUP="spidev", MODE="0660"

For this you first need to create a group spidev _(as root)_:

    $ groupadd spidev

Add your user to the new group _(as root)_:

    $ adduser foo spidev

After this, do a restart or run the following commands _(as root)_:

    $ udevadm control --reload-rules
    $ udevadm trigger --subsystem-match=spidev

## Installation

Add this line to your application's Gemfile:

    gem 'extreme_feedback_device'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install extreme_feedback_device

## Settings

TODO: Write configuration instruction here

The default location for the settings file is: _$HOME/.extreme\_feedback\_device.yml_

If you want to use another settings file, override it with the environment variable _EFD_YML_:

    $ EFD_YML=/etc/extreme_feedback_device.yml extreme_feedback_device run

If you want to use another settings namespace, override it with the environment variable _EFD_NS_:

    $ EFD_NS=production extreme_feedback_device run

### Example

    default:
      jenkins:
        user: api
        token: 0123456789ABCDEF
        url: http://jenkins.example.com/
      infiniti_loop:
        sleep: 5
      pi:
        num_leds: 2
        map_leds:
          i_1: Jenkins - Master
          i_0: Jenkins - Production
      spi:
        device: /dev/spidev0.0

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
