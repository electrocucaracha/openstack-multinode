#shellcheck shell=sh
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2023
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

Describe 'commons.sh'
  Include commons.sh

  Describe 'vercmp()'
    Parameters
      '1.1.1' '==' '1.1.1' success
      '1.1.1' '==' '1.1.0' failure
      '1.1.0' '<' '1.1.1' success
      '1.1.1' '<' '1.1.0' failure
      '1.1.1' '<' '1.1.1' failure
      '1.1.1' '<=' '1.1.1' success
      '1.1.0' '<=' '1.1.1' success
      '1.1.1' '<=' '1.1.0' failure
      '1.1.1' '>' '1.1.0' success
      '1.1.0' '>' '1.1.1' failure
      '1.1.1' '>' '1.1.1' failure
      '1.1.1' '>=' '1.1.0' success
      '1.1.1' '>=' '1.1.1' success
      '1.1.0' '>=' '1.1.1' failure
    End
    It 'performs comparation'
      When call vercmp "$1" "$2" "$3"
      The status should be "$4"
    End
    It 'raises error when specified an invalid operator'
      When run vercmp '1.0.0' '!=' '2.0.0'
      The stdout should equal "unrecognised op: !="
      The status should be failure
    End
  End
  Describe 'get_kolla_actions()'
    Parameters
      '13.7.0' 'minimal' 'bootstrap-servers deploy post-deploy'
      '13.7.0' 'complete' 'bootstrap-servers prechecks pull deploy check post-deploy'
      '14.7.0' 'minimal' 'install-deps bootstrap-servers deploy post-deploy'
      '14.7.0' 'complete' 'install-deps bootstrap-servers prechecks pull deploy check post-deploy'
      '15.0.0' 'minimal' 'install-deps bootstrap-servers deploy post-deploy'
      '15.0.0' 'complete' 'install-deps bootstrap-servers prechecks pull deploy post-deploy'
    End
    It 'gets kolla actions to perform'
      When call get_kolla_actions "$1" "$2"
      The output should eq "$3"
      The status should be success
    End
  End
End
