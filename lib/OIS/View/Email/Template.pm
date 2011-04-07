package OIS::View::Email::Template;

use strict;
use base 'Catalyst::View::Email::Template';

__PACKAGE__->config(
    stash_key       => 'email',
    template_prefix => ''
);

=head1 NAME

OIS::View::Email::Template - Templated Email View for OIS

=head1 DESCRIPTION

View for sending template-generated email from OIS. 

=head1 AUTHOR

gbRND

=head1 SEE ALSO

L<OIS>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
