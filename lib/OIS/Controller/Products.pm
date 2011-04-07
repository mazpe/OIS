package OIS::Controller::Products;
use Moose;
use namespace::autoclean;
use OIS::Form::Product;

BEGIN {extends 'Catalyst::Controller'; }

has 'product_form' => (
    isa => 'OIS::Form::Product',
    is => 'ro',
    lazy => 1,
    default => sub { OIS::Form::Product->new },
);


=head1 NAME

OIS::Controller::Products - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $products;

    $products = [$c->model('DB::Product')->search(
        undef,
        {
            order_by => { -asc => [ qw/category_id.name sku/ ] },
            join => ['category_id']
        },

     )];

    $c->stash(
        products        => $products,
        template        => 'products/list.tt2',
    );

}

sub base :Chained('/') :PathPart('products') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

}

sub load :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    my $product;

    if($id) {

        $c->stash->{product_id} = $id;
        $product    = $c->model('DB::Product')->find($id);

    } else {

        $c->response->status(404);
        $c->detach;

    }

    if ($product) {

        $c->stash->{'product'} = $product;

    } else {

        $c->response->status(404);
        $c->detach;

    }

    return;
}


sub list : Local {
    my ( $self, $c ) = @_;
    my $products;

    $products = [$c->model('DB::Product')->search(
        undef,
        {
            order_by => { -asc => [ qw/category_id.name sku/ ] },
            join => ['category_id']
        },

     )];

    $c->stash(
        products        => $products,
        template        => 'products/list.tt2',
    );

}

sub create : Local {
    my ( $self, $c, $product_id ) = @_;
    my $row;
    my $form;

    # Set template and form
    $c->stash(
        template    => 'products/form.tt2',
        form        => $self->product_form,
    );

    return unless $self->product_form->process(
        item_id => $product_id,
        params      => $c->req->parameters,
        schema      => $c->model('DB')->schema
    );

    $c->res->redirect($c->uri_for('list'));

}

sub edit :Chained('load') :PathPart('edit') :Args(0) {
    my ( $self, $c ) = @_;
    my $product_id;
    my $row;
    my $form;

    $product_id = $c->stash->{product_id};

    $row = $c->model('DB::Product')->find($product_id);

    $c->stash(
        is_edit     => 1,
        template    => 'products/form.tt2',
        form        => $self->product_form,
    );

    # Process form
    $form = $self->product_form->process (
        item        => $row,
        params      => $c->req->params,
    );

    if ($form) {
        $c->res->redirect( $c->uri_for($self->action_for('index')) );
    }
}

sub delete :Chained('load') :PathPart('delete') :Args(0) {
    my ( $self, $c ) = @_;

    my $product = $c->stash->{product};

    if ($product) {

        $product->delete;

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
