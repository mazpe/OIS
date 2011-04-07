package OIS::Schema::ResultSet::Advertising;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

=head1 NAME

OIS::Schema::ResultSet::Advertising - ResultSet

=head1 DESCRIPTION

Advertisingss ResultSet

=cut

sub get_advertising_names {
    my $self = shift;
    my $rows;

    $rows = [ map { $_->id => $_->name } $self->all ];

    return $rows;
}



=head1 AUTHOR

Lester Ariel Mesa

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

