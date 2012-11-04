#!/bin/bash

# $1 mode

# ############################################## Write out Params

# Copy in the image build parameters.  These don't change.
cp /tmp/vagrant-puppet/manifests/params.pp puppet/manifests/

# Configure Server

PUPPET_CMD="sudo puppet apply --modulepath=\":$confdir/modules:$confdir/example42-nextgen\""
if [[ $1 == 'test' ]]; then
  PUPPET_CMD manifests/quicktest.pp
elif [[ $1 == 'prod' ]]; then
  PUPPET_CMD manifests/quickprod.pp
elif [[ $1 == 'dev' ]]; then
  PUPPET_CMD manifests/quickdev.pp
else
  echo "usage:  $0 [ test | prod | dev ]"
fi

