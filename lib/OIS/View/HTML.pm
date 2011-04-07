package OIS::View::HTML;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION  => '.tt2',
    INCLUDE_PATH        => [
        OIS->path_to( 'root', 'src' ),
    ],
    TIMER               => 1,
    WRAPPER             => 'wrapper.tt2',
    render_die => 1,
    CATALYST_VAR => 'c',
);

=head1 NAME

OIS::View::HTML - TT View for OIS

=head1 DESCRIPTION

TT View for OIS.

=head1 SEE ALSO

L<OIS>

=head1 AUTHOR

gbRND

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
