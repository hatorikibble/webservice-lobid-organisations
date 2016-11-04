use Test::More tests => 7;

use strict;
use warnings;
use utf8;

use Encode;

BEGIN {
use_ok( 'WebService::Lobid::Organisation' );
}

my $O = WebService::Lobid::Organisation->new(isil=>'DE-380');

is($O->api_url,'http://lobid.org/', "API-URL found");
is($O->found,'true', "ISIL found");
is($O->name,'Stadtbibliothek Köln',"Name found");
is($O->url,'http://www.stbib-koeln.de/', "URL found");
is($O->wikipedia,'http://de.wikipedia.org/wiki/Stadtbibliothek_Köln',"Wikipedia Page found");

$O = WebService::Lobid::Organisation->new(isil=>'foo');
is($O->found,'false', "ISIL 'foo' not found");