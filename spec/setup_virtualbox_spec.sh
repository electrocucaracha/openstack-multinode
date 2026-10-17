#shellcheck shell=bash
# SPDX-license-identifier: Apache-2.0

Describe 'ci/setup_virtualbox.sh'
    setup() {
        modprobe_calls=0
    }
    Before 'setup'

    uname() {
        echo '6.8.0-test'
    }

    command() {
        if [[ "$*" == '-v /sbin/vboxconfig' ]]; then
            return "$config_status"
        fi
        builtin command "$@"
    }

    sudo() {
        echo "$*"
        if [[ "$1" == 'modprobe' ]]; then
            modprobe_calls=$((modprobe_calls + 1))
            if [[ "$modprobe_calls" == 1 ]]; then
                return "$initial_status"
            fi
            return "$load_status"
        fi
        if [[ "$*" == "$failed_command" ]]; then
            return 1
        fi
    }

    initial_status=1
    config_status=0
    load_status=0
    failed_command=''

    It 'leaves a working module alone'
        initial_status=0
        When run source ci/setup_virtualbox.sh
        The status should be success
        The output should eq 'modprobe vboxdrv'
    End

    It 'installs matching headers and rebuilds using vboxconfig'
        When run source ci/setup_virtualbox.sh
        The status should be success
        The line 4 should eq 'apt-get install -y --no-install-recommends build-essential dkms linux-headers-6.8.0-test'
        The line 5 should eq '/sbin/vboxconfig'
        The line 6 should eq 'modprobe vboxdrv'
    End

    It 'uses DKMS when vboxconfig is unavailable'
        config_status=1
        When run source ci/setup_virtualbox.sh
        The status should be success
        The line 5 should eq 'dkms autoinstall -k 6.8.0-test'
        The line 6 should eq 'modprobe vboxdrv'
    End

    Describe 'repair failures'
        Parameters
            'apt-get update' 3
            'apt-get install -y --no-install-recommends build-essential dkms linux-headers-6.8.0-test' 4
            '/sbin/vboxconfig' 5
            'dkms autoinstall -k 6.8.0-test' 5
        End
        It 'stops when a repair command fails'
            failed_command=$1
            if [[ "$failed_command" == dkms* ]]; then
                config_status=1
            fi
            When run source ci/setup_virtualbox.sh
            The status should be failure
            The lines of output should eq "$2"
        End
    End

    It 'reports a module that still cannot load'
        load_status=1
        When run source ci/setup_virtualbox.sh
        The status should be failure
        The line 6 should eq 'modprobe vboxdrv'
        The stderr should include '::error::Cannot load vboxdrv after rebuilding'
    End
End
