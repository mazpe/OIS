package OIS;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple

    StackTrace
/;

extends 'Catalyst';

our $VERSION = '0.01';
$VERSION = eval $VERSION;

# Configure the application.
#
# Note that settings in ois.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name            => 'OIS',
    session         => {flash_to_stash => 1},
    default_view    => 'HTML',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,

    'View::Email::Template' => {
        stash_key => 'email',
        default => {
            content_type => 'text/plain',
            charset => 'utf-8',
            view => 'TTEmail',
        },
        sender => {
            mailer => 'SMTP',
            mailer_args => {
                Host     => 'mail.server.com', # defaults to localhost
                username => 'username',
                password => 'password',
            }
        },
        template_prefix => 'email',
    }


);



# Start the application
__PACKAGE__->setup();


=head1 NAME

OIS - Catalyst based application

=head1 SYNOPSIS

    script/ois_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<OIS::Controller::Root>, L<Catalyst>

=head1 AUTHOR

gbRND

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
