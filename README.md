# mojolicious-template

### Template for quickly web development, with Perl + Mojolicious + Bootstrap + KiokuDB.


<h2>Features</h2>
* * *

*   Mojolicious 3.7 (or later)

*   Moose

*   KiokuDB + CouchDB

*   Twitter Bootstrap

*   Unified user notification through messages displayed (alert, success, info)

*   User Login with KiokuDB + CouchDB, with salted and hashed passwords.

*   Authentication with Mojolicious::Plugin::Authentication.

* * *

## Notice

If you have never used Mojolicious, I recommend you to begin application development with Mojolicious::Lite,
and refer to [official tutorials](http://mojolicio.us/perldoc/Mojolicious/Lite).

Because this template is not official and can't guarantee quality.

## Usage

### Required

*   perl 5.14 (or later)

*   [CouchDB](http://couchdb.apache.org/) - Running on default settings localhost:5984 (but configurable)

###

### Usage - start development

Please execute the following commands with a console:

	$ git clone git://github.com/reyiyo/mojolicious-template.git
	$ cd mojolicious-template
	$ cpan .
	$ morbo script/mojolicious-template 

Then, let's access with browser: [http://localhost:3000/][1]

So, you will be able to access the web application.

The "morbo" command is launching the "Mojo::Server::Morbo" daemon, with Application (script/example).
 (["Mojo::Server::Morbo"](http://mojolicio.us/perldoc/Mojo/Server/Morbo) is a daemon for development. It is bundled with the Mojolicious framework.)

Enjoy the web development! with perl + Mojolicious :)
please see to: http://mojolicio.us/perldoc
 ([Japanse translation](https://github.com/yuki-kimoto/mojolicious-guides-japanese/wiki))

### How to change the app name (example: "HogeHoge")

You can use the bundled script (rename_batch.pl).

Please execute the following commands with a console:

	$ chmod u+x rename_batch.pl
	$ ./rename_batch.pl
	Please enter your new app name ...: HogeHoge
	Will this do...? [y/n]: y
	...
	Complete. Have fun!

### Configure

Configuration values are stored in a Moose class located at

    lib/MojoliciousTemplate/Configuration.pm


###Display **error/notice/success** messages automatically

* simply push strings into the **$self->session->{error_messages}** array ref, in order to display error messages

 <pre>push @{ $self->session->{error_messages} },  'Error message'</pre>

* same for **notice** or **success** messages:

  <pre>push @{ $self->session->{notice_messages} },  'You look too good to be true';
push @{ $self->session->{success_messages} },  'Success looks good on anybody';</pre>

![Mojolicious/Bootstrap msg examples](https://github.com/tudorconstantin/Mojolicious-Boilerplate/wiki/images/mojo_messages.jpg)

## Files

see wiki page: TBD

## Libraries and materials


### Mojolicious
[https://github.com/kraih/mojo][2]

    This is free software; you can redistribute it and/or modify it under the same terms as the Perl 5 programming language system itself.

###Moose
[https://github.com/moose/moose][3]

    This is free software; you can redistribute it and/or modify it under the same terms as the Perl 5 programming language system itself.

###KiokuDB
[https://github.com/kiokudb/kiokudb][4]

    This is free software; you can redistribute it and/or modify it under the same terms as the Perl 5 programming language system itself.

###CouchDB
[http://couchdb.apache.org/][5]

Copyright © 2013 The Apache Software Foundation.
Licensed under the [Apache License 2.0][6]

###Mojolicious::Plugin::Authentication
[http://search.cpan.org/~madcat/Mojolicious-Plugin-Authentication-1.26/lib/Mojolicious/Plugin/Authentication.pm][13]

    This is free software; you can redistribute it and/or modify it under the same terms as the Perl 5 programming language system itself.

### Bootstrap (Twitter Bootstrap)
[https://github.com/twitter/bootstrap][7]

	Copyright 2012 Twitter, Inc.
	Apache License 2.0 https://github.com/twitter/bootstrap/blob/master/LICENSE

### jQuery - v1.9.1
[http://jquery.com/][8]

	Copyright 2012 jQuery Foundation and other contributors. http://jquery.com/
	MIT License	[https://github.com/jquery/jquery/blob/master/MIT-LICENSE.txt][9]

### Glyphicons Free
[http://glyphicons.com/][10]

	GLYPHICONS FREE are released under the Creative Commons Attribution 3.0 Unported (CC BY 3.0).
	The GLYPHICONS FREE can be used both commercially and for personal use,
	but you must always add a link to glyphicons.com in a prominent place (e.g. the footer of a website),
	include the CC-BY license and the reference to glyphicons.com on every page using GLYPHICONS.

## Authors and license
Sergio Orbe (reyiyo@gmail.com).

This project is inspired by two other. So, many thanks to them

* [mojo_template][11]
* [Mojolicious-Boilerplate][12]



This template is free software; you can redistribute it and/or modify it under the same terms as Perl itself.


  [1]: http://localhost:3000/
  [2]: https://github.com/kraih/mojo
  [3]: https://github.com/moose/moose
  [4]: https://github.com/kiokudb/kiokudb
  [5]: http://couchdb.apache.org/
  [6]: http://www.apache.org/licenses/LICENSE-2.0
  [7]: https://github.com/twitter/bootstrap
  [8]: http://jquery.com/
  [9]: ttps://github.com/jquery/jquery/blob/master/MIT-LICENSE.txt
  [10]: http://glyphicons.com/
  [11]: https://github.com/mugifly/mojo_template
  [12]: https://github.com/tudorconstantin/Mojolicious-Boilerplate
  [13]: http://search.cpan.org/~madcat/Mojolicious-Plugin-Authentication-1.26/lib/Mojolicious/Plugin/Authentication.pm
