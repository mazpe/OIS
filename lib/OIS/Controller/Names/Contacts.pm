package OIS::Controller::Names::Contacts;
use Moose;
use namespace::autoclean;
use OIS::Form::Name::Contact;

BEGIN {extends 'Catalyst::Controller'; }

has 'contact_form' => (
    isa => 'OIS::Form::Name::Contact',
    is => 'ro',
    lazy => 1,
    default => sub { OIS::Form::Name::Contact->new },
);

=head1 NAME

OIS::Controller::Names::Contacts - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut


sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched CMS::Controller::Admin::Names::Accounts in Admin::Names::Accounts.');
}

sub contacts :Chained('/names/load') :PathPart('contacts') :Args(0) {
    my ( $self, $c ) = @_;
    my $name_id;
    my $contacts;

    $name_id = $c->stash->{name_id};

    $c->log->debug($c->stash->{name}->company_name);

    $contacts = [$c->model('DB::Name')->search( {
        belongs_to_id   => $name_id,
    } )];

    $c->stash(
        template        => 'names/contacts/list.tt2',
        #name1            => $c->stash->{name},
        contacts        => $contacts,
    );

}

sub base :Chained('/names/load') :PathPart('contacts') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

}

sub load :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    my $contact;

    if($id) {

        $c->stash->{id} = $id;
        $contact    = $c->model('DB::NameContact')->find($id);

    } else {

        $c->response->status(404);
        $c->detach;

    }

    if ($contact) {

        $c->stash->{'contact'} = $contact;

    } else {

        $c->response->status(404);
        $c->detach;

    }

    return;
}

sub create :Chained('/names/load') :PathPart('contacts/create') :Args(0) {
    my ( $self, $c, $id ) = @_;
    my $row;
    my $form;
    my $name_id;

    $name_id = $c->stash->{name_id};

    # Set template and form
    $c->stash(
        template    => 'names/contacts/form.tt2',
        form        => $self->contact_form,
    );

    $c->req->parameters->{name_id} = $c->stash->{name_id};

    return unless $self->contact_form->process(
        item_id => $id,
        params      => $c->req->parameters,
        schema      => $c->model('DB')->schema
    );

    $c->res->redirect( $c->uri_for($self->action_for('contacts'),
            [$name_id])
     );

}

sub delete :Chained('load') :PathPart('delete') :Args(0) {
    my ( $self, $c ) = @_;
    my $contact;
    my $name_id;

    $contact = $c->stash->{contact};

    $name_id = $c->stash->{name_id};

    if ($contact) {

        $contact->delete;

        $c->res->redirect( $c->uri_for($self->action_for('contacts'),
            [$name_id])
        );


    } else {

        $c->response->status(404);
        $c->detach;

    }

    return;
}

sub edit :Chained('load') :PathPart('edit') :Args(0) {
    my ( $self, $c ) = @_;
    my $id;
    my $name_id;
    my $row;
    my $form;

    $name_id = $c->stash->{name_id};
    $id = $c->stash->{id};

    $row = $c->model('DB::NameContact')->find($id);

    $c->stash(
        template    => 'names/contacts/form.tt2',
        form        => $self->contact_form,
    );

    # Process form
    $form = $self->contact_form->process (
        item        => $row,
        params      => $c->req->params,
    );

    if ($form) {
        $c->res->redirect( $c->uri_for($self->action_for('contacts'),
            [$name_id])
        );
    }
}


=head1 AUTHOR

gbRND

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
