package OIS::Schema::ResultSet::Employee;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

=head1 NAME

OIS::Schema::ResultSet::Employee - ResultSet

=head1 DESCRIPTION

Employees ResultSet

=cut

sub get_employee_names {
    my $self = shift;
    my $rows;

    $rows = [ map { $_->id => $_->first_name.' '. $_->last_name } $self->all ];

    return $rows;
}



=head1 AUTHOR

Lester Ariel Mesa

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

