# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 11 };
use GetterSetter;
ok(1); # If we made it this far, we're ok.

#########################

# Create a object that will use these
package TestGetterSetter;

use GetterSetter;

BEGIN {
	create_getter( 'attribute1', 'attribute2', 'attribute4' );
	create_setter( 'attribute1', 'attribute3' );
}

sub new {
	my $class = shift;
	my $instance = {};
	$instance->{'attribute1'} = 'cow';
	$instance->{'attribute2'} = 'dog';
	$instance->{'attribute3'} = 'cat';
	$instance->{'attribute4'} = 'duck';

	bless( $instance, $class );
	return $instance;
}

package main;

# Test creating the object
my $new_obj = TestGetterSetter->new();
ok( defined( $new_obj ) ); # Created the object;

# Test attribute 1
ok( $new_obj->get_attribute1(), 'cow' ); # Got the value
$new_obj->set_attribute1( 'snake' );
ok(1); # Set the value
ok( $new_obj->get_attribute1(), 'snake' ); # Got new value

# Test attribute 2
ok( $new_obj->get_attribute2(), 'dog' ); # Got second attribute
no strict 'refs';
# set_attribute2 should not be defined
ok( !defined( *{'TestGetterSetter::set_attribute2'} ) );

# Test attribute 3
ok( defined( *{'TestGetterSetter::set_attribute3'} ) );
ok( !defined( *{'TestGetterSetter::get_attribute3'} ) );

# Test attribute 4
ok( $new_obj->get_attribute4(), 'duck' ); # Got fourth attribute
# set_attribute4 should not be defined
ok( !defined( *{'TestGetterSetter::set_attribute4'} ) );
