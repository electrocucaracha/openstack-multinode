#shellcheck shell=sh
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2023
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

Describe 'run_kaction.sh'
  Include run_kaction.sh

  Describe '_get_kolla_ansible_cmd()'
    Parameters
      'deploy' 'kolla-ansible deploy --inventory ./samples/aio/hosts.ini'
      'destroy' 'kolla-ansible destroy --inventory ./samples/aio/hosts.ini --yes-i-really-really-mean-it'
    End
    It 'gets kolla-ansible action'
      When call _get_kolla_ansible_cmd "$1"
      The output should eq "$2"
      The status should be success
    End
  End
End
