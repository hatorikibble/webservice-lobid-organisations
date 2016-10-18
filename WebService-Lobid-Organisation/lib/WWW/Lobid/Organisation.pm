package WWW::Lobid::Organisation;

# ABSTRACT: interface to the lobid-Organisations API

=head1 NAME

WWW::Lobid::Organisation - interface to the lobid-Organisations API

=head1 SYNOPSIS

my $Library = WWW::Lobid::Organisation->new(isil=> 'DE-380');

printf("This Library is called '%s' and its homepage is at '%s'",
    $Library->name, $Library->url);

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
use JSON;
use Log::Any;
use LWP::UserAgent;
use Moo;
use Try::Tiny;

extends 'WWW::Lobid';

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
    
    my $ua = LWP::UserAgent->new();
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
     $response = $ua->get($query_string);

    if ($response->is_success) {
      $json_result = $response->decoded_content;  # or whatever
    }
    else {
      $self->log->errorf("Problem accessing the API: %s!",
			 $response->status_line);
      $result_ref->{success} = 0;
      $result_ref->{error_msg} = $response->status_line;
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
       	print $data{$uri}->{'@id'};
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
	    #$self->lat($data{$data{$uri}->{location}->{'@id'}}->{lat});
	    print $uri}->{location}->{'@id'};
	}
    	#print ref($self->email);
    }
    use Data::Dumper;
    print Dumper(%data);
    print $self->lat();
    
}

1;
