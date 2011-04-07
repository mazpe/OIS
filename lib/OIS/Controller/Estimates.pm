package OIS::Controller::Estimates;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

OIS::Controller::Estimates - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash( 
        clients  => [$c->model('DB::Client')->all],
        template => 'estimates/select.tt2', 
    );
}

sub base :Chained('/') :PathPart('estimates') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
    

}

sub load :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    my $estimate;

    if($id) {

        $c->stash->{estimate_id} = $id;
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
    $c->log->debug($c->stash->{estimate_id});

    $c->stash( is_estimate => 1 );

    return;
}

sub create :Chained('load') :PathPart('create') :Args(0) {
    my ( $self, $c, $estimate_id ) = @_;
    my $row;
    my $form;
    
    $c->log->debug($c->stash->{estimate_id});

    # Set template and form
    $c->stash(
        template    => 'estimates/form.tt2',
        form        => $self->estimate_form,
    );

    #return unless $self->estimate_form->process(
    #    item_id => $estimate_id,
    #    params      => $c->req->parameters,
    #    schema      => $c->model('DB')->schema
    #);

    $c->res->redirect($c->uri_for('list'));

}


=head1 AUTHOR

gbRND

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
