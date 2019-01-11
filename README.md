<div>
    <a href="https://travis-ci.org/hatorikibble/webservice-lobid-organisations"><img src="https://travis-ci.org/hatorikibble/webservice-lobid-organisations.svg?branch=master"></a>
</div>

# NAME

WebService::Lobid::Organisation - interface to the lobid-Organisations API

# SYNOPSIS

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

# METHODS

- new(isil=>$isil)

    tries to fetch data for the organisation identified by the ISIL `$isil`. If an entry is found then the attribute `found` is set to _true_ 

# ATTRIBUTES

currently the following attributes are supported

- **api\_url** 

    inherited from [WebService::Lobid](https://metacpan.org/pod/WebService::Lobid), default is _https://lobid.org/_

- **api\_status**

    inherited from [WebService::Lobid](https://metacpan.org/pod/WebService::Lobid), _ok_ if `api_url` reachable, otherwise `error`

- **use\_ssl**

    inherited from [WebService::Lobid](https://metacpan.org/pod/WebService::Lobid), _true_ if [HTTP::Tiny](https://metacpan.org/pod/HTTP::Tiny) can use SSL, otherwise `false`

- **found** (true|false)

    indicates if an entry is found

- **isil**

    the [ISIL](https://en.wikipedia.org/wiki/International_Standard_Identifier_for_Libraries_and_Related_Organizations) of the organisation. Has the predicate function _has\_isil_.

- **name**

    Has the predicate function _has\_name_.

- **url**

    Has the predicate function _has\_url_

- **provides**

    Service URL, normally the OPAC, Has the predicate function _has\_provides_

- **addressCountry**

    Has the predicate function _has\_addressCountry_

- **addressLocality**

    The city or town where institution resides. Has the predicate function _has\_addressLocality_

- **postalCode**

    Has the predicate function _has\_postalCoda_

- **streetAddress**

    Has the predicate function _has\_streedAddress_

- **email**

    Has the predicate function _has\_email_. The email address for the instition including a _mailto:_ prefix. A scalar if there ist just one email address, an array reference if there are more than one adresses (in this case `has_multiple_emails` is set to _1_

- **has\_multiple\_emails**

    set to _1_ if there is more than one address in `email`

- **lon**

    The longitude of the place. Has the predicate function _has\_lon_.

- **lat**

    The latitude of the place. Has the predicate function _has\__

# DEPENDENCIES

[HTTP::Tiny](https://metacpan.org/pod/HTTP::Tiny), [JSON](https://metacpan.org/pod/JSON), [Log::Any](https://metacpan.org/pod/Log::Any), [Moo](https://metacpan.org/pod/Moo), [Try::Tiny](https://metacpan.org/pod/Try::Tiny)

# LOGGING

This module uses the [Log::Any](https://metacpan.org/pod/Log::Any) Framework

# AUTHOR

Peter Mayr <pmayr@cpan.org>

# REPOSITORY

The source code is also on GitHub &lt;https://github.com/hatorikibble/webservice-lobid-organisations>. Pull requests and bug reports welcome!

# LICENCE AND COPYRIGHT

GNU GPL V3

Peter Mayr 2016
