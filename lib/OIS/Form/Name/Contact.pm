package OIS::Form::Name::Contact;
use HTML::FormHandler::Moose;
use HTML::FormHandler::Types ( 'NoSpaces', 'WordChars' );
extends 'HTML::FormHandler::Model::DBIC';
use Data::Dumper;

with 'HTML::FormHandler::Render::Simple'; # if you want to render the form

has '+item_class' => ( default => 'Name' );

has '+name' => ( default => 'NameName' );

has_field 'name'        => (
    type                => 'Text',
    label               => 'Name',
    required            => 1,
    required_message    => 'You must enter a client name',
);
has_field 'title'        => (
    type                => 'Text',
    label               => 'Title',
);
has_field 'email'        => (
    type                => 'Text',
    label               => 'Email',
);
has_field 'phone'        => (
    type                => 'Text',
    label               => 'Phone',
);
has_field 'fax'        => (
    type                => 'Text',
    label               => 'Fax',
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

no HTML::FormHandler::Moose;
1;

