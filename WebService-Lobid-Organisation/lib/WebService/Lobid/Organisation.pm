package WebService::Lobid::Organisation;

# ABSTRACT: interface to the lobid-Organisations API

=head1 NAME

WebService::Lobid::Organisation - interface to the lobid-Organisations API

=head1 SYNOPSIS

my $Library = WebService::Lobid::Organisation->new(isil=> 'DE-380');

printf("This Library is called '%s', its homepage is at '%s' 
        and it can be found at %f/%f",
    $Library->name, $Library->url, $Library->lat, $Library->long);

if ($Library->has_wikipedia){
 printf("%s has its own wikipedia entry: %s",
    $Library->name, $Library->wikipedia);
}

if ($Library->has_multiple_emails){
 print $Library->email->[0];
}else{
 print $Library->email;

=cut

use strict;
use warnings;

use Data::Dumper;

use Encode;
use HTTP::Tiny;
use JSON;
use Log::Any;
use Moo;
use Try::Tiny;

extends 'WebService::Lobid';

has isil => ( is => 'rw', predicate=>1, required => 1);
has name => (is => 'rw', predicate=>1);
has url => (is => 'rw', predicate => 1);
has wikipedia => (is => 'rw', predicate => 1);
has email => (is => 'rw', predicate => 1);
has has_multiple_emails => ( is => 'rw', default => 0);
has long => (is => 'rw', predicate => 1);
has lat => (is => 'rw', predicate => 1);

has log => (
    is      => 'ro',
    default => sub { Log::Any->get_logger },
);



sub BUILD{
    my $self = shift;
    
    my $query_string = undef;
    my $response = undef;
    my $json_result  = undef;
    my $result_ref = undef;
    my %data = ();
    my $email = undef;
    my $uri = sprintf( "%s%s/%s",
		       $self->api_url, "organisation", $self->isil);
    
    $query_string = sprintf( "%s%s?id=%s&format=full",
			     $self->api_url, "organisation", $self->isil);

    $self->log->infof("URL: %s", $query_string);
    $response = HTTP::Tiny->new->get($query_string);

    if ($response->{success}) {
      $json_result = $response->{content};
    }
    else {
      $self->log->errorf("Problem accessing the API: %s!",
			 $response->{status});
      $result_ref->{success} = 0;
      $result_ref->{error_msg} = $response->{status};
      return $result_ref;
    }

    try {
        $result_ref = decode_json($json_result);
    }
    catch {
        $self->log->errorf( "Decoding of response '%s' failed: %s",
            $json_result, $_ );
    };
    foreach my $g (@{$result_ref->[1]->{'@graph'}}){
	$data{$g->{'@id'}} = $g;
    }
    if (exists($data{$uri})){
     
    	$self->name($data{$uri}->{name}) if ($data{$uri}->{name});
    	$self->url($data{$uri}->{url}) if ($data{$uri}->{url});
    	$self->wikipedia($data{$uri}->{wikipedia}) if ($data{$uri}->{wikipedia});
    	if ($data{$uri}->{email}){
    	    $email = $data{$uri}->{email};
    	    if (ref($email) eq 'ARRAY'){ # multiple E-Mail Adresses
    		$self->has_multiple_emails(1);
    		for (my $i=0; $i < scalar(@{$email}); $i++){
    		    $email->[$i] =~ s/^mailto://;
    		}
    	    }else{
		
    		$email =~ s/^mailto://;
		
    	    }
    	    $self->email($email);
    	}
	if ($data{$uri}->{location}){
	    $self->lat($data{$data{$uri}->{location}}->{lat});
	    $self->long($data{$data{$uri}->{location}}->{long});
	}

    }

    
}

1;
