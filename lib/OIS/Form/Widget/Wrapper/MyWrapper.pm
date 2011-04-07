package OIS::Form::Widget::Wrapper::MyWrapper;
# ABSTRACT: commong methods for widget wrappers

use Moose::Role;

sub render_label {
    my $self = shift;
    return '<dt><label class="label" for="' . $self->id . '">' . $self->html_filter($self->loc_label) . ': </label></dt>';
}

sub render_class {
    my ( $self, $result ) = @_;

    $result ||= $self->result;
    my $class = '';
    if ( $self->css_class || $result->has_errors ) {
        my @css_class;
        push( @css_class, split( /[ ,]+/, $self->css_class ) ) 
            if $self->css_class;
        push( @css_class, 'error' ) if $result->has_errors;
        $class .= ' class="';
        $class .= join( ' ' => @css_class );
        $class .= '"';
    }
    return $class;
}

sub wrap_field {
    my ( $self, $result, $rendered_widget ) = @_;
    my $t;
    my $start_tag = defined($t = $self->get_tag('wrapper_start')) ?
        $t : '<div<%class%>>';
    my $is_compound = $self->has_flag('is_compound');
    my $class  = $self->render_class($result);
    my $output = "\n";

    $start_tag =~ s/<%class%>/$class/g;
    $output .= $start_tag;

    if ( $is_compound ) {
        $output .= '<fieldset class="' . $self->html_name . '">';
        $output .= '<legend>' . $self->loc_label . '</legend>';
    }
    elsif ( !$self->has_flag('no_render_label') && length( $self->label ) > 0 ) {
        $output .= $self->render_label;
    }

    $output .= $rendered_widget;
    $output .= qq{\n<span class="error_message">$_</span>}
        for $result->all_errors;
    $output .= '</fieldset>'
        if $is_compound;

    $output .= defined($t = $self->get_tag('wrapper_end')) ? $t : '</div>';

    return "$output\n";
}

use namespace::autoclean;
1;
