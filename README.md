quickstart-configure
====================

Tools for configuring a Quickstart machine.

Uses git submodule from example42.com.  To checkout those modules:

    git clone --recursive URL

Didn't do that and getting errors?

    Puppet::Parser::AST::Resource failed with error ArgumentError: Could not find declared class apache at /var/quickstart/quickstart-configure-live/puppet/modules/

Try this:

    git submodule update --init --recursive
