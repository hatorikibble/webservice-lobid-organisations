package WebService::Lobid;

our $VERSION = 0.005;

use strict;
use warnings;

use HTTP::Tiny;
use Moo;

has api_url => ( is => 'rw', default=> 'https://lobid.org/');
has api_status => (is => 'rw');
has api_timeout => (is => 'rw', default => 3);
has use_ssl => ( is => 'rw' );

has status => ( is => 'rw');
has error  => ( is => 'rw');

sub BUILD {
    my $self     = shift;
    my $api_url  = $self->api_url;
    my $response = undef;

    if ( HTTP::Tiny->can_ssl() ) {
        $self->use_ssl("true");
    }
    else {
        $api_url =~ s/https/http/;
        $self->api_url($api_url);
        $self->use_ssl("false");
    }

    $response = HTTP::Tiny->new(timeout => $self->api_timeout)->get( $self->api_url );

    if ( $response->{success} ) {
        $self->api_status("OK");
    }
    else {
        $self->api_status("Error");
        warn sprintf( "API URL %s is not reachable: %s (%s)",
                      $self->api_url, $response->{reason},
                      $response->{status} );
    }
} ## end sub BUILD

1;
