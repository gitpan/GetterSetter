package GetterSetter;

use 5.006;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Export everything since there is only two methods and most likely
# both with be used. Basically since they are using the module they
# most likely want both imported.
our @EXPORT = qw( create_getter create_setter );
our $VERSION = '0.01';

sub create_getter {
	my @getter_methods = @_;

	my ( $calling_package ) = caller(0);

	no strict 'refs';
	foreach my $getter ( @getter_methods ) {
		my $method_name = $calling_package . '::get_' . $getter;
		unless( defined(*{$method_name}) ) {
			*{$method_name} = sub {
				my $self = $_[0];
				return $self->{$getter};
			}
		}
	}
}

sub create_setter {
	my @setter_methods = @_;

	my ( $calling_package ) = caller(0);

	no strict 'refs';
	foreach my $setter ( @setter_methods ) {
		my $method_name = $calling_package . '::set_' . $setter;
		unless( defined(*{$method_name}) ) {
			*{$method_name} = sub {
				my $self = $_[0];
				$self->{$setter} = $_[1];
			}
		}
	}
}

1;
__END__

=head1 NAME

GetterSetter - Perl module that allows you to specify what attributes
have getters and setters

=head1 SYNOPSIS

	namespace TestGetterSetter;
	use GetterSetter;

	BEGIN {
		create_getter( 'attribute1', 'attribute2', 'attribute4' );
		create_setter( 'attribute1', 'attribute3' );
	}

	sub new {
		my $class = shift;
		my $instance = {};
		$instance->{'attribute1'} = 'cow';
		$instance->{'attriubte2'} = 'dog';
		$instance->{'attribute3'} = 'cat';
		$instance->{'attribute4'} = 'duck';

		bless( $instance, $class );
		return $instance;
	}

	##### Then later in calling code #######

	use TestGetterSetter;

	my $new_obj = TestGetterSetter->new();
	print $new_obj->get_attribute1(); # Should print 'cow'
	$new_obj->set_attribute1( 'snake' );
	print $new_obj->get_attribute1(); # Should now print 'snake'

	print $new_obj->get_attribute2(); # Should print 'dog'
	print $new_obj->get_attribute3(); # Runtime error!!!!
	print $new_obj->get_attribute4(); # Should print 'duck';

	$new_obj->set_attribute3( 'horse' ); # attribute3 is now = to 'horse'

=head1 DESCRIPTION

Will allow getter and setter methods to be easily defined by simply
calling a function in your BEGIN code. It will not overwrite real
functions already in the text of the code to prevent accidental
overwrites of more complex getter and setter methods.

=head2 EXPORT

create_getter - A function you can call in BEGIN to cause the getter
methods to be created

create_setter - A function you can call in BEGIN to cause the setter
methods to be created

=head1 HISTORY

=over 8

=item 0.01

Initial version. Making sure the interface I designed can actually work. :)

=back

=head1 BUGS

None known so far. If you find any please send the AUTHOR a message.

=head1 AUTHOR

Eric Anderson, E<lt>eric.anderson@cordata.netE<gt>

=head1 COPYRIGHT

Copyright 2002 Eric Anderson. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<perl>.

=cut
