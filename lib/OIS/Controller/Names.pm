package OIS::Controller::Names;
use Moose;
use namespace::autoclean;
use OIS::Form::Name;

BEGIN {extends 'Catalyst::Controller'; }

has 'name_form' => (
    isa => 'OIS::Form::Name',
    is => 'ro',
    lazy => 1,
    default => sub { OIS::Form::Name->new },
);


=head1 NAME

OIS::Controller::Names - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash(

        names         => [$c->model('DB::Name')->search( 
            { belongs_to_id => undef } 
        )],
        template        => 'names/list.tt2',
    );

}

sub base :Chained('/') :PathPart('names') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

}

sub load :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    my $name;

    if($id) {

        $c->stash->{name_id} = $id;
        $name    = $c->model('DB::Name')->find($id);

    } else {

        $c->response->status(404);
        $c->detach;

    }

    if ($name) {

        $c->stash->{'name'} = $name;

    } else {

        $c->response->status(404);
        $c->detach;

    }

    return;
}

sub list : Local {
    my ( $self, $c ) = @_;

    $c->stash(names => [$c->model('DB::Name')->all]);

    $c->stash(template => 'names/list.tt2');

}

sub create : Local {
    my ( $self, $c, $name_id ) = @_;
    my $row;
    my $form;

    # Set template and form
    $c->stash(
        template    => 'names/form.tt2',
        form        => $self->name_form,
    );

    return unless $self->name_form->process(
        item_id => $name_id,
        params      => $c->req->parameters,
        schema      => $c->model('DB')->schema
    );

    $c->response->redirect( $c->uri_for( $self->action_for('index')) . '/' );

}

sub edit :Chained('load') :PathPart('edit') :Args(0) {
    my ( $self, $c ) = @_;
    my $name_id;
    my $row;
    my $form;

    $name_id = $c->stash->{name_id};

    $row = $c->model('DB::Name')->find($name_id);

    $c->stash(
        is_name_edit    => 1,
        template        => 'names/form.tt2',
        name_id         => $name_id, 
        form            => $self->name_form,
    );

    # Process form
    $form = $self->name_form->process (
        item        => $row,
        params      => $c->req->params,
    );

    if ($form) {
        $c->res->redirect( $c->uri_for($self->action_for('edit'), [$name_id]) );
    }
}

sub delete :Chained('load') :PathPart('delete') :Args(0) {
    my ( $self, $c ) = @_;

    my $name = $c->stash->{name};

    if ($name) {

        $name->delete;

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
