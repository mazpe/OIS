package OIS::Controller::Clients::Contacts;
use Moose;
use namespace::autoclean;
use OIS::Form::Client::Contact;

BEGIN {extends 'Catalyst::Controller'; }

has 'contact_form' => (
    isa => 'OIS::Form::Client::Contact',
    is => 'ro',
    lazy => 1,
    default => sub { OIS::Form::Client::Contact->new },
);

=head1 NAME

OIS::Controller::Clients::Contacts - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut


sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched CMS::Controller::Admin::Clients::Accounts in Admin::Clients::Accounts.');
}

sub contacts :Chained('/clients/load') :PathPart('contacts') :Args(0) {
    my ( $self, $c ) = @_;
    my $client_id;
    my $contacts;

    $client_id = $c->stash->{client_id};

    $contacts = [$c->model('DB::ClientContact')->search( {
        client_id   => $client_id,
    } )];

    $c->stash(
        template        => 'clients/contacts/list.tt2',
        client          => $c->stash->{client},
        contacts        => $contacts,
    );

}

sub base :Chained('/clients/load') :PathPart('contacts') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

}

sub load :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    my $contact;

    if($id) {

        $c->stash->{id} = $id;
        $contact    = $c->model('DB::ClientContact')->find($id);

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

sub create :Chained('/clients/load') :PathPart('contacts/create') :Args(0) {
    my ( $self, $c, $id ) = @_;
    my $row;
    my $form;
    my $client_id;

    $client_id = $c->stash->{client_id};

    # Set template and form
    $c->stash(
        template    => 'clients/contacts/form.tt2',
        form        => $self->contact_form,
    );

    $c->req->parameters->{client_id} = $c->stash->{client_id};

    return unless $self->contact_form->process(
        item_id => $id,
        params      => $c->req->parameters,
        schema      => $c->model('DB')->schema
    );

    $c->res->redirect( $c->uri_for($self->action_for('contacts'),
            [$client_id])
     );

}

sub delete :Chained('load') :PathPart('delete') :Args(0) {
    my ( $self, $c ) = @_;
    my $contact;
    my $client_id;

    $contact = $c->stash->{contact};

    $client_id = $c->stash->{client_id};

    if ($contact) {

        $contact->delete;

        $c->res->redirect( $c->uri_for($self->action_for('contacts'),
            [$client_id])
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
    my $client_id;
    my $row;
    my $form;

    $client_id = $c->stash->{client_id};
    $id = $c->stash->{id};

    $row = $c->model('DB::ClientContact')->find($id);

    $c->stash(
        template    => 'clients/contacts/form.tt2',
        form        => $self->contact_form,
    );

    # Process form
    $form = $self->contact_form->process (
        item        => $row,
        params      => $c->req->params,
    );

    if ($form) {
        $c->res->redirect( $c->uri_for($self->action_for('contacts'),
            [$client_id])
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
