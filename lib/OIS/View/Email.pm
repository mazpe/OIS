package OIS::View::Email;

use strict;
use base 'Catalyst::View::Email';

__PACKAGE__->config(
    stash_key => 'email'
);

=head1 NAME

OIS::View::Email - Email View for OIS

=head1 DESCRIPTION

View for sending email from OIS. 

=head1 AUTHOR

gbRND

=head1 SEE ALSO

L<OIS>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
