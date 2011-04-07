package OIS::Form::Name;
use HTML::FormHandler::Moose;
use HTML::FormHandler::Types ( 'NoSpaces', 'WordChars' );
extends 'HTML::FormHandler::Model::DBIC';
use Data::Dumper;

with 'HTML::FormHandler::Render::Simple'; # if you want to render the form

has '+item_class' => ( default => 'Name' );

has '+name' => ( default => 'NameName' );

has '+css_class' => ( default => 'niceform' );

has '+widget_name_space' => ( default => sub { [ 'OIS::Form::Widget' ] } );

has '+widget_wrapper' => ( default => 'MyWrapper' );

has '+widget_tags' => ( default => sub { { wrapper_start => '<dl>',
        wrapper_end => '</dl>' } } );

has_field 'referred_by_id'        => (
    widget              => 'MySelect',
    type                => 'Select',
    label               => 'Referred By',
    empty_select        => '-- Choose one --',
    required_message    => 'You must enter Referred By',
);
has_field 'belongs_to_id'        => (
    widget              => 'MySelect',
    type                => 'Select',
    label               => 'Belongs To',
    empty_select        => '-- Choose one --',
    required_message    => 'You must enter Belongs To',
);
has_field 'identity' => (
    widget              => 'MySelect',
    type                => 'Select',
    label               => 'Identity',
    empty_select        => '-- Choose one --',
    required            => 1,
    required_message    => 'You must select Entity / Individual',
    options             => [
                            { value => 'I', label => 'Individual'},
                            { value => 'E', label => 'Entity'},
                           ]
);
has_field 'r_c' => (
    widget              => 'MySelect',
    type                => 'Select',
    label               => 'R/C',
    empty_select        => '-- Choose one --',
    required            => 1,
    required_message    => 'You must select Residential / Commercial',
    options             => [
                            { value => 'R', label => 'Residential'},
                            { value => 'C', label => 'Commercial'},
                           ]
);
has_field 'type' => (
    widget              => 'MySelect',
    type                => 'Select',
    label               => 'Type',
    empty_select        => '-- Choose one --',
    required            => 1,
    required_message    => 'You must select Type',
    options             => [
                            { value => 'C', label => 'Client'},
                            { value => 'L', label => 'Lead'},
                            { value => 'E', label => 'Employee'},
                            { value => 'V', label => 'Vendor'},
                            { value => 'P', label => 'Partner'},
                           ]
);
has_field 'tax_code_id'        => (
    widget              => 'MySelect',
    type                => 'Select',
    label               => 'Tax Code',
    empty_select        => '-- Choose one --',
    required            => 1,
    required_message    => 'You must select a Tax Code',
);
has_field 'company_name'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'Company',
);
has_field 'first_name'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'First Name',
);
has_field 'middle_name'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'Middle Name',
);
has_field 'last_name'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'Last Name',
);
has_field 'email'        => (
    widget              => 'MyText',
    type                => 'Email',
    label               => 'Email',
);
has_field 'phone'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'Phone',
);
has_field 'phone_2'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'Phone 2',
);
has_field 'fax'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'Fax',
);
has_field 'address_1'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'Address 1',
);
has_field 'address_2'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'Address 2',
);
has_field 'city'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'City',
);
has_field 'state'        => (
    widget              => 'MySelect',
    type                => 'Select',
    label               => 'State',
#    default             => sub { ['FL' => 'Florida'] },
);
has_field 'zip_code'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'Zip Code',
);
has_field 'www'        => (
    widget              => 'MyText',
    type                => 'Text',
    label               => 'Web Site',
);
has_field 'found_us'        => (
    widget              => 'MySelect',
    type                => 'Select',
    label               => 'Found Us',
    required            => 1,
    required_message    => 'You must enter Found Us',
);
has_field 'active' => (
    widget              => 'MySelect',
    type                => 'Select',
    label               => 'Active Status',
    required            => 1,
    required_message    => 'You must select active or inactive ',
    options             => [{ value => '1', label => 'Active'},
                            { value => '0', label => 'Inactive'}]
);
has_field 'submit'      => ( 
    widget              => 'MySubmit',
    type                => 'Submit', 
    value               => 'Submit' 
);

##################################

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
sub options_referred_by_id {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'Name' )->get_name_names;

    return $rows;
}
sub options_belongs_to_id {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'Name' )->get_name_names;

    return $rows;
}
sub options_tax_code_id {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'TaxCode' )->get_taxcode_names;

    return $rows;
}

sub default_identity {
    my $self = shift;

    return "E";
}
sub default_r_c {
    my $self = shift;

    return "C";
}
sub default_type {
    my $self = shift;

    return "L";
}
sub default_tax_code_id {
    my $self = shift;

    return "1";
}
sub default_state {
    my $self = shift;

    return "FL";
}

no HTML::FormHandler::Moose;
1;
