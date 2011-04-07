package OIS::Form::Client;
use HTML::FormHandler::Moose;
use HTML::FormHandler::Types ( 'NoSpaces', 'WordChars' );
extends 'HTML::FormHandler::Model::DBIC';
use Data::Dumper;

with 'HTML::FormHandler::Render::Simple'; # if you want to render the form

has '+item_class' => ( default => 'Client' );

has_field 'name'        => (
    type                => 'Text',
    label               => 'Name',
    required            => 1,
    required_message    => 'You must enter a client name',
);
has_field 'status' => (
    type                => 'Select',
    label               => 'Status',
    required            => 1,
    required_message    => 'You must select Customer or Prospect ',
    css_class           => 'form_col_a',
    options             => [{ value => 'P', label => 'Prospect'},
                            { value => 'C', label => 'Customer'},
                            { value => 'E', label => 'Employee'}]
);
has_field 'type' => (
    type                => 'Select',
    label               => 'Type',
    required            => 1,
    required_message    => 'You must select Residential or Commercial ',
    css_class           => 'form_col_a',
    options             => [{ value => 'R', label => 'Residential'},
                            { value => 'C', label => 'Commercial'}]
);
has_field 'phone'        => (
    type                => 'Text',
    label               => 'Phone',
);
has_field 'fax'        => (
    type                => 'Text',
    label               => 'Fax',
);
has_field 'address_1'        => (
    type                => 'Text',
    label               => 'Address 1',
    required            => 1,
    required_message    => 'You must enter an address',
);
has_field 'address_2'        => (
    type                => 'Text',
    label               => 'Address 2',
);
has_field 'city'        => (
    type                => 'Text',
    label               => 'City',
);
has_field 'state'        => (
    type                => 'Select',
    label               => 'State',
    required            => 1,
    required_message    => 'You must enter your State',
);
has_field 'zip_code'        => (
    type                => 'Text',
    label               => 'Zip Code',
);
has_field 'www'        => (
    type                => 'Text',
    label               => 'Web Site',
);
has_field 'found_us'        => (
    type                => 'Select',
    label               => 'Found Us',
    required            => 1,
    required_message    => 'You must enter Found Us',
);
has_field 'referred_by_id'        => (
    type                => 'Select',
    label               => 'Referred By',
    required            => 1,
    required_message    => 'You must enter Referred By',
);
has_field 'active' => (
    type                => 'Select',
    label               => 'Active Status',
    required            => 1,
    required_message    => 'You must select active or inactive ',
    css_class           => 'form_col_a',
    options             => [{ value => '1', label => 'Active'},
                            { value => '0', label => 'Inactive'}]
);

has_field 'submit' => ( type => 'Submit', value => 'Submit' );

sub options_state {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'State' )->get_state_names;

    return $rows;
}

sub options_found_us {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'Advertising' )->get_advertising_names;

    return $rows;
}

sub options_referred_by {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'Client' )->get_client_names;

    return $rows;
}


no HTML::FormHandler::Moose;
1;

