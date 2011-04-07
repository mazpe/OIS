package OIS::Schema::ResultSet::Name;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

=head1 NAME

OIS::Schema::ResultSet::Name - ResultSet

=head1 DESCRIPTION

Names ResultSet

=cut

sub get_name_names {
    my $self = shift;
    my $individuals;
    my $entities;
    my $rows;

    $individuals = [ map { $_->id => $_->first_name.' '. $_->last_name } 
        $self->search( { identity => 'I' } )
     ];

    $entities = [ map { $_->id => $_->company_name }
        $self->search( { identity => 'E' } )
     ];

    my $more = [ map { $_->id => $_->company_name } 
        $self->search( 
                #company_name    => {'!=', undef},
                #r_c             => 'C',
                [
                    {type            => 'C'},
                    {type            => 'L'}
                ],
        )
    ]; 

    push( @{ $rows }, @{ $entities } );
    push( @{ $rows }, @{ $individuals } );

    return $rows;
}

sub get_employee_names {
    my $self = shift;
    my $rows;

    $rows = [ map { $_->id => $_->first_name.' '. $_->last_name }
        $self->search( { type => 'E' } )
     ];

    return $rows;
}



=head1 AUTHOR

Lester Ariel Mesa

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
