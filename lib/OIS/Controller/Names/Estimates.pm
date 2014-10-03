package OIS::Controller::Names::Estimates;
use Moose;
use namespace::autoclean;
use OIS::Form::Name::Estimate;
use Data::Dumper;

BEGIN {extends 'Catalyst::Controller'; }

has 'estimate_form' => (
    isa => 'OIS::Form::Name::Estimate',
    is => 'ro',
    lazy => 1,
    default => sub { OIS::Form::Name::Estimate->new },
);

=head1 NAME

OIS::Controller::Names::Estimates - Catalyst Controller

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

sub estimates :Chained('/names/load') :PathPart('estimates') :Args(0) {
    my ( $self, $c ) = @_;
    my $name_id;
    my $estimates;

    $name_id = $c->stash->{name_id};

    $estimates = [$c->model('DB::Estimate')->search( {
        name_id   => $name_id,
    } )];

    $c->stash(
        is_name_edit   => 1,
        template        => 'names/estimates/list.tt2',
        estimates        => $estimates,
    );

}

sub base :Chained('/names/load') :PathPart('estimates') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash( is_estimate => 1 );
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

sub create :Chained('/names/load') :PathPart('estimates/create') :Args(0) {
    my ( $self, $c, $id ) = @_;
    my $row;
    my $form;
    my $name_id;
    my $date;
    my ($month, $day, $year);

    $name_id = $c->stash->{name_id};
    
    # Set template and form
    $c->stash(
        products    => [$c->model('DB::Product')->all],
        template    => 'names/estimates/form.tt2',
        form        => $self->estimate_form,
    );

    #$c->req->parameters->{name_id} = $c->stash->{name_id};

    $c->log->debug("NAME ID: ". $name_id);

    return unless $self->estimate_form->process(
        update_field_list   =>  { name_id => { default_over_obj => $name_id } },
        params      => $c->req->parameters,
        item_id     => $id,
        schema      => $c->model('DB')->schema
    );

    $c->res->redirect( $c->uri_for($self->action_for('estimates'),
            [$name_id])
     );

}

