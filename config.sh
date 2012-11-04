#!/bin/bash

# $1 mode

# ############################################## Write out Params

# Copy in the image build parameters.  These don't change.
cp ../quickstart-build/QuickBase/puppet/manifests/params.pp puppet/manifests/

# Configure Server

echo "echo $1"
if [[ $1 == 'test' ]]; then
  echo puppet apply --moduledir="modules" manifests/quicktest.pp
elif [[ $1 == 'prod' ]]; then
  echo puppet apply --moduledir="modules" manifests/quickprod.pp
elif [[ $1 == 'dev' ]]; then
  echo puppet apply --moduledir="modules" manifests/quickdev.pp
else
  echo "usage:  $0 [ test | prod | dev ]"
fi

