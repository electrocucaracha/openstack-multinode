#shellcheck shell=sh
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2023
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

Describe 'undercloud.sh'
    Include undercloud.sh

    Describe '_get_kolla_actions()'
        Parameters
            '13.7.0' 'minimal' 'bootstrap-servers deploy post-deploy'
            '13.7.0' 'complete' 'bootstrap-servers prechecks pull deploy check post-deploy'
            '14.7.0' 'minimal' 'install-deps bootstrap-servers deploy post-deploy'
            '14.7.0' 'complete' 'install-deps bootstrap-servers prechecks pull deploy check post-deploy'
            '15.0.0' 'minimal' 'install-deps bootstrap-servers deploy post-deploy'
            '15.0.0' 'complete' 'install-deps bootstrap-servers prechecks pull deploy post-deploy'
        End
        It 'gets kolla actions to perform'
            When call _get_kolla_actions "$1" "$2"
            The output should eq "$3"
            The status should be success
        End
    End
End
