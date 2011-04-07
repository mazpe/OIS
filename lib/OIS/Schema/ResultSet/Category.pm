package OIS::Schema::ResultSet::Category;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

=head1 NAME

OIS::Schema::ResultSet::Category - ResultSet

=head1 DESCRIPTION

Categoryss ResultSet

=cut

sub get_category_names {
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

