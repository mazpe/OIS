package OIS::Form::Product;
use HTML::FormHandler::Moose;
use HTML::FormHandler::Types ( 'NoSpaces', 'WordChars' );
extends 'HTML::FormHandler::Model::DBIC';
use Data::Dumper;

with 'HTML::FormHandler::Render::Simple'; # if you want to render the form

has '+item_class' => ( default => 'Product' );

has_field 'category_id'        => (
    type                => 'Select',
    label               => 'Category',
    required            => 1,
    required_message    => 'You must enter a Category',
);
has_field 'vendor_id' => (
    type                => 'Select',
    label               => 'Vendor',
    required            => 1,
    required_message    => 'You must select a Vendor',
);
has_field 'sku'        => (
    type                => 'Text',
    label               => 'SKU',
    required            => 1,
    required_message    => 'You must enter a SKU',
);
has_field 'name'        => (
    type                => 'Text',
    label               => 'Name',
    required            => 1,
    required_message    => 'You must enter a Name',
);
has_field 'description'        => (
    type                => 'Text',
    label               => 'Description',
);
has_field 'manufacture'        => (
    type                => 'Text',
    label               => 'Manufacture',
);
has_field 'cost'        => (
    type                => 'Text',
    label               => 'Cost Price',
);
has_field 'list'        => (
    type                => 'Text',
    label               => 'List Price',
);
has_field 'taxable'        => (
    type                => 'Select',
    label               => 'Taxable',
    required            => 1,
    required_message    => 'You must select if its taxable',
    options             => [{ value => '1', label => 'Yes'},
                            { value => '0', label => 'No'}]
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

has_field 'submit' => ( type => 'Submit', value => 'Submit' );

sub options_category_id {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'Category' )->get_category_names;

    return $rows;
}

sub options_vendor_id {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'Vendor' )->get_vendor_names;

    return $rows;
}

no HTML::FormHandler::Moose;
1;

