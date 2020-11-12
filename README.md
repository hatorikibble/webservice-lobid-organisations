<div>
    <a href="https://travis-ci.org/hatorikibble/webservice-lobid-organisations"><img src="https://travis-ci.org/hatorikibble/webservice-lobid-organisations.svg?branch=master"></a>
</div>

# NAME

WebService::Lobid::Organisation - interface to the lobid-Organisations API

# SYNOPSIS

    my $Library = WebService::Lobid::Organisation->new(isil=> 'DE-380');

    if ($Library->status eq 'OK'){
     printf("This Library is called '%s', its homepage is at '%s'
             and it can be found at %f/%f",
             $Library->name, $Library->url, $Library->lat, $Library->long
             );

     if ($Library->has_wikipedia){
       printf("%s has its own wikipedia entry: %s",
         $Library->name, $Library->wikipedia);
       }

     if ($Library->has_multiple_emails){
       print $Library->email->[0];
     }else{
       print $Library->email;
     }
    }else{
       print $Library->error;
    }

# METHODS

- new(isil=>$isil)

    tries to fetch data for the organisation identified by the ISIL `$isil`.
    If an entry is found then the attribute `found` is set to _true_

    If an error occurs, the attribute `status` is set to _Error_ with the error
    message in `$self-`error>. Otherwise `status` is _OK_.

# ATTRIBUTES

currently the following attributes are supported

- **api\_url**

    inherited from [WebService::Lobid](https://metacpan.org/pod/WebService%3A%3ALobid), default is _https://lobid.org/_

- **api\_status**

    inherited from [WebService::Lobid](https://metacpan.org/pod/WebService%3A%3ALobid), _OK_ if `api_url` reachable,
    otherwise `Error`

- **api\_timeout**

    inherited from [WebService::Lobid](https://metacpan.org/pod/WebService%3A%3ALobid), default ist _3_ seconds

- **use\_ssl**

    inherited from [WebService::Lobid](https://metacpan.org/pod/WebService%3A%3ALobid), _true_ if [HTTP::Tiny](https://metacpan.org/pod/HTTP%3A%3ATiny) can use SSL,
    otherwise `false`

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

- **status**

    _OK_ or _Error_

- **error**

    error message, if `$self-`status> is _Error_

# DEPENDENCIES

[HTTP::Tiny](https://metacpan.org/pod/HTTP%3A%3ATiny), [JSON](https://metacpan.org/pod/JSON), [Log::Any](https://metacpan.org/pod/Log%3A%3AAny), [Moo](https://metacpan.org/pod/Moo), [Try::Tiny](https://metacpan.org/pod/Try%3A%3ATiny)

# LOGGING

This module uses the [Log::Any](https://metacpan.org/pod/Log%3A%3AAny) Framework

# AUTHOR

Peter Mayr <pmayr@cpan.org>

# REPOSITORY

The source code is also on GitHub &lt;https://github.com/hatorikibble/webservice-lobid-organisations>. Pull requests and bug reports welcome!

# VERSION

0.005

# LICENCE AND COPYRIGHT

GNU GPL V3

Peter Mayr 2016
