package OIS::Controller::Clients;
use Moose;
use namespace::autoclean;
use OIS::Form::Client;

BEGIN {extends 'Catalyst::Controller'; }

has 'client_form' => (
    isa => 'OIS::Form::Client',
    is => 'ro',
    lazy => 1,
    default => sub { OIS::Form::Client->new },
);


=head1 NAME

OIS::Controller::Clients - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash(
        clients         => [$c->model('DB::Client')->all],
        template        => 'clients/list.tt2',
    );

}

sub base :Chained('/') :PathPart('clients') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

}

sub load :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    my $client;

    if($id) {

        $c->stash->{client_id} = $id;
        $client    = $c->model('DB::Client')->find($id);

    } else {

        $c->response->status(404);
        $c->detach;

    }

    if ($client) {

        $c->stash->{'client'} = $client;

    } else {

        $c->response->status(404);
        $c->detach;

    }

    return;
}


sub list : Local {
    my ( $self, $c ) = @_;

    $c->stash(clients => [$c->model('DB::Client')->all]);

    $c->stash(template => 'clients/list.tt2');

}
sub create : Local {
    my ( $self, $c, $client_id ) = @_;
    my $row;
    my $form;

    # Set template and form
    $c->stash(
        template    => 'clients/client.tt2',
        form        => $self->client_form,
    );

    return unless $self->client_form->process(
        item_id => $client_id,
        params      => $c->req->parameters,
        schema      => $c->model('DB')->schema
    );

    $c->res->redirect($c->uri_for('list'));

}

sub edit :Chained('load') :PathPart('edit') :Args(0) {
    my ( $self, $c ) = @_;
    my $client_id;
    my $row;
    my $form;

    $client_id = $c->stash->{client_id};

    $row = $c->model('DB::Client')->find($client_id);

    $c->stash(
        is_edit     => 1,
        template    => 'clients/client.tt2',
        form        => $self->client_form,
    );

    # Process form
    $form = $self->client_form->process (
        item        => $row,
        params      => $c->req->params,
    );

    if ($form) {
        $c->res->redirect( $c->uri_for($self->action_for('index')) );
    }
}

sub delete :Chained('load') :PathPart('delete') :Args(0) {
    my ( $self, $c ) = @_;

    my $client = $c->stash->{client};

    if ($client) {

        $client->delete;

        $c->response->redirect(
            $c->uri_for( $self->action_for('index')) . '/' );

    } else {

        $c->response->status(404);
        $c->detach;

    }

    return;
}

=head1 AUTHOR

gbRND

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
