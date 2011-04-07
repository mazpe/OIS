package OIS::Form::Client::Estimate;
use HTML::FormHandler::Moose;
use HTML::FormHandler::Types ( 'NoSpaces', 'WordChars' );
extends 'HTML::FormHandler::Model::DBIC';
use Data::Dumper;

with 'HTML::FormHandler::Render::Simple'; # if you want to render the form

has '+item_class' => ( default => 'Estimate' );

has_field 'ship_to_id'        => (
    type                => 'Select',
    label               => 'Ship To',
    required            => 1,
    required_message    => 'You must enter a Ship To',
);
has_field 'salesperson_id_1'        => (
    type                => 'Select',
    label               => 'Salesperson 1',
    required            => 1,
    required_message    => 'You must enter a Salesperson 1',
);
has_field 'salesperson_id_2'        => (
    type                => 'Select',
    label               => 'Salesperson 2',
);
has_field 'tax_code_id'        => (
    type                => 'Select',
    label               => 'Tax Code',
);
has_field 'date'        => (
    type                => 'Date',
    label               => 'Date',
    format              => 'yy-mm-dd',
);
has_field 'subtotal'        => (
    type                => 'Text',
    label               => 'Subtotal',
);
has_field 'tax'        => (
    type                => 'Text',
    label               => 'Tax',
);
has_field 'total'        => (
    type                => 'Text',
    label               => 'Total',
);
has_field 'notes'        => (
    type                => 'Text',
    label               => 'Notes',
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
has_field 'client_id'      => (
    type                => 'Hidden',
);

has_field 'submit' => ( type => 'Submit', value => 'Submit' );

sub options_ship_to {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'Client' )->get_client_names;

    return $rows;
}

sub options_salesperson_id_1 {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'Employee' )->get_employee_names;

    return $rows;
}

sub options_salesperson_id_2 {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'Employee' )->get_employee_names;

    return $rows;
}

sub options_tax_code_id {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'TaxCode' )->get_taxcode_names;

    return $rows;
}


no HTML::FormHandler::Moose;
1;

