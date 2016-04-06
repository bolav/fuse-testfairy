#!/bin/sh

wget https://free.testfairy.com/sdk/ios/download/latest/
mkdir dl
mv index.html dl/tf.zip
mkdir ios
cd ios
unzip ../dl/tf.zip
