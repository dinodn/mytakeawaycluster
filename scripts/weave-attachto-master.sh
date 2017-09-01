#!/bin/bash
weave_launch_master(){
sudo wget -O /usr/local/bin/weave https://github.com/weaveworks/weave/releases/download/latest_release/weave
sudo chmod a+x /usr/local/bin/weave
sudo /usr/local/bin/weave stop && sudo /usr/local/bin/weave launch 10.0.0.101
}
weave_launch_master