sub delete :Chained('load') :PathPart('delete') :Args(0) {
    my ( $self, $c ) = @_;
    my $estimate;
    my $name_id;

    $estimate = $c->stash->{estimate};

    $name_id = $c->stash->{name_id};

    if ($estimate) {

        $estimate->delete;

        $c->res->redirect( $c->uri_for($self->action_for('estimates'),
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
    my $estimate_product;
    my $row;
    my $form;
    my $products;
    my $dvrProducts;
    my $camProducts;
    my $accProducts;

    $name_id = $c->stash->{name_id};
    $id = $c->stash->{id};

    $products = [$c->model('DB::Product')->search( 
        undef,
        {
            order_by => { -asc => [qw/name/] },
        },
    
    )];
    
    $dvrProducts = [$c->model('DB::Product')->search(
        { category_id => 1 },
        {
            order_by => { -asc => [qw/name/] },
        },

    )];

    $camProducts = [$c->model('DB::Product')->search(
        { category_id => 2 },
        {
            order_by => { -asc => [qw/name/] },
        },

    )];

    $accProducts = [$c->model('DB::Product')->search(
        { category_id => 3 },
        {
            order_by => { -asc => [qw/name/] },
        },

    )];


    $row = $c->model('DB::Estimate')->find($id);
    $estimate_product = [$c->model('DB::EstimateProduct')->search( 
        { estimate_id => $id } 
    )];

    $c->stash(
        is_edit             => 1,
        name                => $c->stash->{name},
        estimate_products   => $estimate_product,
        products            => $products,
        dvrProducts         => $dvrProducts,
        camProducts         => $camProducts,
        accProducts         => $accProducts,
        template            => 'names/estimates/form.tt2',
        form                => $self->estimate_form,
    );

    # Process form
    $form = $self->estimate_form->process (
        item        => $row,
        params      => $c->req->params,
    );

    if ($form) {
        $c->res->redirect( $c->uri_for($self->action_for('estimates'),
            [$name_id])
        );
    }
}

sub add_product :Chained('load') :PathPart('add_product') :Args(0) {
    my ( $self, $c ) = @_;
    my $id;
    my $product_id;
    my $row;

    $id = $c->stash->{id};
    $product_id = $c->req->params->{'sku'};
    
    $c->log->debug( $id.' -- '.$product_id );

    $row = $c->model('DB::EstimateProduct')->new(
        { estimate_id => $id, product_id => $product_id }
    );
    $row->insert;
    
    if ($row) {
        $c->res->redirect( $c->uri_for($self->action_for('edit'),
            [$c->stash->{name_id}, $id])
        );
    }
    

}

sub update_estimate :Chained('load') :PathPart('update_estimate') :Args(0) {
    my ( $self, $c ) = @_;
    my $id;
    my $product_id;
    my $row;

    $id = $c->stash->{id};

    my @row_ids = $c->req->params->{rowId};
    my $rows = $c->req->params;

#if ($row_ids[0]) { print "array" } else { print "not" }

 if (ref($c->req->params->{rowId}) eq "ARRAY") {

        my $row_ids_size = @{$row_ids[0]};

        my $x = 0;

        for(my $i = 0; $i < $row_ids_size; $i++) {
        
            $row = $c->model('DB::EstimateProduct')->find(
                { id => $rows->{rowId}->[$x] }
            )->update(
            {
                list            => $rows->{epList}->[$x],
                qty             => $rows->{qty}->[$x],
                list_total      => $rows->{epListTotal}->[$x],
                disc            => $rows->{disc}->[$x],
                disc_per_item   => $rows->{discPerItem}->[$x],
                disc_subtotal   => $rows->{epDisctTotal}->[$x],
                subtotal        => $rows->{epSubTotal}->[$x],
                price_per_item  => $rows->{priceItem}->[$x], 
                profit          => $rows->{epProfit}->[$x], 
                profit_per_item => $rows->{profitItem}->[$x], 
            }
            );

            $x++;
        }

    } else {

       $row = $c->model('DB::EstimateProduct')->find(
            { id => $rows->{rowId} }
        )->update(
        {
            list            => $rows->{epList},
            qty             => $rows->{qty},
            list_total      => $rows->{epListTotal},
            disc            => $rows->{disc},
            disc_per_item   => $rows->{discPerItem},
            disc_subtotal   => $rows->{epDisctTotal},
            subtotal        => $rows->{epSubTotal},
            price_per_item  => $rows->{priceItem},
            profit          => $rows->{epProfit},
            profit_per_item => $rows->{profitItem},
        }
        );


    }

    if ($row) {
        $c->res->redirect( $c->uri_for($self->action_for('edit'),
            [$c->stash->{name_id}, $id])
        );
    }

}


sub del_product :Chained('load') :PathPart('del_product') :Args(0) {
    my ( $self, $c ) = @_;
    my $id;
    my $estimate_id;
    my $row;

    $estimate_id = $c->stash->{id};
    $id = $c->req->params->{'id'};

    $row = $c->model('DB::EstimateProduct')->find($id);
    $row->delete;

    if ($row) {
        $c->res->redirect( $c->uri_for($self->action_for('edit'),
            [$c->stash->{name_id}, $estimate_id])
        );
    }
}

sub print :Chained('load') :PathPart('print') :Args(0) {
    my ( $self, $c ) = @_;
    my $id;
    my $estimate_product;
    my $row;

    $id = $c->stash->{id};

    $row = $c->model('DB::Estimate')->find($id);
    $estimate_product = [$c->model('DB::EstimateProduct')->search(
        { estimate_id => $id }
    )];

    $c->stash(
        is_print            => 1,
        is_edit             => 1,
        name                => $c->stash->{name},
        estimate_products   => $estimate_product,
        template            => 'names/estimates/print.tt2',
    );

}


sub email :Chained('load') :PathPart('email') :Args(0) {
    my ( $self, $c ) = @_;
    my $id;
    my $estimate_product;
    my $row;
    my $name;

    $id = $c->stash->{id};

    $name = $c->stash->{name};
    $row = $c->model('DB::Estimate')->find($id);
    $estimate_product = [$c->model('DB::EstimateProduct')->search(
        { estimate_id => $id }
    )];

    $c->stash(
        is_print            => 1,
        is_edit             => 1,
        name                => $name,
        estimate_products   => $estimate_product,
        template            => 'names/estimates/print.tt2',
    );

    $c->stash->{email} = {
        to          => $name->email,
        from        => 'sales@soflasecuritycameras.com',
        subject     => 'Estimate #'. $row->id . ' - '. $row->notes,
        templates => [
        {
            template        => 'estimate.tt2',
            content_type    => 'text/html',
            charset         => 'utf-8',
            view            => 'TTEmail',
        }
        ],
    };

    my $ok = $c->forward( $c->view('Email::Template') );

    $c->log->debug("verdict: ". $ok);
}


=head1 AUTHOR

gbRND

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
