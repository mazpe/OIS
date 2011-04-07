package OIS::Form::Name::Estimate;
use HTML::FormHandler::Moose;
use HTML::FormHandler::Types ( 'NoSpaces', 'WordChars' );
extends 'HTML::FormHandler::Model::DBIC';
use Data::Dumper;

with 'HTML::FormHandler::Render::Simple'; # if you want to render the form

has '+item_class' => ( default => 'Estimate' );

has '+widget_name_space' => ( default => sub { [ 'OIS::Form::Widget' ] } );

has '+widget_wrapper' => ( default => 'MyWrapper' );

has '+widget_tags' => ( default => sub { { wrapper_start => '<dl>',
        wrapper_end => '</dl>' } } );

print "hello";

has_field 'ship_to_id'        => (
    widget              => 'MySelect',
    type                => 'Select',
    label               => 'Ship To',
    empty_select        => '-- Choose one --',
    required            => 1,
    required_message    => 'You must enter a Ship To',
);
has_field 'salesperson_id_1'        => (
    widget              => 'MySelect',
    type                => 'Select',
    label               => 'Salesperson 1',
    empty_select        => '-- Choose one --',
    required            => 1,
    required_message    => 'You must enter a Salesperson 1',
);
has_field 'salesperson_id_2'        => (
    widget              => 'MySelect',
    type                => 'Select',
    label               => 'Salesperson 2',
    empty_select        => '-- Choose one --',
);
has_field 'tax_code_id' => (
    widget              => 'MySelect',
    type                => 'Select',
    label               => 'Tax Code',
);
has_field 'taxable' => (
    widget              => 'MySelect',
    type                => 'Select',
    label               => 'Taxable',
    required            => 1,
    required_message    => 'You must select Taxable',
    css_class           => 'form_col_a',
    options             => [{ value => 'Y', label => 'Yes'},
                            { value => 'N', label => 'No'}]
);
has_field 'date'        => (
    widget              => 'MyDate',
    type                => 'Date',
    label               => 'Date',
    format              => 'mm/dd/yy',
);
has_field 'list'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'List',
);
has_field 'discount'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'Discount',
);
has_field 'subtotal'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'Subtotal',
);
has_field 'tax'         => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'Tax',
);
has_field 'total'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'Total',
);
has_field 'profit'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'Tiforp',
);
has_field 'notes'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'Notes',
);
has_field 'active' => (
    widget              => 'MySelect',
    type                => 'Select',
    label               => 'Active Status',
    required            => 1,
    required_message    => 'You must select active or inactive ',
    css_class           => 'form_col_a',
    options             => [{ value => '1', label => 'Active'},
                            { value => '0', label => 'Inactive'}]
);
has_field 'name_id'      => (
    type                => 'Hidden',
);

has_field 'submit' => ( type => 'Submit', value => 'Submit' );

sub options_ship_to_id {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'Name' )->get_name_names;

    return $rows;
}
sub options_salesperson_id_1 {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'Name' )->get_employee_names;

    return $rows;
}
sub options_salesperson_id_2 {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'Name' )->get_employee_names;

    return $rows;
}
sub options_tax_code_id {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'TaxCode' )->get_taxcode_names;

    return $rows;
}

sub default_salesperson_id_1 {
    my $self = shift;

    return "3";
}
sub default_tax_code_id {
    my $self = shift;

    return "1";
}
sub default_notes {
    my $self = shift;

    return "L";
}

no HTML::FormHandler::Moose;
1;

