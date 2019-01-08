use Test::More tests => 6;

use utf8;

use lib "../lib";

BEGIN {
use_ok( 'WebService::Lobid::Organisation' );
}

my $O = WebService::Lobid::Organisation->new(isil=>'DE-380');
is($O->api_url,'https://lobid.org/', "API-URL found");
is($O->found,'true', "ISIL found");
is($O->name,'Stadtbibliothek Köln',"Name found");
is($O->url,'http://www.stbib-koeln.de/', "URL found");

$O = WebService::Lobid::Organisation->new(isil=>'foo');
is($O->found,'false', "ISIL 'foo' not found");

