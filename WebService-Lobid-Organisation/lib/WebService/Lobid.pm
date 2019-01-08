package WebService::Lobid;

use strict;
use warnings;

use Moo;

has api_url => ( is=> 'ro', default=> 'https://lobid.org/');

1;
