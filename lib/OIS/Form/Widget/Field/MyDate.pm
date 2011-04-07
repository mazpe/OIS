package OIS::Form::Widget::Field::MyDate;
# ABSTRACT: text field rendering widget

use Moose::Role;
use namespace::autoclean;

with 'HTML::FormHandler::Widget::Field::Role::HTMLAttributes';

sub render {
    my $self = shift;
    my $result = shift || $self->result;
    my $t;
    my $output;

    my $rendered = $self->html_filter($result->fif);
    #$output = '<script>$(function() { $( "#datepicker" ).datepicker({ showOn: "button", buttonImage: "images/calendar.gif", buttonImageOnly: true }); });</script>';
    $output = '<script>$(function() { $( "#datepicker" ).datepicker(); });</script>';
    $output .= "<dd>";
    $output .= '<input type="text" name="'
        . $self->html_name . '" id="datepicker"';
    $output .= qq{ size="$t"} if $t = $self->size;
    $output .= qq{ maxlength="$t"} if $t = $self->maxlength;
    $output .= ' value="' . $self->html_filter($result->fif) . '"';
    $output .= $self->_add_html_attributes;
    $output .= ' />';
    $output .= "</dd>";

    return $self->wrap_field( $result, $output );
}

use namespace::autoclean;
1;
