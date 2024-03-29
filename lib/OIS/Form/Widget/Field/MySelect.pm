package OIS::Form::Widget::Field::MySelect;
use Moose::Role;
use Moose::Role;
use namespace::autoclean;

with 'HTML::FormHandler::Widget::Field::Role::SelectedOption';
with 'HTML::FormHandler::Widget::Field::Role::HTMLAttributes';

sub render {
    my $self = shift;
    my $result = shift || $self->result;
    my $id = $self->id;
    my $index = 0;
    my $multiple = $self->multiple;
    my $output = "<dd>";
    $output .= '<select name="' . $self->html_name . qq{" id="$id"};
    my $t;

    $output .= ' multiple="multiple"' if $multiple;
    $output .= qq{ size="$t"} if $t = $self->size;
    $output .= $self->_add_html_attributes;
    $output .= '>';

    if( $self->empty_select ) {
        $t = $self->_localize($self->empty_select);
        $output .= qq{<option value="">$t</option>};
    }

    foreach my $option ( @{ $self->{options} } ) {
        $output .= '<option value="'
            . $self->html_filter($option->{value})
            . qq{" id="$id.$index"};
        my $ffif = $result->fif;
        if ( defined $ffif ) {
            if ( $multiple ) {
                my @fif;
                if ( ref $ffif ) {
                    @fif = @{$ffif};
                }
                else {
                    @fif = ($ffif);
                }
                foreach my $optval (@fif) {
                    $output .= ' selected="selected"'
                        if $self->check_selected_option($option, $optval);
                }
            }
            else {
                $output .= ' selected="selected"'
                    if $self->check_selected_option($option, $ffif);
            }
        }
        $output .= ' selected="selected"'
            if $self->check_selected_option($option);
        my $label = $self->localize_labels ? $self->_localize($option->{label}) : $option->{label};
        $output .= '>' . $self->html_filter($label) . '</option>';
        $index++;
    }
    $output .= '</select>';
    $output .= '</dd>';
    return $self->wrap_field( $result, $output );
}
use namespace::autoclean;
1;
