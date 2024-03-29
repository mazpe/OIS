package OIS::Form::Widget::Field::MySubmit;
# ABSTRACT: submit field rendering widget

use Moose::Role;
use namespace::autoclean;

with 'HTML::FormHandler::Widget::Field::Role::HTMLAttributes';

has 'no_render_label' => ( is => 'ro', isa => 'Bool', default => 1 );

sub render {
    my ( $self, $result ) = @_;
    my $output;

    $result ||= $self->result;
#    $output = "<dd>";
    $output .= '<input type="submit" name="';
    $output .= $self->html_name . '"';
    $output .= ' id="' . $self->id . '"';
    $output .= ' value="' . $self->html_filter($self->_localize($self->value)) . '"';
    $output .= $self->_add_html_attributes;
    $output .= ' />';
#   $output .= "</dd>";
    return $self->wrap_field( $result, $output );
}

1;
