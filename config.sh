#!/bin/bash

# ############################################## Write out Params

# Copy in the image build parameters.  These don't change.
#cp /tmp/vagrant-puppet/manifests/params.pp puppet/manifests/
cp /vagrant/QuickBase/puppet/manifests/params.pp puppet/manifests/

# Configure Server
PUPPET_DEBUG="--debug --verbose"
if [ -z $2 ] ; then 
	PUPPET_DEBUG=
fi

PUPPET_BASE="sudo puppet apply $PUPPET_DEBUG --modulepath `pwd`/puppet/modules:`pwd`/puppet/example42-nextgen"
cd puppet/manifests; 

if [[ $1 == 'test' ]]; then
  PUPPET_CMD="$PUPPET_BASE quicktest.pp"
elif [[ $1 == 'prod' ]]; then
  PUPPET_CMD="$PUPPET_BASE quickprod.pp"
elif [[ $1 == 'dev' ]]; then
  PUPPET_CMD="$PUPPET_BASE quickdev.pp"
else
  echo "usage:  $0 [ test | prod | dev ] [debug]"
fi
echo " ** Puppet command: $PUPPET_CMD"
$PUPPET_CMD

cd ../.. 

