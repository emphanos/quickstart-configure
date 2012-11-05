#!/bin/bash

# $1 mode

# ############################################## Write out Params

# Copy in the image build parameters.  These don't change.
cp /tmp/vagrant-puppet/manifests/params.pp puppet/manifests/

# Configure Server
PUPPET_DEBUG="--debug --verbose "
PUPPET_CMD="sudo puppet apply $PUPPET_DEBUG --modulepath `pwd`/puppet/modules:`pwd`/puppet/example42-nextgen"

cd puppet/manifests


if [[ $1 == 'test' ]]; then
  $PUPPET_CMD quicktest.pp
elif [[ $1 == 'prod' ]]; then
  $PUPPET_CMD quickprod.pp
elif [[ $1 == 'dev' ]]; then
  $PUPPET_CMD quickdev.pp
else
  echo "usage:  $0 [ test | prod | dev ]"
fi

