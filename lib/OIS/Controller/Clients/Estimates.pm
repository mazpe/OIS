package OIS::Controller::Clients::Estimates;
use Moose;
use namespace::autoclean;
use OIS::Form::Client::Estimate;

BEGIN {extends 'Catalyst::Controller'; }

has 'estimate_form' => (
    isa => 'OIS::Form::Client::Estimate',
    is => 'ro',
    lazy => 1,
    default => sub { OIS::Form::Client::Estimate->new },
);

=head1 NAME

OIS::Controller::Clients::Estimates - Catalyst Controller

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

sub estimates :Chained('/clients/load') :PathPart('estimates') :Args(0) {
    my ( $self, $c ) = @_;
    my $client_id;
    my $estimates;

    $client_id = $c->stash->{client_id};

    $estimates = [$c->model('DB::Estimate')->search( {
        client_id   => $client_id,
    } )];

    $c->stash(
        template        => 'clients/estimates/list.tt2',
        client          => $c->stash->{client},
        estimates        => $estimates,
    );

}

sub base :Chained('/clients/load') :PathPart('estimates') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

}

sub load :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    my $estimate;

    if($id) {

        $c->stash->{id} = $id;
        $estimate    = $c->model('DB::Estimate')->find($id);

    } else {

        $c->response->status(404);
        $c->detach;

    }

    if ($estimate) {

        $c->stash->{'estimate'} = $estimate;

    } else {

        $c->response->status(404);
        $c->detach;

    }

    return;
}

sub create :Chained('/clients/load') :PathPart('estimates/create') :Args(0) {
    my ( $self, $c, $id ) = @_;
    my $row;
    my $form;
    my $client_id;

    $client_id = $c->stash->{client_id};

    # Set template and form
    $c->stash(
        products    => [$c->model('DB::Product')->all],
        template    => 'clients/estimates/form.tt2',
        form        => $self->estimate_form,
    );

    $c->req->parameters->{client_id} = $c->stash->{client_id};

    return unless $self->estimate_form->process(
        item_id     => $id,
        params      => $c->req->parameters,
        schema      => $c->model('DB')->schema
    );

    $c->res->redirect( $c->uri_for($self->action_for('estimates'),
            [$client_id])
     );

}

sub delete :Chained('load') :PathPart('delete') :Args(0) {
    my ( $self, $c ) = @_;
    my $estimate;
    my $client_id;

    $estimate = $c->stash->{estimate};

    $client_id = $c->stash->{client_id};

    if ($estimate) {

        $estimate->delete;

        $c->res->redirect( $c->uri_for($self->action_for('estimates'),
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

    $row = $c->model('DB::Estimate')->find($id);

    $c->stash(
        products    => [$c->model('DB::Product')->all],
        template    => 'clients/estimates/form.tt2',
        form        => $self->estimate_form,
    );

    # Process form
    $form = $self->estimate_form->process (
        item        => $row,
        params      => $c->req->params,
    );

    if ($form) {
        $c->res->redirect( $c->uri_for($self->action_for('estimates'),
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
